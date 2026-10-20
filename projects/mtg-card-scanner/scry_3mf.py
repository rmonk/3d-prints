#!/usr/bin/env python3
"""Move ScryScanner parts between the Bambu Studio 3MF and STL files.

  scry_3mf.py extract <in.3mf> <outdir>
      Writes <outdir>/scry_<part>.stl for each part, in the part's own
      coordinates (as the 3MF stores the mesh, before the plate transform).

  scry_3mf.py replace <in.3mf> <out.3mf> <part>=<file.stl> ...
      Copies the 3MF, swapping in new meshes for the named parts. Plates,
      placement and print settings are kept.

Parts: body, lid, insert, column, column_2. Uses only the standard library.
"""
import re
import struct
import sys
import zipfile
import xml.etree.ElementTree as ET

MODEL = '3D/3dmodel.model'
SETTINGS = 'Metadata/model_settings.config'
NS = {'m': 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02'}
# Object names in the 3MF's model_settings.config
NAMES = {'Main BOdy.stl': 'body', 'Lid.stl': 'lid', 'Insert.stl': 'insert',
         'Insert Thread.stl': 'column', 'Insert Thread 2.stl': 'column_2'}


def part_meshes(z):
    """Map part name -> (mesh object id, settings object id)."""
    root = ET.fromstring(z.read(MODEL))
    comp = {}
    for o in root.find('m:resources', NS).findall('m:object', NS):
        c = o.find('m:components', NS)
        if c is not None:
            comp[o.get('id')] = c.find('m:component', NS).get('objectid')
    settings = ET.fromstring(z.read(SETTINGS))
    out = {}
    for o in settings.findall('object'):
        name = o.find("metadata[@key='name']").get('value')
        out[NAMES[name]] = (comp[o.get('id')], o.get('id'))
    return out


def read_stl(path):
    data = open(path, 'rb').read()
    tris = []
    if data[:5] == b'solid' and b'facet' in data[:300]:
        v = [tuple(map(float, m.groups())) for m in
             re.finditer(rb'vertex\s+(\S+)\s+(\S+)\s+(\S+)', data)]
        tris = [v[i:i + 3] for i in range(0, len(v), 3)]
    else:
        n = struct.unpack('<I', data[80:84])[0]
        for i in range(n):
            f = struct.unpack('<12f', data[84 + 50 * i:84 + 50 * i + 48])
            tris.append([f[3:6], f[6:9], f[9:12]])
    verts, index, faces = [], {}, []
    for t in tris:
        face = []
        for p in t:
            k = tuple(round(c, 6) for c in p)
            if k not in index:
                index[k] = len(verts)
                verts.append(k)
            face.append(index[k])
        if len(set(face)) == 3:
            faces.append(face)
    return verts, faces


def mesh_xml(verts, faces):
    vs = ''.join('     <vertex x="%.6g" y="%.6g" z="%.6g" />\n' % v for v in verts)
    ts = ''.join('     <triangle v1="%d" v2="%d" v3="%d" />\n' % tuple(f) for f in faces)
    return ('<mesh>\n    <vertices>\n' + vs + '    </vertices>\n    <triangles>\n'
            + ts + '    </triangles>\n   </mesh>')


def extract(src, outdir):
    with zipfile.ZipFile(src) as z:
        root = ET.fromstring(z.read(MODEL))
        meshes = {o.get('id'): o.find('m:mesh', NS)
                  for o in root.find('m:resources', NS).findall('m:object', NS)}
        for part, (mid, _) in part_meshes(z).items():
            m = meshes[mid]
            V = [(v.get('x'), v.get('y'), v.get('z')) for v in m.find('m:vertices', NS)]
            with open('%s/scry_%s.stl' % (outdir, part), 'w') as f:
                f.write('solid %s\n' % part)
                for t in m.find('m:triangles', NS):
                    f.write(' facet normal 0 0 0\n  outer loop\n')
                    for k in ('v1', 'v2', 'v3'):
                        f.write('   vertex %s %s %s\n' % V[int(t.get(k))])
                    f.write('  endloop\n endfacet\n')
                f.write('endsolid %s\n' % part)


def replace(src, dst, swaps):
    with zipfile.ZipFile(src) as z:
        ids = part_meshes(z)
        model = z.read(MODEL).decode()
        settings = z.read(SETTINGS).decode()
        for part, path in swaps.items():
            mid, sid = ids[part]
            verts, faces = read_stl(path)
            # Each mesh object is <object id="N" type="model">\n  <mesh>...</mesh>
            pat = re.compile(r'(<object id="%s" type="model">\s*)<mesh>.*?</mesh>' % mid, re.S)
            model, n = pat.subn(lambda m: m.group(1) + mesh_xml(verts, faces), model, count=1)
            assert n == 1, part
            # Keep the face counts Bambu Studio caches for the object in step
            obj = re.compile(r'(<object id="%s">.*?</object>)' % sid, re.S)
            settings = obj.sub(lambda m: re.sub(r'face_count="\d+"', 'face_count="%d"' % len(faces),
                                                m.group(1)), settings, count=1)
        with zipfile.ZipFile(dst, 'w', zipfile.ZIP_DEFLATED) as out:
            for info in z.infolist():
                data = z.read(info.filename)
                if info.filename == MODEL:
                    data = model.encode()
                elif info.filename == SETTINGS:
                    data = settings.encode()
                out.writestr(info, data)


if __name__ == '__main__':
    cmd = sys.argv[1] if len(sys.argv) > 1 else ''
    if cmd == 'extract' and len(sys.argv) == 4:
        extract(sys.argv[2], sys.argv[3])
    elif cmd == 'replace' and len(sys.argv) > 4:
        replace(sys.argv[2], sys.argv[3], dict(a.split('=', 1) for a in sys.argv[4:]))
    else:
        sys.exit(__doc__)
