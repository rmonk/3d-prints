#!/usr/bin/env python3
"""Extract the parts of ScannerV2.3_profile.3mf as STL files.

  scanner_v2_3mf.py extract <in.3mf> <outdir>
      Writes <outdir>/v2_<part>.stl for each part, in the part's own
      coordinates (as the 3MF stores the mesh, before the plate transform).
      Those are the assembled orientation: +Y up.

Parts: scanner, slide, box_sleeved, box_unsleeved. This 3MF keeps each
mesh in its own file under 3D/Objects/, unlike ScryScanner.3mf, which is
why scry_3mf.py doesn't read it. Uses only the standard library.
"""
import sys
import zipfile
import xml.etree.ElementTree as ET

MODEL = '3D/3dmodel.model'
SETTINGS = 'Metadata/model_settings.config'
NS = {'m': 'http://schemas.microsoft.com/3dmanufacturing/core/2015/02',
      'p': 'http://schemas.microsoft.com/3dmanufacturing/production/2015/06'}
# Object names in the 3MF's model_settings.config, by prefix
NAMES = {'scanner sleeved': 'scanner', 'SlideFor boh': 'slide',
         'box sleeved': 'box_sleeved', 'box unsleeved': 'box_unsleeved'}


def part_name(name):
    for prefix, part in NAMES.items():
        if name.startswith(prefix):
            return part
    raise KeyError(name)


def extract(src, outdir):
    with zipfile.ZipFile(src) as z:
        root = ET.fromstring(z.read(MODEL))
        settings = ET.fromstring(z.read(SETTINGS))
        names = {o.get('id'): part_name(o.find("metadata[@key='name']").get('value'))
                 for o in settings.findall('object')}
        for o in root.find('m:resources', NS).findall('m:object', NS):
            c = o.find('m:components/m:component', NS)
            path = c.get('{%s}path' % NS['p']).lstrip('/')
            sub = ET.fromstring(z.read(path))
            mesh = None
            for so in sub.find('m:resources', NS).findall('m:object', NS):
                if so.get('id') == c.get('objectid'):
                    mesh = so.find('m:mesh', NS)
            V = [(v.get('x'), v.get('y'), v.get('z')) for v in mesh.find('m:vertices', NS)]
            part = names[o.get('id')]
            with open('%s/v2_%s.stl' % (outdir, part), 'w') as f:
                f.write('solid %s\n' % part)
                for t in mesh.find('m:triangles', NS):
                    f.write(' facet normal 0 0 0\n  outer loop\n')
                    for k in ('v1', 'v2', 'v3'):
                        f.write('   vertex %s %s %s\n' % V[int(t.get(k))])
                    f.write('  endloop\n endfacet\n')
                f.write('endsolid %s\n' % part)


if __name__ == '__main__':
    if len(sys.argv) == 4 and sys.argv[1] == 'extract':
        extract(sys.argv[2], sys.argv[3])
    else:
        sys.exit(__doc__)
