# 3D Prints

Parametric OpenSCAD models. Most are window mounts that attach with
mushroom-head suction cups:

- **Antenna clamp:** a bar with two suction cups and a clamp for an 8 mm
  antenna mast. A shorter single-cup version (`cups = 1`) is for lighter
  antennas or as a second support along the same mast.
- **Box holder:** a single suction cup and adjustable jaws for a light
  rectangular object.
- **Bird feeder:** the user's own Mk2 feeder STL, reworked with the
  library cup slots and a clear slide-in window panel.
- **Modular bird feeder:** a new feeder for in-shell sunflower seeds, built
  from five parts: a wall mount, a tray that lifts off, a clear back panel
  locked in by two keys, and a perch. An optional roof and two roof
  brackets can be added.
- **Bird Buddy feeder:** a variant of the modular feeder. A Bird Buddy 2
  camera module sits beside the tray on a window mount of its own, with
  two cups one above the other.
  Its angle can be turned and locked, and a cap over its top keeps rain
  off the USB plug. A 165 × 197 mm solar panel, which
  powers the camera over USB, is the roof. It's bolted to a frame on an
  upper mount with one cup.
- **Bird Buddy on a post:** the Bird Buddy camera screwed to a wooden
  post or board instead of a window. Its cap carries the solar panel on
  a ball joint, which tilts and turns the panel and locks it by hand.
- **Phone holder:** an iPhone 16 Pro in its case (153 × 72 × 11 mm), held
  upright on a shower screen with two suction cups, screen facing out.
  An optional angle adapter turns it 45° so the screen faces left.
- **Tracker holder:** a Heltec Wireless Tracker (Meshtastic) in a
  published enclosure, held upright on a window by one suction cup,
  antenna up and display facing the room. A lock bar keeps the cup's
  knob in its slot, and two feet at the bottom brace it on the glass.
  A TPU shim inside stops the case rattling. It's printed in ASA, for a
  hot car.
- **Tracker case:** a case of our own for a bare Heltec Wireless Tracker
  V1.1, held upright on a window by one suction cup, display facing the
  room. Printed buttons in the lid press RST and USER, the USB-C socket
  is open at the bottom, and the LoRa antenna's SMA pigtail bulkhead goes
  through the top, its inner nut held so it can't turn.

Other projects:

- **Card scanner:** our own MTG card scanner. A phone shelf on a
  telescoping tower holds the camera 130–205 mm above a removable card
  box, clamped at any height.
  Cards are stacked face up in the box, and the stack is pushed out
  through a hole in its floor.
- **MTG card scanner:** "ScryScanner" by BrownBearDesign (MakerWorld),
  with its magnet pockets resized for magnets the user has (see
  `projects/mtg-card-scanner/AGENTS.md`). Also a different scanner,
  `ScannerV2.3_profile.3mf`, which the user has printed: its card slide
  with taller side walls.
- **Pocket utility knife:** "Utility Knife F1 Gen2" (Printables
  1104014), with its lettering filled and a third blade stop that leaves
  the tip about 3 mm out, for box cutting.
- **Hat stretcher:** an adjustable oval form, split front to back and
  spread by a printed turnbuckle, for stretching the band of the user's
  57 cm flat cap. A drop-in brace in each half carries the turnbuckle's
  thrust to the back of the oval.
- **Succulent liner:** a planting insert for La Fermière's terracotta
  yogurt pots, which have no drainage hole. A liner with a perforated
  floor hangs from a collar on the rim, 8 mm above the cup's bottom, so
  runoff collects underneath instead of soaking the roots. The collar's
  skirt has a vine debossed round it.
- **Ibanez bass pot adapter:** the user's STL of an adapter for a short
  pot in an Ibanez bass, kept as is. Beside it, our own adapter of the
  same shape for an A250K pot in a 9.7 mm hole, with a plain bore the
  pot's bushing cuts its thread into.
- **Sword strap holder:** holds a Nerf foam sword on a back strap. The
  blade drops through a short sleeve, and a wider section of the blade
  rests on the sleeve's top. The strap threads through a channel down
  its back, and a snap-in lock bar pinches it there.

Each project's own notes (its files, design decisions, accepted
overhangs, fit checks and tuning notes) are in
`projects/<name>/AGENTS.md`, linked as `CLAUDE.md` beside it, so they
load only when working in that project.

## Layout

The repo holds several projects that share library code.

```
library/               reusable SCAD code shared by every project
  BOSL2/               pinned third-party checkout (see libraries.txt)
  libraries.txt        third-party libraries and their pinned commits
  update_libraries.sh  installs, checks and updates them
  flatten_scad.py      writes a single-file copy of a model, libraries inlined
projects/<name>/       one directory per project: its .scad files and STLs
  AGENTS.md            its notes (CLAUDE.md links to it)
preview/<name>/        rendered PNGs, one subdirectory per project
```

- **Library code:** anything a second project could reuse goes in
  `library/`, not in a project. Projects include it with a path relative to
  the project file: `include <../../library/suction_cup.scad>`.
- **Third-party libraries:** the repo is self-contained. Each one is a git
  checkout in `library/<name>/`, pinned to a commit listed in
  `library/libraries.txt`. Projects include them by relative path, e.g.
  `include <../../library/BOSL2/std.scad>`, never the bare `<BOSL2/...>`
  form, which would silently pick up the system-wide copy in
  `~/.local/share/OpenSCAD/libraries/` instead.
  - **Not committed:** the checkouts are in `.gitignore`; only
    `libraries.txt` is tracked.
  - **`library/update_libraries.sh`:** `install` clones anything missing and
    checks out its pin (run it after a fresh copy of the repo). `check`, the
    default, reports whether each library is at its pin, has local changes,
    and how far it is behind upstream. `update [name]` moves to the latest
    upstream commit and rewrites the pin.
  - **After an update:** run the full verification workflow and compare
    triangle sets against the previous exports, because a library change
    can alter geometry.
  - **Adding one:** add a line to `libraries.txt` (name, git URL, branch,
    commit) and run `install`.
  - **Self-containment check:** render with `HOME` pointed at an empty
    directory so OpenSCAD can't see the user library folder.
- **New projects:** create `projects/<name>/` and `preview/<name>/` with the
  same name.

## Git

- **Commits are signed** with the SSH key `~/.ssh/id_ed25519` (set in the
  repo's local git config). Don't commit with `--no-gpg-sign`.
- **leaktk** scans each commit for secrets through the `pre-commit` hook
  from the user's git template. Don't bypass it with `--no-verify`.
- **safe-chain** wraps package managers (npm, pip and so on) in the
  user's shell. The models have no package dependencies.

## Files

- `library/flatten_scad.py <in.scad> <out.scad>`: inlines every
  `include`/`use`, once each.
  - **Built-in names:** BOSL2 overrides built-ins such as `cube` and
    `translate`, and reaches the real ones through `use <builtins.scad>`.
    One file has one scope, so it renames BOSL2's versions `bosl2_*`
    everywhere except in the `use`d file.
  - **Parameters:** it moves the main file's Customizer parameters ahead
    of the libraries, because a variable keeps the position of its first
    assignment. It drops the libraries' assignments of those names, which
    avoids "overwritten" warnings.
  - **Customizer:** library code goes under `/* [Hidden] */`.
  - **Check:** the output must render the same triangle sets as the
    source with `HOME` pointed at an empty directory.
- `library/shapes.scad`: small shared 2D helpers, currently
  `pointed_circle2d` (the teardrop for sideways holes).
  `suction_cup.scad` includes it.
- `library/suction_cup.scad`: the suction cup library. It holds the cup
  dimensions and the cup T-slot (`cup_slot(open_y)`). Every suction cup
  model `include`s it.
  - Change cup sizes here, not in the models.
  - OpenSCAD's Customizer only lists parameters from the main file, so
    these don't appear there.
- `preview/<project>/<model>_<part>.png`: a `mounted` view, an `all` view
  (every part in print orientation) and one image per part for each model,
  made by the commands under **Previews**.

## Conventions shared by all models

- **Libraries:** the user wants libraries used where possible, to keep the
  code simple. Use BOSL2 for threads and similar standard parts rather than
  writing them by hand.
- **Name clash with BOSL2:** BOSL2 defines `teardrop2d()` with different
  arguments. Because `include` is textual, the last definition of a module
  wins, so local helpers must not reuse BOSL2 names. That's why the shared
  helper is called `pointed_circle2d`.
- **No supports:** every part must print without them. The user is
  sensitive to this, and also to layer lines being stressed across the
  layers.
- **Line width and layer height:** the user slices with **Orca Slicer**
  (Flatpak `com.orcaslicer.OrcaSlicer`, 2.4.2) for a Bambu X1C with a
  0.4 mm nozzle (printer preset "Black Betty"), using 0.45 mm lines and
  the Arachne wall generator. Layer height is 0.28 mm, which the user
  chose for strength (it was 0.2). Thicknesses that lie in the layer plane
  in print (walls, lips, sheets, fins) are a whole number of lines, so
  they slice as whole perimeters with no gap fill.
  - **Formula:** Orca (like PrusaSlicer and Bambu Studio) overlaps
    neighbouring lines, so `n` lines are
    `line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4))` thick, not
    `n * line_w`. With 0.45 mm lines that's a spacing of 0.390 mm at
    0.28 mm layers (0.407 at 0.2). Set `layer_h` to match the slicer: a
    model sized for the wrong layer height slices with only about 75% of
    its wall length at the nominal width.
  - **Checked in Orca at 0.28 mm:** with the user's own 0.28 mm presets,
    the phone holder sliced with 97–98% of its wall length at exactly
    0.45 mm and no gap fill. Sized for 0.2 mm instead, it came out at
    75–78%. The thinner second version (4- to 6-line walls) slices at
    92–94%, still with no gap fill. The tapered fin roots account for
    most of the off-width lines.
  - **Wall loops:** use presets with at least 4 wall loops (e.g. `ABS slow
    start 2026-07-11`). With 3 loops (e.g. `.20 2026-06-04`), Orca fills
    the centre of 7- and 8-line walls (on the first version) with solid infill instead of
    perimeters: 22 m of it against 12 m with 4 loops.
  - **In the models:** use a `lines(n)` function and line-count parameters
    (`wall_lines` and so on), as the phone holder does.
  - **Print height:** a dimension along the print's vertical lands within
    half a layer (0.14 mm) of where it's drawn. That's well inside the
    fit clearances, so vertical lengths aren't rounded to layer
    multiples.
  - **Older projects:** they predate this and haven't been changed.
  - **Exception:** the cup slot floor (`floor_t`, 2.6 mm) is set by the
    knob's neck height, so it stays as it is.
- **Teardrop holes:** holes that lie sideways in the print use
  `pointed_circle2d`, with its point aimed up in the print.
- **Nut slots** open upward in the print, and their walls sit against the
  nut's flats.
- **Every `linear_extrude` needs `convexity = 10`.** Without it the F5
  preview shows false see-through holes, even though the mesh is fine.
- **Model coordinates (mounted orientation):** the glass is at z = 0 and +Z
  points away from it. The cup centre is at x = y = 0.
- **The `part` parameter** selects which part(s) to render. `mounted` shows
  the assembly. Any value the file doesn't recognise, such as `"none"`,
  renders nothing, which is useful when including the file in test scripts.
- **`part = "all"` (the user asked for it in every printable design):**
  every part the file exports, in print orientation and on the bed, laid
  out side by side with gaps between them. Give every new model one.
  - **One of each:** it renders each exported STL once (the box holder's
    two pads are the exception), even where a part is printed twice. It's
    a layout to check and slice from, not always one bed's worth.
  - **Files that reuse parts:** the Bird Buddy variant's `all` has only
    its own parts, and the post's only the post's. The reused parts are in
    the modular file's and the variant's `all`.
  - **Third-party edits:** the pocket knife's and the ScryScanner's
    exports keep the original meshes' frames, which aren't on the bed. Their
    `all` turns each part into print orientation: the ScryScanner's from
    its 3MF's plate placement, the knife's Bottom onto its z = 2 face.
    The Scanner V2.3 file's `all` is only the slide; its stretched body is
    unfinished.
  - **Check:** render `all` with no warnings, with its lowest point at
    z = 0, and with its volume equal to the sum of the parts' exports, so
    no two parts overlap. Both Bird Buddy sides (`buddy_side`) lay out
    clear.

## Hardware and measured dimensions

These came from measuring the user's real parts. Don't change the defaults
without asking.

| Item | Value |
|---|---|
| Suction cup | 61 mm overall diameter |
| Cup knob | 6.3 mm high overall. The head is 3.5 mm high and 14.5 mm in diameter. The neck is 8.5 mm in diameter. |

## Verification workflow

Run these checks after any geometry change. OpenSCAD on this machine is
version 2026.10.05. It was 2021.01 when the earlier projects were made.
PNG previews need the sandbox disabled, or OpenSCAD writes nothing.

1. **Render each part** with `-D 'part="..."'`. Expect no warnings, and
   `Simple: yes` (2021.01) or `Status: NoError` and a manifold top-level
   object (2026.10).
2. **Manifold check:** parse the ASCII STL and confirm every edge is shared
   by exactly two triangles.
3. **Overhang check:** in print orientation, list facets with a z-normal
   below -0.72 that aren't on the bed. Only short spans supported at both
   ends are acceptable. Each project lists the ones it accepts in its
   `AGENTS.md`.
4. **Fit checks:** intersect the parts at each pose. Pass `part="none"` with
   `-D`, because an assignment before `include` gets overwritten.
   Each project lists its poses, clear and overlapping, in its
   `AGENTS.md`.
5. **After changing anything in `library/`:** confirm the antenna clamp's
   geometry (and every other project's) is unchanged by comparing triangle sets, not raw STL bytes,
   because triangle order changes.

6. **Slicer check (optional):** slice the STL with the user's Orca presets
   and count the extrusion by `; FEATURE:` and `; LINE_WIDTH:` in the
   G-code.
   - **Don't touch the real profiles:** copy `system/`, `user/` and
     `printers/` from `~/.var/app/com.orcaslicer.OrcaSlicer/config/OrcaSlicer`
     into the scratchpad and pass that copy as `--datadir`.
   - **Flatten the presets:** the command line needs standalone JSON with
     a `type`. Merge each preset's `inherits` chain, which is found by
     `name` under `system/` and `user/<id>/`. Some preset files start with a
     dot, so include hidden files.
   - **Compatibility:**
     - Give the flattened printer its system parent's name
       (`Bambu Lab X1 Carbon 0.4 nozzle`), and keep `inherits` pointing to
       the system parents. Otherwise Orca reports "process not compatible
       with printer".
     - Set `curr_bed_type` (e.g. `Textured PEI Plate`) so PETG is allowed.
   - **Pick the process preset:** use one at the layer height the model
     is sized for (`layer_h`).
   - **Run:**
     `flatpak run --filesystem=<scratch> --command=orca-slicer com.orcaslicer.OrcaSlicer --datadir <copy> --load-settings "machine.json;process.json" --load-filaments filament.json --arrange 1 --orient 0 --slice 0 --outputdir <out> part.stl`
     with the sandbox disabled. `<out>/result.json` reports errors.

## Exporting

Run from the repo root.

```sh
cd projects/antenna_clamp
for p in body cap lock; do
  openscad -o suction_cup_antenna_clamp_$p.stl -D "part=\"$p\"" suction_cup_antenna_clamp.scad
  openscad -o suction_cup_antenna_clamp_single_$p.stl -D "part=\"$p\"" -D cups=1 suction_cup_antenna_clamp.scad
done
cd ../box_holder
for p in base jaw screw nut pad; do
  openscad -o suction_cup_box_holder_$p.stl -D "part=\"$p\"" suction_cup_box_holder.scad
done
cd ../bird_feeder
for p in feeder panel; do
  openscad -o suction_cup_bird_feeder_$p.stl -D "part=\"$p\"" suction_cup_bird_feeder.scad
done
for p in mount tray panel lock perch roof roof_bracket; do
  openscad -o suction_cup_bird_feeder_modular_$p.stl -D "part=\"$p\"" suction_cup_bird_feeder_modular.scad
done
for p in camera_mount cam_lock_bar camera_collar collar_pin camera_cradle camera_cap cam_pin upper_mount solar_frame; do
  openscad -o suction_cup_bird_feeder_buddy_$p.stl -D "part=\"$p\"" suction_cup_bird_feeder_buddy.scad
done
../../library/flatten_scad.py suction_cup_bird_feeder_buddy.scad suction_cup_bird_feeder_buddy_complete.scad
for p in post_mount post_cap ball stem ball_ring; do
  openscad -o bird_buddy_post_$p.stl -D "part=\"$p\"" bird_buddy_post.scad
done
cd ../phone_holder
openscad -o suction_cup_phone_holder.stl -D 'part="holder"' suction_cup_phone_holder.scad
openscad -o suction_cup_phone_holder_adapter.stl -D 'part="adapter"' suction_cup_phone_holder.scad
cd ../tracker_holder
openscad -o suction_cup_tracker_holder.stl -D 'part="holder"' suction_cup_tracker_holder.scad
openscad -o suction_cup_tracker_holder_lock.stl -D 'part="lock"' suction_cup_tracker_holder.scad
openscad -o suction_cup_tracker_holder_shim.stl -D 'part="shim"' suction_cup_tracker_holder.scad
cd ../tracker_case
for p in base lid lock; do
  openscad -o suction_cup_tracker_case_$p.stl -D "part=\"$p\"" suction_cup_tracker_case.scad
done
cd ../hat_stretcher
for p in half rod nuts brace; do
  openscad -o hat_stretcher_$p.stl -D "part=\"$p\"" hat_stretcher.scad
done
cd ../pocket-utility-knife
for p in bottom top slide; do
  openscad -o pocket_utility_knife_$p.stl -D "part=\"$p\"" pocket_utility_knife.scad
done
cd ../card_scanner
for p in mast sleeve knob shelf base box; do
  openscad -o card_scanner_$p.stl -D "part=\"$p\"" card_scanner.scad
done
cd ../mtg-card-scanner
openscad -o scanner_v2_slide.stl -D 'part="slide"' scanner_v2_extension.scad
cd ../succulent_liner
for p in liner collar; do
  openscad -o succulent_liner_$p.stl -D "part=\"$p\"" succulent_liner.scad
done
cd ../ibanez-bass-pot-adapter
openscad -o a250k_pot_adapter.stl -D 'part="adapter"' a250k_pot_adapter.scad
cd ../sword_holder
openscad -o sword_strap_holder.stl -D 'part="holder"' sword_strap_holder.scad
openscad -o sword_strap_holder_lock.stl -D 'part="lock"' sword_strap_holder.scad
openscad -o sword_strap_holder_test.stl -D 'part="test"' sword_strap_holder.scad
cd ../..
```

## Previews

Re-render the images after a geometry change. Run from the repo root with
the sandbox disabled.

```sh
# optional 5th argument: one more -D assignment
r() { openscad -o preview/$1/$3.png -D "part=\"$4\"" ${5:+-D "$5"} --imgsize=1200,900 \
        --autocenter --viewall --colorscheme=Tomorrow projects/$1/$2.scad; }
for p in mounted all body cap lock; do
  r antenna_clamp suction_cup_antenna_clamp antenna_clamp_$p $p
  r antenna_clamp suction_cup_antenna_clamp antenna_clamp_single_$p $p cups=1
done
for p in mounted all base jaw screw nut pad; do r box_holder suction_cup_box_holder box_holder_$p $p; done
for p in mounted all feeder panel; do r bird_feeder suction_cup_bird_feeder bird_feeder_$p $p; done
for p in mounted all mount tray panel lock perch roof roof_bracket; do
  r bird_feeder suction_cup_bird_feeder_modular bird_feeder_modular_$p $p
done
for p in mounted all camera_mount cam_lock_bar camera_collar collar_pin camera_cradle camera_cap cam_pin upper_mount solar_frame; do
  r bird_feeder suction_cup_bird_feeder_buddy bird_feeder_buddy_$p $p
done
for p in mounted all post_mount post_cap ball stem ball_ring; do
  r bird_feeder bird_buddy_post bird_buddy_post_$p $p
done
for p in mounted all holder adapter mounted_angled; do r phone_holder suction_cup_phone_holder phone_holder_$p $p; done
for p in mounted all half rod nuts brace; do r hat_stretcher hat_stretcher hat_stretcher_$p $p; done
for p in mounted all mast sleeve knob shelf base box; do r card_scanner card_scanner card_scanner_$p $p; done
r card_scanner card_scanner card_scanner_mounted_low mounted cam_h=130
for p in mounted all holder lock shim; do r tracker_holder suction_cup_tracker_holder tracker_holder_$p $p; done
for p in mounted all base lid lock; do r tracker_case suction_cup_tracker_case tracker_case_$p $p; done
for p in mounted all liner collar; do r succulent_liner succulent_liner succulent_liner_$p $p; done
for p in mounted all; do r ibanez-bass-pot-adapter a250k_pot_adapter a250k_pot_adapter_$p $p; done
for p in mounted all holder lock test; do r sword_holder sword_strap_holder sword_strap_holder_$p $p; done
for p in mounted all bottom top slide; do
  r pocket-utility-knife pocket_utility_knife pocket_utility_knife_$p $p
done
r pocket-utility-knife pocket_utility_knife pocket_utility_knife_mounted_retracted mounted 'view_stop="retracted"'
r pocket-utility-knife pocket_utility_knife pocket_utility_knife_mounted_extended mounted 'view_stop="extended"'
```

## Tuning notes for the user

- **Cups:** if they're hard to slide in, increase `slot_clearance` in
  `library/suction_cup.scad`.
- **Everything else:** in each project's `AGENTS.md`.
