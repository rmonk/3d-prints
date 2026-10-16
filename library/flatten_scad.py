#!/usr/bin/env python3
"""Flatten an OpenSCAD file and everything it includes into one file.

    library/flatten_scad.py <input.scad> <output.scad>

Each `include <...>` is replaced by the file's text, once; a file included
again is skipped, as the definitions are already there. A `use <...>` file
is inlined too.

BOSL2 replaces some built-in modules (cube, cylinder, translate and so on)
with its own versions, and reaches the real ones through
`use <builtins.scad>`, which has its own scope. A single file has only one
scope, so the replacements are renamed `bosl2_<name>` everywhere except in
`use`d files, which then still reach the built-ins. Everything else calls the
same modules it did before, so the geometry doesn't change.

The main file's parameters move ahead of the libraries, and the libraries'
assignments of any variable the main file sets again are dropped: in one
file a variable keeps the position of its first assignment, and reassigning
it warns. Customizer tab comments in
included files are removed and each included file starts with
`/* [Hidden] */`, so the Customizer only lists the main file's parameters.
"""
import os
import re
import sys

INCLUDE = re.compile(r'^\s*(include|use)\s*<([^>]+)>\s*;?\s*$')
TAB = re.compile(r'^\s*/\*\s*\[[^\]]*\]\s*\*/\s*$')
BUILTIN_MODULES = {
    'cube', 'sphere', 'cylinder', 'polyhedron', 'square', 'circle', 'polygon',
    'text', 'import', 'linear_extrude', 'rotate_extrude', 'surface', 'translate',
    'rotate', 'scale', 'resize', 'mirror', 'multmatrix', 'color', 'offset',
    'hull', 'minkowski', 'union', 'difference', 'intersection', 'render',
    'projection', 'roof',
}


class Chunk:
    def __init__(self, text, used, main):
        self.text, self.used, self.main = text, used, main


def flatten(path, seen, chunks, top, used=False, main=False):
    path = os.path.realpath(path)
    if path in seen:
        return
    seen.add(path)
    base = os.path.dirname(path)
    out = []
    in_block = False

    def emit():
        if out:
            chunks.append(Chunk(''.join(out), used, main))
            out.clear()

    if not main:
        out.append(f'\n/* [Hidden] */\n// ----- {os.path.relpath(path, top)} -----\n')
    for line in open(path, encoding='utf-8'):
        # include lines inside block comments are documentation
        if not in_block:
            m = INCLUDE.match(line)
            if m:
                emit()
                flatten(os.path.join(base, m.group(2)), seen, chunks, top,
                        used=used or m.group(1) == 'use')
                continue
            if not main and TAB.match(line):
                continue
        code = line.split('//', 1)[0]
        opens, closes = code.rfind('/*'), code.rfind('*/')
        if opens > closes:
            in_block = True
        elif closes > opens:
            in_block = False
        out.append(line)
    emit()


def calls(names):
    return re.compile(r'(?<![\w$.])(' + '|'.join(names) + r')(\s*\()')


def main():
    src, dst = sys.argv[1], sys.argv[2]
    chunks = []
    flatten(src, set(), chunks, os.path.dirname(os.path.realpath(src)), main=True)
    text = ''.join(c.text for c in chunks)

    # built-in modules that an included file redefines and a used file
    # calls, expecting the built-in
    defined = set(re.findall(r'^\s*module\s+([A-Za-z_]\w*)\s*\(', text, re.M))
    used_text = ''.join(c.text for c in chunks if c.used)
    shadowed = sorted(n for n in defined & BUILTIN_MODULES if calls([n]).search(used_text))
    if shadowed:
        call = calls(shadowed)
        for c in chunks:
            if not c.used:
                c.text = call.sub(r'bosl2_\1\2', c.text)

    # Variables the main file sets again. In one file a variable keeps the
    # position of its first assignment, which included code relies on, and
    # reassigning it warns. So the main file's parameters (literal values,
    # from its first Customizer tab to its Hidden tab) move ahead of the
    # libraries, along with anything else it reassigns, and the libraries'
    # assignments of the same names are dropped.
    mains = [c for c in chunks if c.main]
    rest = mains[-1]
    lines = rest.text.splitlines(keepends=True)
    tabs = [i for i, l in enumerate(lines) if TAB.match(l)]
    hidden = [i for i in tabs if 'Hidden' in lines[i]]
    start = tabs[0] if tabs else 0
    end = hidden[0] if hidden else start
    params, after = lines[start:end], lines[:start] + lines[end:]
    lib_text = ''.join(c.text for c in chunks if not c.main)
    lib_vars = set(re.findall(r'^([A-Za-z_]\w*)\s*=', lib_text, re.M))
    assign_line = re.compile(r'^([A-Za-z_]\w*)\s*=\s*([^;]*);')
    for l in params:
        m = assign_line.match(l)
        if m and re.search(r'[A-Za-z_]', re.sub(r'"[^"]*"|\btrue\b|\bfalse\b', '', m.group(2))):
            sys.exit(f'parameter is not a literal, so it can\'t move ahead: {l.strip()}')
    moved = []
    for i, l in enumerate(after):
        m = assign_line.match(l)
        if m and m.group(1) in lib_vars:
            moved.append(l)
            after[i] = ''
    rest.text = ''.join(after)
    main_vars = set(re.findall(r'^([A-Za-z_]\w*)\s*=', ''.join(params + moved), re.M))
    if main_vars:
        assign = re.compile(r'^(' + '|'.join(sorted(main_vars)) + r')\s*=[^;\n]*;[^\n]*\n', re.M)
        for c in chunks:
            if not c.main:
                c.text = assign.sub('', c.text)
    hoisted = Chunk(''.join(params) + ('/* [Hidden] */\n' + ''.join(moved) if moved else ''), False, True)
    chunks.insert(1 if len(mains) > 1 else 0, hoisted)

    header = (f'// Generated by library/flatten_scad.py from {os.path.basename(src)},\n'
              f'// with every included library inlined. Don\'t edit it; edit the\n'
              f'// source and run, from the repo root:\n'
              f'//   library/flatten_scad.py {os.path.relpath(src)} {os.path.relpath(dst)}\n')
    if shadowed:
        header += f'// Library versions of built-ins renamed: bosl2_{{{", ".join(shadowed)}}}\n'
    with open(dst, 'w', encoding='utf-8') as f:
        f.write(header + '\n' + ''.join(c.text for c in chunks))


if __name__ == '__main__':
    main()
