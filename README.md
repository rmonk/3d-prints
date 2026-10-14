# 3D Prints

Parametric [OpenSCAD](https://openscad.org/) models, mostly window mounts
that attach with mushroom-head suction cups. Every part prints without
supports.

| Project | What it is |
|---|---|
| [`antenna_clamp`](projects/antenna_clamp) | Two-cup bar with a hook clamp for an 8 mm antenna mast |
| [`box_holder`](projects/box_holder) | One-cup holder with screw-adjusted jaws for a light rectangular object |
| [`bird_feeder`](projects/bird_feeder) | A reworked suction cup bird feeder, plus a modular in-shell sunflower feeder with optional roof |
| [`phone_holder`](projects/phone_holder) | Shower-screen holder for an iPhone 16 Pro in its case, with a 45° angle adapter |
| [`hat_stretcher`](projects/hat_stretcher) | Adjustable oval form with a printed turnbuckle for stretching a flat cap |

Ready-to-print STLs are in each project directory, already in print
orientation. Rendered previews are in [`preview/`](preview).

## Setup

Shared code lives in [`library/`](library). Third-party libraries (BOSL2)
aren't committed; they're cloned at pinned commits:

```sh
library/update_libraries.sh install
```

Then open a `.scad` file in OpenSCAD and pick a part with the `part`
parameter in the Customizer.

## Docs

[`AGENTS.md`](AGENTS.md) holds the design notes, measured dimensions,
print settings, verification workflow and export commands.
