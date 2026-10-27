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
  **MTG card scanner** below). Also a different scanner,
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

## Layout

The repo holds several projects that share library code.

```
library/               reusable SCAD code shared by every project
  BOSL2/               pinned third-party checkout (see libraries.txt)
  libraries.txt        third-party libraries and their pinned commits
  update_libraries.sh  installs, checks and updates them
  flatten_scad.py      writes a single-file copy of a model, libraries inlined
projects/<name>/       one directory per project: its .scad files and STLs
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
  user's shell. This repo has no package dependencies; if one is ever
  added, install it through the wrapped commands.

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
- `projects/antenna_clamp/`:
  - `suction_cup_antenna_clamp.scad`: the antenna clamp.
  - `suction_cup_antenna_clamp_{body,cap,lock}.stl`: exported parts,
    already in print orientation.
  - `suction_cup_antenna_clamp_single_{body,cap,lock}.stl`: the
    single-cup version's parts (`-D cups=1`), in print orientation.
  - `suction_cup_antenna_clamp.stl`: a combined export the user made. It
    isn't generated by the workflow below.
- `projects/box_holder/`:
  - `suction_cup_box_holder.scad`: the box holder. Its threads use
    `library/BOSL2`.
  - `suction_cup_box_holder.stl`: a combined export.
- `projects/bird_feeder/`:
  - `suction_cup_bird_feeder_original.stl`: the user's feeder, designed in
    another CAD tool. `suction_cup_bird_feeder.scad` imports it, by a path
    relative to the .scad file, and edits it. Don't change this file.
  - `suction_cup_bird_feeder.scad` and
    `suction_cup_bird_feeder_{feeder,panel}.stl`: the reworked feeder and
    its exported parts.
  - `suction_cup_bird_feeder_modular.scad` and
    `suction_cup_bird_feeder_modular_{mount,tray,panel,lock,perch,roof,roof_bracket}.stl`:
    the modular feeder and its exported parts.
  - `suction_cup_bird_feeder_buddy.scad` and
    `suction_cup_bird_feeder_buddy_{camera_mount,cam_lock_bar,camera_collar,collar_pin,camera_cradle,camera_cap,cam_pin,upper_mount,solar_frame}.stl`:
    the Bird Buddy variant and its new parts (for `buddy_side = 1`). It
    `include`s the modular file and reuses its mount, tray, panel, keys
    and perch unchanged.
    - **`modular_output`:** the modular file renders its parts only when
      this is true. The variant sets it to false after the include.
    - **`buddy_output`:** the same for the variant. The post version sets
      it to false.
    - **Names:** the variant must not reuse a variable or module name from
      the modular file or the library. The intended overrides are
      `part`, `modular_output`, `roof_pitch`, `roof_headroom` and
      `roof_back_gap`.
      - **Why:** OpenSCAD silently uses the last value everywhere, so a
        clash changes the reused parts. A `post_d` for the lock pin's
        posts once changed the tray's corner posts.
      - **Check:** the reused parts' triangle sets must match the modular
        file's own renders.
  - `suction_cup_bird_feeder_buddy_complete.scad`: a generated
    single-file copy of the variant with the suction cup library and
    the modular file inlined (about 66 kB), so it can be opened or
    exported anywhere. Don't edit it. Regenerate it after any change to
    the variant or what it includes (see **Exporting**).
  - `bird_buddy_post.scad` and
    `bird_buddy_post_{post_mount,post_cap,ball,stem,ball_ring}.stl`: the
    Bird Buddy camera on a wooden post. It `include`s the variant, and
    BOSL2 for the ball joint's thread. It reuses the variant's collar,
    collar pin, cradle and lock pin; print those from the variant's STLs.
    - **Names:** new names start `wp_`. The intended overrides are `part`,
      `buddy_output`, `cam_yaw`, `cam_z`, `cap_down`, `cap_wall_lines` and
      `cap_eave`.
    - **Reused parts:** rendered from this file they don't match the
      variant's STLs. `cam_z` moves the collar, and BOSL2's `cylinder`
      facets a few of the cradle's circles differently. So the file
      doesn't offer them as parts, and the fit checks also run against the
      variant's STLs.
  - `Suction Cup Bird Feeder Mk2.stl`: an incomplete export of the feeder
    (only one keyhole plate). Not used.
- `projects/phone_holder/`:
  - `suction_cup_phone_holder.scad`: the phone holder. Uses `library/BOSL2`.
  - `suction_cup_phone_holder.stl`: the holder, in print orientation.
  - `suction_cup_phone_holder_adapter.stl`: the angle adapter's two
    blocks, in print orientation.
- `projects/tracker_holder/`:
  - `suction_cup_tracker_holder.scad`: the tracker holder. Uses
    `library/BOSL2`.
  - `suction_cup_tracker_holder.stl`: the holder, in print orientation.
  - `suction_cup_tracker_holder_lock.stl`: the lock bar, flat.
  - `suction_cup_tracker_holder_shim.stl`: the TPU anti-rattle shim, flat.
  - The enclosure itself isn't in the repo. It's "Heltec Tracker LoRa
    Meshtastic Enclosure V3" on Printables (model 1204874), licensed CC
    BY-NC, which doesn't fit this repo's CC BY-SA. Download its STLs to
    run the fit checks against the real case.
- `projects/tracker_case/`:
  - `suction_cup_tracker_case.scad`: the tracker case. Uses
    `library/BOSL2`.
  - `suction_cup_tracker_case_{base,lid,lock}.stl`: exported parts, in
    print orientation. The lock bar is the tracker holder's, triangle
    for triangle.
- `projects/hat_stretcher/`:
  - `hat_stretcher.scad`: the hat stretcher. Uses `library/BOSL2` and
    `library/shapes.scad`.
  - `hat_stretcher_{half,rod,nuts,brace}.stl`: exported parts, in print
    orientation. Print the half and the brace twice.
- `projects/pocket-utility-knife/`:
  - `{Bottom,Top,Slide} - 0.4 PETG or PC.stl`: the original parts. Don't
    change them.
  - `pocket_utility_knife.scad`: imports them and edits the Bottom.
  - `pocket_utility_knife_{bottom,top,slide}.stl`: exported parts, in the
    originals' frame (not on the bed: the Bottom prints on its z = 2
    face, the Top and Slide on their lowest faces; `part="all"` shows
    them so). The top and slide are the originals unchanged.
  - **Not committed:** the project's `.gitignore` keeps every `.stl` and
    `.3mf` out of git, because the design's licence hasn't been checked.
- `projects/card_scanner/`:
  - `card_scanner.scad`: the card scanner. Uses `library/shapes.scad`.
  - `card_scanner_{mast,sleeve,knob,shelf,base,box}.stl`: exported parts,
    in print orientation. The shelf STL serves all three positions and
    every height.
- `projects/succulent_liner/`:
  - `succulent_liner.scad`: the succulent liner. Plain OpenSCAD, no
    libraries.
  - `succulent_liner_{liner,collar}.stl`: exported parts, in print
    orientation.
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
| Antenna rod | 8 mm diameter at a narrow section that's more than 30 mm long. The antenna is larger at both ends. |
| Antenna clamp bolt | One M3 bolt, 13–18 mm long (14 or 16 mm recommended), plus one M3 nut |
| Box holder object | 60–65 mm wide and 20–25 mm thick. It's a light rectangular prism, used indoors. |
| La Fermière terracotta pot | 56 mm inside, 68 mm outside at the rim, 69 mm deep inside (first measured as 44). Straight walls that curve inward over the bottom couple of mm. |

## Antenna clamp: design and why it ended up this way

Each of these decisions came from a problem found during design. Keep them
unless the user asks otherwise.

1. **Two suction cups, about 64 mm apart centre to centre,** so the mount
   keeps its orientation on the glass.
2. **Both cup slots open through the front face, and a lock bar holds them
   in.** A separately printed lock bar slides lengthwise through a channel
   directly in front of both heads. A snap with two prongs and barbs catches
   the far end of the bar.
   - **Ruled out: both slots facing the same way with no lock.** A sideways
     tug releases both cups together.
   - **Ruled out: slots through opposite ends of the bar.** They can't be
     printed on the side.
   - **Ruled out: slots through opposite long faces.** Twisting the bar
     releases both cups at once. The user caught this.
3. **The clamp is a hook cap with a single bolt,** because the rod has to
   drop in from the side.
   - **Fitting:** lower the cap straight down, offset `cap_slide` toward +X.
     Slide it toward -X so the tongue goes under the lip on the post, then
     fit the vertical bolt.
   - **Cap cavity:** it's lengthened toward -X by `cap_slide` so the cap
     clears the rod while it slides.
   - **Ruled out: a tilt-in hinge.** A 2D collision simulation showed it
     always hits the rod. Don't go back to it.
4. **Print orientation:** the body prints on its front face (-Y on the bed)
   and the cap prints on its side. Both are 2D XZ profiles run through
   `extrude_y` across the full bar width, so the layer lines run through the
   joint between bar and clamp. The lock bar prints flat.
5. **Single-cup version (`cups = 1`):** for a lighter antenna, or as a
   second support further along a mast the 2-cup clamp already holds.
   - **Same file:** only the bar length, the cup positions and the bolt
     hole depth depend on `cups`. The clamp, cap and lock work the same,
     and `cups = 2` (the default) gives the 2-cup geometry unchanged.
   - **Cup under the clamp:** the one cup is centred under the rod, so
     the rod's weight doesn't twist the clamp about the knob. A single cup
     can still turn on its knob under a sideways load, which is why it's
     meant for light or secondary duty.
   - **Bar length:** set by the clamp, its chamfers and the corner
     rounding: 47 mm, against 85 mm for two cups. The lock bar is 54 mm
     overall.
   - **Bolt hole:** with the cup under the clamp, the hole runs 0.55 mm
     from the head pocket, so it stops at the pocket's top instead of
     leaving a thin skin. Bolts are 13–15 mm (14 mm recommended).

## Box holder: design and why

1. **One suction cup.** Its slot opens through the bottom edge (-Y), so the
   holder hangs on the knob and gravity keeps it seated.
   - **Twisting:** with only one cup, the holder can turn around the knob.
     The object is centred over the cup so its weight doesn't twist it.
2. **The object rests on a base plate between two jaws,** with a ledge
   along the bottom edge carrying its weight.
   - **Fixed jaw:** has a 45° lip that wraps over the object's front edge.
   - **Sliding jaw:** has the same lip, and its dovetail foot runs in a
     track in the plate. A notch at the bottom lets it ride over the ledge.
   - **Fitting the sliding jaw:** it drops in through an opening at the
     inner end of the track, then slides outward.
3. **A printed thumbscrew in a printed nut pushes the sliding jaw closed.**
   This answers the user's question about whether a printed screw would
   work: it does for light indoor loads.
   - **Threads:** BOSL2 `trapezoidal_threaded_rod` and
     `trapezoidal_threaded_nut`, 10 mm × 2.5 mm pitch, with
     `thread_angle = 90`. That gives 45° flanks that print without support,
     where the ISO 60° form wouldn't.
   - **Print orientation:** both threads print with the axis vertical.
   - **Nut:** its bottom outer chamfer is turned off (`bevel1 = false`)
     because it overhangs on the bed. It sits captive in a slot in the end
     block that opens upward.
4. **Optional TPU grip pads (`pads = true`).** One pad covers each jaw
   face. A 45° dovetail rib on the back slides down into a groove in the
   jaw, and the pad stands on the ledge.
   - **Spacing:** every position is derived from `obj_x0`, the object's
     side, and `pad_eff`. The fixed jaw, the sliding jaw's travel, the end
     block and the screw length all move out by the pad thickness.
   - **Lips:** they reach `lip + pad_eff` from the jaw face. Their 45°
     underside starts `pad_eff` lower (`lip_wall_z`), so it crosses the pad
     face just above the thickest object.
   - **Pad top:** it follows the lip underside, 0.3 mm below it.
   - **Past bug:** before this fix, objects could move 2 mm outward before
     reaching the lips. The `obj_lip_small` fit test catches it.
   - **Without pads:** `pads = false` reproduces the padless geometry
     exactly.
5. **Print orientation:**
   - **Base:** prints on its bottom edge (-Y, where the cup slot opens),
     like the antenna clamp body. The plate, fixed jaw, lip and end block
     then lie in each layer, so clamping force runs along the layers.
     - **Why:** printed flat, the fixed jaw and end block were attached to
       the plate by a layer boundary. Clamping pushed them along it,
       shearing between layers and pulling them apart. The user caught
       this.
     - **Features changed for this orientation:**
       - The jaw track is a pure 45° dovetail, with no straight-sided
         slit, which would print as an unsupported ledge.
       - The drop-in opening has a 45° peaked top.
       - The nut slot opens through the top edge (+Y).
       - The screw hole's teardrop points +Y.
       - The plate is rounded only on its glass-side edges, in the XZ
         profile.
   - **Sliding jaw:** prints on its outer face, so its layers run up the
     jaw.
   - **Pads:** print two, grip face down and rib up.
   - **Sliding jaw:** prints on its outer face.
   - **Screw:** prints standing on its head.
   - **Nut:** prints flat.

## Bird feeder: design and why

1. **Edits an imported STL rather than remodelling.** This keeps the user's
   own design (drain hole pattern, the 45° fin along the inside top of the
   back wall) exactly as drawn. Everything outside the edited regions must
   stay identical to the original.
   - **Flush faces:** the STL stores float32 values, and its bottom face is
     at 4.3e-15, not 0. New faces that must be flush with the original use
     the exact values (`stl_x1`, `stl_bed`). Elsewhere new solids overlap
     the original by 0.5–1 mm instead of meeting it face to face.
   - **No 2D polygons on the bed:** OpenSCAD rounds 2D coordinates slightly,
     so a `linear_extrude` standing on the bed ends up about 1e-5 mm off
     it. The spacer ridges are built from 3D primitives for this reason.
2. **Cup slots:** both towers are rebuilt with the library `cup_slot`,
   opening through the bottom like the box holder. The hollow behind the
   slot stays open at the top and bottom, as in the original. The cup
   centre (`cup_z = 38.5`) is 1.8 mm lower than the old keyhole top, so the
   pointed slot end fits under the tower top.
3. **Window and panel:** a window in the back wall, with a clear panel
   that slides down into rails on the outside of the wall (the glass side).
   - **Not on the inside:** the fin along the inside top of the wall
     blocks a panel from going in from above.
   - **Window shape:** 45° top corners with a 10 mm bridge, because a flat
     60 mm top would be a long unsupported bridge. Its top stays below the
     fin (z 40.4 in the original).
   - **Holding the panel:** it stands on a 2 mm ledge. Lips on the rails
     and a strip along the bottom hold it against the seed.
4. **Spacer ridges:** the original single centre ridge, which rests on the
   glass, sat where the panel goes. It's replaced by two identical 45°
   ridges at `±spacer_x`.
5. **Print orientation:** the feeder prints upright, as the original does.
   The panel prints flat.
6. **Model coordinates:** the cup slots follow the shared convention: x
   along the feeder, y up, z away from the glass. z = 0 is the tower
   fronts; the real glass, where the ridges touch, is at `glass_z` (-7).

## Modular bird feeder: design and why

1. **The mount stays on the glass and the tray lifts off.** The mount bar
   holds both cups in library `cup_slot`s on its glass side. Two more
   T-slots on its front face open upward. Knobs on the tray's back corner
   posts drop into them.
   - **Removing the tray:** lift it about 22 mm and pull it away. The feet
     stay clear of the cups up to 27 mm of lift.
2. **Why knobs and slots:** the tray prints upright, so it can't have a
   French cleat. A cleat's hooking lip points down and starts in mid-air.
   A downward-facing bearing surface printed upright has to be a 45°
   pointed hole top or a 45° knob underside.
   - **Knob shape:** the head has a 45° point underneath. The neck runs
     straight down to a point at the same depth (`knob_apex`), so every
     layer joins the post. A plain mushroom knob would print its head's
     lowest layers as a floating island.
   - **Tray slots:** the knob outlines offset by `slot_clearance`, not
     `cup_slot`.
3. **Keeping seeds out of the gap:** the tray hangs 23 mm off the glass
   (`bar_t + cup_standoff`), which is more than a seed's length. Nothing in
   the gap has a flat top. The mount's top slopes 45° toward the tray, and
   the two feet that brace the tray bottom have peaked tops.
   - **Ruled out: sitting the feeder against the glass.** Seeds got stuck
     between the glass and the feeder. The user reported this.
4. **Seed level:** the tray's whole back wall is the clear panel. It
   slides into grooves in the corner posts and a channel in the floor,
   which has drain holes. The mount sits above the tray rim, so it doesn't
   hide the panel.
   - **Panel lock:** the user wanted a very solid lock, because the panel
     rarely comes out once fitted.
     - **Keys:** two keys slide in from the tray's outer sides, through
       slots in the corner posts, and through notches in the panel's edges
       near the top.
     - **Double shear:** each key spans the panel groove and is held in
       post material on both sides. Lifting the panel loads it in double
       shear.
     - **Clip:** a latch arm with a barb, freed by a slit, snaps into a
       pocket in the slot. The arm flexes sideways, along the layers. To
       release a key, press the arm end in at the tray's outer face.
     - **Print shape:** keys and slots have flat bottoms and 45° pointed
       tops. The left key is the mirror of the right, and `part="lock"`
       renders both.
     - **Room for the keys:** `panel_lip` (3) and `post_d` (12) were
       increased to fit them.
5. **Drainage:** a hexagonal grid of 3.5 mm vertical holes across the
   floor. That's about the size of the original's holes, and smaller than
   a sunflower seed is thick. The front wall is lower (35 mm) than the
   back (50 mm) for the birds.
6. **Perch:** a rail on two arms. Dovetail tongues on the arms slide down
   into sockets in bosses on the front wall.
7. **Optional roof:** the user chose to attach it to the mount and to keep
   the sockets on the mount always, so the roof can be added later without
   reprinting the mount.
   - **Where it sits:** the roof stays on the window while the tray lifts
     out beneath it. Its back edge, `roof_back_gap` from the glass, covers
     the gap behind the tray. It's a single slope, `roof_pitch` 15°,
     shedding rain off the front past the perch.
   - **Height:** `roof_headroom = 150` gives about 160 mm over the perch,
     enough for cardinals and grosbeaks, the main in-shell sunflower
     eaters. The first version (100 mm, about 107 mm over the perch) only
     suited sparrow-sized birds. `roof_overhang` went from 20 to 32 mm to
     offset the extra driving rain.
   - **Mount end blocks:** end blocks beyond the tray's width carry
     vertical half-dovetail sockets. The blocks are extruded from the same
     2D bottom edge as the bar, so they're flush on the bed.
   - **Brackets:** side plates with a half-dovetail tongue down their back
     edge and a half-dovetail rail along their top edge.
   - **Fitting the roof:** it slides up the slope onto the rails. Its rib
     channels are open at the back and closed at the front, so the closed
     front ends stop against the rails' front ends.
     - **Ruled out: channels closed at the back.** The solid rib behind
       the channel then has to pass over the rail.
   - **Latch:** a barb on a flexible arm near each bracket's back snaps up
     into a pocket in the channel ceiling. It only rides under the rib for
     the last ~15 mm.
   - **Order:** fit the panel lock keys before the brackets.
8. **Print orientation:**
   - **Mount:** on its bottom edge.
   - **Tray:** upright.
   - **Perch:** upright, as mounted. It's built with its bottom at y = 0
     (`perch_local`), so the 2D rail outline lands exactly on the bed.
   - **Panel:** flat.
   - **Lock keys:** on their flat bottoms. They're built with y = 0 at the
     bottom (`lock_key_local`), for the same 2D-rounding reason as the
     perch.
   - **Roof brackets:** flat, on their outer faces, so bending runs along
     the layers. The half-dovetails are flat on the bed side. The two
     brackets are laid out end to end, tongues 5 mm apart, so they fit a
     250 mm bed (235 × 158 mm).
   - **Roof:** upside down, its smooth top on the bed. It's about
     234 × 171 mm.
9. **Measured value:** `cup_standoff = 7` is the distance from the glass
   to the top of a cup. It comes from the original feeder's spacer ridge.

## Bird Buddy feeder: design and why

1. **A variant file, not a fork.** `suction_cup_bird_feeder_buddy.scad`
   includes the modular file and uses its mount, tray, panel, keys and
   perch unchanged, so a mount already printed is reused. The roof and
   roof brackets aren't used.
   - **Side:** `buddy_side` picks it (1 = +X, on the left seen from
     indoors). Only the camera mount's STL changes with it. The collar,
     cradle, upper mount and frame are symmetric about their own centres.
2. **Camera mount:** a window mount of its own, touching nothing on the
   feeder, so the tray still lifts off on its own.
   - **History:** it was first a side mount that hung in the feeder
     mount's roof bracket socket. The user asked for it to be separate,
     on two cups one above the other.
   - **Cups:** one at `cm_cup_top` (60) and one at `cm_cup_bot` (-40),
     both at the camera's x, either side of the arm.
     - **Spacing:** they're kept far enough from y = 0 to clear the
       feeder mount's nearest cup, which an assert checks.
     - **Slots:** both open sideways through the side away from the
       feeder (+X), and the slots' sides hold the knobs up and down.
       - **History:** they first opened in opposite directions; the user
         asked for them on one side with a lock bar, like the antenna clamp.
     - **Lock bar:** `cam_lock_bar` slides down a channel just past both
       heads, at head-pocket height, the full length of the plate.
       - **Stops:** its stop head rests on the top of the plate, and its
         snap prongs' barbs catch the bottom face.
       - **Width:** the channel and its outer wall set the mount's width,
         `cm_w`, about 32 mm.
       - **Removal:** squeeze the prongs to pull it out.
     - **Fitting:** slide both cups in from the open side, push the bar
       down until it snaps, then press both cups onto the glass.
   - **Profile:** it's one side profile, [z, y], extruded `cm_w` (about 32 mm)
     across.
     - **Plate:** on the glass, `cm_t` thick. A foot at each end, beyond
       the cups, reaches to `foot_gap` from the glass.
     - **Arm:** it runs out at the collar's height and ends in a fork.
     - **Gussets:** 45° gussets join the arm to the plate.
     - **Seeds:** the bottom foot's top slopes at 45°, so seeds don't rest
       on it.
   - **In-plane loads:** the cups, the arm and the camera all lie in one
     y–z plane, so the loads stay in the profile's plane.
3. **Collar and joint:** the collar is a separate part, because it has to
   print flat (axis vertical) for its teeth and seat.
   - **Tab:** it has a `tab_len` × `tab_t` tab that slides into the arm's
     fork.
   - **Pin:** `collar_pin` (5 mm) drops through the fork and tab, head on
     top.
   - **Load path:** the tab's top and bottom faces bear on the fork's
     prongs, so they carry the camera's moment. The pin only stops the
     tab sliding out.
4. **Camera:** a Bird Buddy 2 module, measured by the user.
   - **Size:** 122 × 51 × 37.5 mm, plus a 2 mm magnet bump on the back.
   - **Shape:** from the front it's a pill: the 51 mm width has full
     semicircular ends. Across its depth it's nearly rectangular, with
     edges rounded about 3 mm. This came from photos and from a
     community holder for the same module (Printables "Bird Buddy Bath",
     498120), whose pocket is 52 mm wide with round ends and about 31 mm
     deep.
   - **Magnet:** the module only switches on when it senses a magnet.
     Bird Buddy's own holder and community holders use an 18 × 2 mm disc
     magnet behind the top of the camera's back. The bump's size
     (`cam_bump_d`, 18) and position (`cam_magnet_from_top`, 25) are
     estimates, so check them against the camera.
     - **How many:** one magnet wasn't enough. The user had to break
       open the first print's slot to stack three before the camera
       reported it was ready for birds. `cam_magnets` (3) sets the
       stack, and the slot and spine grow with it.
   - **Front:** the lens (26 mm glass) is 97 mm down from the top. Its
     bezel is assumed to stand 1 mm proud (`cam_lens_proud`). A 10 mm
     button sticks out 13 mm, 25 mm down from the top.
   - **USB-C:** on top.
   - **Facing:** portrait, looking across the tray along the perch (-X
     for the +X side), with its lens at `cam_lens_y` (-22, 15 mm above
     the perch top). That's above the tray's side wall, so it sees in.
5. **Cradle:** a sleeve, open at the top.
   - **Height:** its walls run from a floor under the camera up to the
     top of the band.
   - **Shape:** it follows the pill outline, so its floor is a trough
     round under the camera's bottom end. In plan the pocket's corners
     and the walls' corners are both rounded like the camera's, so the
     walls are 4 lines thick all round.
     - **Past bug:** the first print's pocket had square corners inside
       rounded walls, leaving 0.07 mm at each corner. The slicer showed
       them as vertical slots, and the user spotted them.
   - **Front:** a window round the lens with a pointed top.
     - **Groove:** a groove up the front wall's inside lets the lens's
       proud bezel slide down as the camera goes in. A rib outside keeps
       the wall thickness over it. The rib is as wide as the window, so
       no sliver is left beside the window, and its underside is 45°.
     - **Button:** it never reaches the walls, which stop below it.
   - **Drainage:** drain holes go through the bottom of the trough.
   - **Spine:** a spine rises up the back to above the magnet. Behind
     the pocket it holds:
     - a channel for the camera's bump;
     - a 2-line skin;
     - the magnet slot, deep enough for `cam_magnets` stacked;
     - a 3-line back skin.

     Both the channel and the slot open at the top of the spine, so the
     magnets drop in from above and the cap covers them.
6. **Cap (the user asked for it):** a roof over the camera's top.
   - **Purpose:** it keeps rain off the USB-C plug.
   - **History:** the first version was a hood that hugged the camera's
     top. The user found it too small and asked for something more like a
     roof.
   - **Shape:** straight walls round the camera's top, under a hipped roof
     with 45° slopes. The eaves reach `cap_eave` (8 mm) past the walls,
     so water drips clear of them. The roof is a shell 4 lines thick, and
     the eaves' undersides are cut back at 45°, so it prints upright.
     It's about 70 × 71 mm and 65 mm tall.
   - **Inside:** it follows the camera's round top over the shoulders,
     then opens up into the roof. The roof's height is set so there's
     `usb_space` (35 mm) above the camera's top over the plug, room for a
     straight plug and the cable's bend.
   - **Seating:** it rests on the camera's shoulders. It's modelled
     settled there, `cap_sink` = `cap_clearance` × √2 lower than
     concentric.
   - **Detents:** two 45° bumps on the back of the spine, one each side
     of the cable slot, reach `cap_detent` into diamond windows in the
     cap's back wall, so wind can't lift it off.
   - **Front:** a notch, open at the bottom, clears the button.
   - **Cable:** it leaves through a slot up the middle of the back wall,
     under the eave (the user asked for the back; it was first in the
     side). The slot is open at the bottom, so the cap goes on with the
     cable already plugged in.
   - **Print orientation:** upright, open bottom on the bed.
7. **Held at its middle, turned and locked (the user asked for this):**
   - **Why the middle:** on the first version the camera stood on a
     toothed pad at its bottom. The user pointed out the torque that put
     on the mount, since anything pressing on the top had the camera's
     whole height as a lever.
   - **Collar:** it's pinned in the camera mount's fork. The cradle hangs
     in it by a band round its middle.
   - **Height:** the seat is `collar_h` (60 mm) above the camera's
     bottom, about its middle. That keeps the lever to the top short, and
     the camera's centre of mass is near the collar.
   - **Out of the view:** the collar's bottom inner edge and the band's
     cone stay above the lens's view. An assert checks they're at least
     `cam_view_half` (55°) above horizontal, seen from the lens centre;
     they're at 64°.
   - **Seat:** the sleeve below the band passes through the collar's bore
     (`r_bore`). The band's underside is a 45° cone that rests on a
     matching 45° seat, which centres it.
   - **Teeth:** `n_teeth` (360 / `cam_yaw_step`, 7.5° steps) round the
     band mesh with internal teeth in the collar.
     - **Printing:** they're vertical extrusions, and the band's teeth have
       their bottoms cut back on the same cone.
     - **Facets:** the collar's circles use `fn_teeth` (4 × `n_teeth`)
       facets, so every step lines up.
   - **Lock:** `cam_pin` goes through two posts at the back of the collar
     (toward the glass), just over the band's top edge, so the cradle
     can't be lifted off the teeth.
     - **Pin:** it's round with a flat for printing, and goes in flat side
       up.
     - **Posts:** they stand outside the band, so the cradle lifts out once
       the pin is pulled.
   - **Turning it:** pull the pin, lift the cradle `spline_h` (5 mm), turn
     it and drop it back.
   - **Range:** the fit checks cover 0–45° outward, where nothing hits.
   - **Ruled out:**
     - **A toothed pad under the camera with a thumbscrew clamp:** the
       first version. It had the torque problem above.
     - **A sprung latch on the collar:** any arm that could reach over the
       band would bend across its layers.
8. **Solar panel:** 197 × 165 mm.
   - **Thickness:** 5 mm at the edge and 7 mm by the junction box. The box
     is the full 15 mm.
   - **Box:** 50.5 × 72 mm, 47 mm from the cable edge.
   - **Socket:** 1/4"-20, centred along the 197 mm side, 57 mm (2.25 in)
     from the cable edge.
   - **Back holes:** the four small holes in the panel's back aren't used.
   - **Weight:** 210 g, plus 50 g of cable.
9. **Frame (the roof):**
   - **Orientation:** the panel goes in with its long side along the
     feeder and its cable edge toward the glass.
   - **Plate:** the box sits on the frame's plate. The plate is open
     under the panel except for a band round the box and two ribs.
   - **Rim:** ledges in the rim carry the panel's edges 10 mm up. The rim
     wall stops 1.5 mm below the panel's face, so water runs off the
     front.
   - **Cable:** a notch in the back rim lets the cable out.
   - **Size:** the frame is 250 mm wide (`frame_w`, the bed limit), from
     7 mm past the tray on the far side, so on the camera side it covers
     the camera at 0° but not all of it when turned.
   - **Height:** its front edge is `roof_headroom` above the perch top,
     as with the modular roof.
10. **Upper mount and bolt:** the panel's socket faces down at 15°, so a
   bolt from below needs a face for its head to bear on.
   - **Bolt head:** the bracket's bottom is parallel to the roof, and the
     bolt runs straight through it, so the head bears on the first layer.
     A pocketed head would need a bridged ceiling.
   - **Bolt and height:** a 1/4"-20 × 2 in steel bolt with a washer
     (`panel_bolt_len`, `socket_engage` 8 mm into the socket) sets the
     bracket's height, `um_h`.
   - **Turning:** two pins on the pad go into holes in the plate, so the
     frame can't turn on the bolt.
   - **Load:** the cup is at the socket's x, so the panel's weight doesn't
     twist the knob.
   - **Feet:** two feet outside the cup (`um_feet_x`) take the cantilever
     against the glass.
   - **Fixed angle:** the tilt is fixed at `roof_pitch`, as the user
     chose.
11. **Print orientation:**
   - **Rule (the user's):** each part prints flat, turned so its main
     loads in use run along the layers.
   - **Camera mount:** on its side (its -X face on the bed), so its side
     profile lies in every layer.
     - **Loads:** the cups' pull and push on the glass, the camera's
       weight and the arm's bending are all in that plane, so they load
       it along the layers.
     - **Cup slots:** they run up through it, closed ends at the bottom as
       floors.
     - **Lock bar channel:** its ceiling is a 3.8 mm bridge along the
       plate, as on the antenna clamp.
     - **Fork pin hole:** pointed at the top.
     - **Size:** about 175 × 72 mm on the bed and 32 mm tall.
   - **Collar:** flat, as mounted, so the ring, tab and seat take the
     cradle's weight along the layers. About 99 × 79 mm, 16 mm tall.
   - **Collar pin and lock pin:** flat, on their flats, so they bend along
     their layers.
   - **Camera mount lock bar:** flat, so its prongs flex along the layers.
     It's about 182 mm long.
   - **Cradle:** upright, on its floor. About 74 mm across the band and
     115 mm tall.
     - **Why upright:** it's the only orientation where its teeth and
       45° cone print.
     - **Exception to the rule:** below the band, the camera's weight
       hangs from the walls across the layers. That's about 2 N over
       300 mm² of wall, roughly 0.01 MPa.
   - **Cap:** upright, open bottom on the bed. Its export used to sit
     `cap_sink` (0.71 mm) below the bed, because `camera_cap_print` didn't
     allow for the cap settling; the post's version always did.
   - **Pin:** flat, on its flat.
   - **Upper mount:** on its bottom, so the cup slot leans 15°. Its pointed
     end's faces are then about 47° from horizontal, still printable.
   - **Frame:** flat, plate on the bed, 250 × 172 mm.

## Bird Buddy on a wooden post: design and why

1. **A file of its own, not a change to the variant.**
   `bird_buddy_post.scad` includes the Bird Buddy variant and keeps its
   collar, collar pin, cradle and lock pin, so a camera set up for the
   window moves across unchanged.
   - **Mounting (the user's choice):** any flat face of wood, the camera
     on its side of it, held by wood screws.
2. **Post mount:** the camera mount's profile (arm, fork, 45° gussets) on
   a plate `wp_t` (8 mm) thick, `wp_w` (36 mm) wide and about 105 mm tall.
   - **Screws:** four pan head wood screws (#8 or 4 mm; `wp_screw_d` is
     the 4.5 mm hole), two above the arm and two below. They sit past the
     gussets, so a screwdriver reaches them straight on.
   - **Reach:** `cam_z` is 130 mm here (105 on the window).
     - **Why:** at 105 the panel's corner hit the wood with the panel
       turned 45°. At 130 the panel clears the wood at any tilt the ball
       allows, either way, with its cable edge anywhere within 90° of
       facing the wood.
     - **Same collar:** the collar is the same part. Only the arm is
       longer.
   - **Camera angle:** nothing on the post mount reaches the cradle, so
     the camera can face any way, in `cam_yaw_step` steps. The mounted
     view shows 90°, straight out from the wood.
3. **Cap (the user asked for it to carry the panel):**
   - **Thicker:** `cap_wall_lines` is 6 (4 on the window).
   - **No eaves (the user's call):** `cap_eave` is 0 (8 on the window),
     because the panel keeps the rain off. The walls run straight up into
     the 45° roof.
     - **Why:** the eaves were the hardest part to print. Their
       undersides are 45°, but the hip corners slope at about 35°, and
       the eave edge starts as a thin edge in mid-air.
     - **Same height:** the roof's apex, and so the ball and panel, stay
       where they were.
   - **Longer:** `cap_down` is 48.5 (22 on the window). The cap reaches
     down over the solid part of the cradle's spine and stops just above
     the collar's lock pin posts. An assert checks it clears them.
   - **Screws:** two M3 × 10 pan head screws (`wp_cap_screw_len`) go
     through the back wall, either side of the cable slot, into the spine
     below its bump channel. Drill 2.5 mm pilots through the cap's holes
     the first time, so the cradle prints unchanged.
     - **Why:** the detents only stopped wind lifting a bare cap. The
       panel's weight and wind need a real fixing.
   - **Detent grooves:** grooves up the inside of the back wall let the
     spine's detents slide up to their windows. Without them the wall
     would have to flex over the detents for 30 mm of travel.
   - **Load:** the cap still rests on the camera's shoulders. The panel's
     weight goes to the cradle through the camera and through the screws.
4. **Ball joint (the user asked for an adjustable angle with a ball
   joint):**
   - **Socket:** a threaded boss on the cap's roof holds a bowl for a
     36 mm ball. The bowl stops just below the ball's equator, so the
     ball drops in. A drain runs from the bowl's bottom out of the boss's
     back.
   - **Thread:** BOSL2 trapezoidal, 46 × 2.5 mm, `thread_angle = 90`
     (45° flanks), as on the box holder. The bevels are set to the thread
     depth: BOSL2's default bevel on the ring's internal thread flared it
     away over nearly its whole length.
   - **Ring:** it screws down over the boss and grips the ball's upper
     half, from just above its equator up to `wp_ring_lat` (28°).
     - **Tilt:** its opening lets the stem tilt 39° (`wp_max_tilt_round`)
       most ways, but only `wp_max_tilt` (33.5°) toward the stem's keel,
       which reaches further from the axis. The keel is on the cable-edge
       side, so the usual tilt, low edge away from the wood, gets the
       full 39°.
     - **Heading:** the ball also spins in the socket, so the panel can
       face any way.
     - **Modelled clear:** the ring is drawn `wp_ring_clearance`
       (0.1 mm) off the ball.
     - **Thread phase:** the ring's thread meshes with the boss's at ring
       turns of 195–300°; the fit checks use 247.5°.
   - **Ball and stem, two parts (the user asked for the stem's layers to
     run along the panel's force):**
     - **Why two:** in one piece the stem had to print upright with the
       ball, so the panel's bending pulled its layers apart. The stem
       now prints on its side, its layers along it.
     - **Stem:** its cross-section is a teardrop cut flat `wp_keel`
       (8 mm) below its axis. The flat is the bed face, and the keel keys
       the stem in the ball. It flares at 45° to a 30 mm plate (D-shaped,
       cut by the same flat) that bears on the junction box.
     - **Ball:** the stem's end plugs 13 mm into a keyed pocket in the
       ball's top (`wp_pocket_floor`, `wp_pocket_clearance`). The ball
       prints upright. It takes only bearing loads, from the ring, the
       bowl and the stem in its pocket, and those lie along its layers.
     - **Bolt:** a steel 1/4"-20 × 2-1/2" flat head screw (82°
       countersink, `wp_bolt_len`) goes up through the ball and the stem
       into the panel's socket, `socket_engage` (8 mm) deep, and clamps
       all three together. Its head sits in a countersink under the
       ball.
     - **Ring first:** the plate is smaller than the ring's opening, so
       the ring slips over the stem before the stem goes into the ball.
     - **Ball's underside:** cut flat where it reaches 45°. A 45° cone,
       as on the feeder's knobs, would stick out of the sphere. The first
       version had one, and it dug 0.6 mm into the bowl, more when tilted.
   - **Panel limit:** with the cable edge more than about 90° from facing
     the wood, the panel's long side (108 mm from the socket) reaches the
     wood. Tilting the cable edge down toward the wood is fine.
5. **Fitting order:**
   1. Screw the mount to the wood.
   2. Fit the collar and the collar pin.
   3. Put the magnets and the camera in the cradle, and plug in.
   4. Push the cap on and drive the M3 screws.
   5. Lower the cradle into the collar and fit the lock pin.
   6. Put the ring over the stem, plug the stem into the ball, and bolt
      both to the panel through the ball.
   7. Set the ball in the socket and screw the ring down.
6. **Print orientation:**
   - **Post mount:** on its side, like the camera mount. About
     90 × 105 mm on the bed, 36 mm tall.
   - **Cap:** upright, open bottom on the bed. It's the only way the
     boss's thread and the ball's bowl print. About 55 × 57 mm, 110 mm
     tall.
   - **Ball:** upright, on its flat, 29 mm tall.
   - **Stem:** on its side, keel down, so its layers run along it. About
     30 × 40 mm on the bed, 23 mm tall.
   - **Ring:** upside down, its top on the bed, so the face that grips the
     ball faces up. 56 mm across, 21.5 mm tall.
7. **Wind (an estimate, not tested):** the panel is about 0.03 m². A
   20 m/s gust could push on it with roughly 10 N, about 1.5 N·m on the
   cradle and collar at the panel's height. The window version never
   carried that. If the cradle rocks in the collar in strong wind, look
   at that joint first.

## Phone holder: design and why

1. **Two cups, one above the other, slots opening outward.** The top
   cup's slot opens through the top edge and the bottom cup's through the
   bottom edge. With both cups stuck, the holder can't move up (the bottom
   knob stops it) or down (the top knob carries its weight), and two knobs
   stop it turning. No lock part is needed.
   - **Fitting:** slide each cup in from its end of the holder to the
     closed end of its slot, then press the holder onto the glass.
   - **Cup blocks, not a full-length spine:** each T-slot is in a short
     block around its seated knob, `block_in` past the cup centre on the
     open side and `block_end` on the closed side. Only that part carries
     load. Between the holder's end and the block, the knob slides under
     the back sheet: the head's top (6.1) is below the sheet's back
     (`sheet_z0`, 6.4). Each block's lower end is cut back from the sheet
     at a little steeper than 45° for printing. Dropping the full-length
     spine cut the volume from 63 to 51 cm³ with no loaded part thinner.
     Setting the thicknesses as whole lines then made it 47 cm³.
     After the first print the user found it much stronger than needed,
     so the walls, lips, sheet and blocks lost one to three lines each
     (45 g in Orca, with the thicker fin roots).
   - **Why not slots opening down like the box holder:** lifting the phone
     out would drag the holder up off the knobs.
   - **Cup tabs:** the feet are only at the corners, so the cups' release
     tabs can be reached from the sides.
2. **Corner feet** reach to `foot_gap` (0.5 mm) short of the glass, so the
   cups can still be pressed flat. They stop the holder rocking on the
   knobs when the screen is pressed. The top feet's lower ends are cut at
   45°.
3. **The phone drops in from the top.**
   - **Lips** along both sides wrap `lip` (3.5 mm) over the case's front.
     They start below the top, with a lead-in, and don't cover the top
     corners, which iOS uses for Control Center and notifications.
   - **Bottom:** the phone's corners rest in cradles matching
     `phone_corner_r`. The middle (`notch_hw`) is open for the speaker,
     mic and port, for drainage, and so the phone can be pushed up from
     below to remove it. There's no bottom lip, which would block the home
     swipe.
   - **Clearance:** the user's soft case dragged on the first print's
     walls (0.75 mm a side), so `side_clearance` is 1.5 mm a side and the
     cavity is `depth_clearance` (1 mm) deeper front to back. The fins
     follow `depth_clearance`, so the phone is still pressed against the
     lips.
   - **Camera bump:** the phone's back sits at least `camera_clearance`
     (4 mm) off the back sheet. The fins stop below the camera.
   - **Button windows:** the side walls are open from 25 to 125 mm up the
     phone, so the volume, Action, side and Camera Control buttons aren't
     pressed by the walls and can be reached. Their tops are peaked for
     printing.
   - **Window crossbars:** on the first print, the long strips of lip and
     wall beside the open windows wobbled near the top as they printed.
     Crossbars (`left_bars`, `right_bars`, heights up the phone, `bar_t`
     at the narrowest) tie the lip to the back. Each window piece has a
     flat bottom and a peaked top, so a bar's underside is a pair of 45°
     slopes, not a bridge.
     - **Placement:** the left side (-X, volume and Action) has bars at 50
       and 78 mm, below the volume buttons. The right side (+X, side
       button and Camera Control) has one at 78 mm, between Camera
       Control and the side button.
     - **Estimates:** these positions are estimated from photos, because no
       measured button positions were found. Check them against the
       user's phone.
4. **Back windows (`back_windows`):** diamond windows in the back sheet,
   with `rib_t` ribs between them, save plastic and let water behind the
   phone drain and dry.
   - **Where:** one column each side from 3 mm past the fin root to 4 mm
     short of the fin tip, and in the middle between the cup blocks and above
     the top one.
   - **Kept solid:** the sheet under the fin tips stays, as a stop if the
     screen is pushed hard.
   - **Printing:** their 45° sides print on edge without supports.
5. **Spring fins, not TPU pads.** Two thin fins along the back press the
   phone forward against the lips, so it doesn't rattle.
   - **Flex:** they flex in the cross-section, so they bend along the
     layers.
   - **Load:** at the default `fin_preload` of 0.3 mm, 3-line (1.23 mm)
     fins give about 6 N of preload, at well under 0.3% strain, which is
     low enough not to creep in a warm shower. It was 0.5 mm (about 10 N)
     on the first print, which a soft case made hard to slide.
     - **Friction:** the fins and the lips both drag on the case, so a
       grippy case can take about twice the preload force to slide out.
   - **Why not TPU pads:** a pad that slides into a groove from the top
     would be dragged out with the phone, and the fins avoid a second part.
   - **Root:** the first print's fins joined the back with a 1 mm stub
     only 1.2 mm thick, which the user thought looked weak. Each fin now
     tapers from `fin_root_lines` (6, 2.4 mm) at the root to 3 lines over
     `fin_taper` (5 mm), and a `fin_fillet` (2 mm) inside the root spreads
     it along the back.
     - **Stiffness:** a thicker root alone would make the fin about 1.7×
       stiffer. To keep the grip the same, `fin_root_x` moved in from 16 to
       13 mm, which lengthens the fin. A beam calculation puts it at 0.98×
       the stiffness of the old fin, with about 13% less peak stress for
       the same preload, so `fin_preload` stays at 0.3.
     - **Back windows:** they're now cut only to 0.3 mm above the sheet,
       so they don't nick the fin underside. The old full-height cut took
       up to 0.4 mm off the underside near the root.
   - **Ends:** cut back at a little steeper than 45°, both across the fin
     (from the root) and in depth (with height off the back), so the fin,
     the thick root and the fillet all grow out of the back layer by layer.
     The top end is a lead-in for the phone.
6. **Print orientation:** on its bottom edge, like the box holder. The
   whole cross-section (back, walls, lips, fins) lies in each layer, so the
   phone pushing on the lips, the fins flexing and the cups pulling all
   load along the layers. About 79 × 33 mm on the bed and 141 mm tall.
   - **Thicknesses, in 0.45 mm lines at 0.28 mm layers:**
     - Side walls, feet and lips: 4 lines (1.62 mm).
     - Back sheet and pocket roofs: 5 lines (2.01 mm).
     - Cup block side walls: 6 lines (2.40 mm).
     - The first print had 7-line walls, 6-line lips and sheet, and
       8-line block walls.
     - Fins: 3 lines (1.23 mm) measured across the fin. `fin_v` is the
       matching vertical thickness.
7. **Materials:**
   - **PETG** is recommended: tough, fine with warm water, and the fins
     flex well.
   - **ASA** also works, and resists heat better.
   - **TPU** isn't needed for any part.
8. **Phone data:** no OpenSCAD library or official drawing with iPhone 16
   Pro button or camera positions was found. The windows and fin heights
   are generous to allow for that. iFixit confirms the layout: volume and
   Action on the left, side button and Camera Control on the right, with
   Camera Control on the lower half.

9. **Angle adapter (`part="adapter"`):** turns the holder
   `adapter_angle` (45°) about the vertical so the screen faces left. The
   user asked for 45° only; straight-on is the holder on its cups.
   - **Two blocks, not one piece:** the holder's slots open in opposite
     directions, so it can't slide onto two fixed knobs. Each block sits
     on one cup (a library `cup_slot` on its back, opening the same way as
     the holder's slot for that cup) and carries a knob for the holder on
     its 45° face. Fitting and locking work exactly as with bare cups. The
     top block is the bottom one mirrored in y.
   - **Rails** each side of the holder's cup block (`rail_clearance`) stop
     the holder twisting on a block about the knob.
   - **Where the knobs sit:** `adapter_x` (-12) and `adapter_z` (27) from the
     cup centre and top. They're set so the holder's corner feet, which swing
     toward the glass, land outside the cups and 1.7 mm off the glass.
   - **Knob:** `head_d` and `neck_d`, with the head starting 0.1 mm above the
     slot floor. Printed sideways, both are pointed toward the slot's open
     end (down in print), and the neck runs to the same point as the head,
     so no layer of the head floats.
   - **Print orientation:** each block stands on the end its cup slot opens
     through. The cross-section is a 2D XZ profile extruded along y, so pull
     off the glass and on the knob runs along the layers. The holder's
     weight shears the knob neck across the layers, but that load is small.
     Each block is about 33 × 37 mm on the bed and 22 mm tall.

## Tracker holder: design and why

1. **The case:** "Heltec Tracker LoRa Meshtastic Enclosure V3" on
   Printables (model 1204874), holding a Heltec Wireless Tracker and a
   3000 mAh battery. The sizes come from its STLs, not from a printed
   case.
   - **Outline:** 50.8 × 82.55 × 27.94 mm, with the front and back edges
     rounded 6.35 mm and the corners 3.2 mm seen from the front. It's
     symmetric front to back.
   - **Antenna end:** the SMA bulkhead (6.35 mm hole) is at mid-depth,
     12.07 mm off centre (`antenna_x`). The power switch slot is in the
     same end.
   - **USB end:** the USB-C notch is centred, at the display edge. The
     two buttons are on the display face, 8.25 mm either side of centre
     and 7 mm from this end.
2. **Upright, antenna up, display into the room:** the case stands on its
   USB end, so the USB-C plug comes in from below.
   - **The other way round:** with the display toward the glass, the
     plug's overmold would hit the back. The holder isn't made for that.
3. **One cup, slot opening down,** as on the box holder. The holder
   hangs on the knob, and the case's centre is over the cup.
   - **Twisting:** a single cup can turn on its knob. The antenna's
     12 mm offset is the only off-centre load, and it's small.
   - **Lock bar (the user asked for it):** it slides sideways through a
     channel across the cup block at head-pocket height, just under the
     seated head, so a knock from below can't lift the holder off the
     knob. It's the antenna clamp's bar: a stop head at one end, and
     two prongs whose barbs snap past the far side of the block.
     Squeeze the prongs to pull it out.
     - **Wider cup block:** round the channel, a band of the block
       spans the flat of the back (±19.05 mm), so the slit prongs sit
       clear of the slot and the solid bar crosses under the head. An
       assert checks this. Elsewhere the block is only `block_lines`
       round the slot. Below the channel the band widens at 45°, so in
       print it grows out of the narrow block.
     - **Prongs:** `prong_lines` (6) wide each, `snap_len` (12 mm) long.
       That's shorter than the antenna clamp's 14 mm, to keep them
       outside the slot, so they bend about 1.5% at the barb.
     - **Play:** the head can drop 0.6 mm before it meets the bar (the
       slot clearance plus the bar's clearance).
     - **Size:** the bar is about 45 × 6.4 × 3.2 mm.
   - **Feet (the user asked for a brace near the bottom):** two struts at
     the bottom corners reach to `foot_gap` (0.5 mm) short of the glass.
     They stop the holder rocking on the cup when the buttons, which are
     near the bottom, are pressed.
     - **Outriggers:** the cup (61 mm) is wider than the holder (55 mm),
       and it slides in from below. So each foot's pad sits
       `foot_clearance` (1 mm) past the cup's rim, and its inner edge
       stays outside the cup's outline in the cross-section.
     - **Shape:** each foot is a solid XZ profile from the back and the
       side wall out to a `foot_w` (4 mm) pad, extruded `foot_len`
       (10 mm) up from the bottom edge. In print it stands on the bed.
     - **Width:** the feet make the holder 71 mm wide.
4. **A channel that hugs the case:**
   - **Cross-section:** the case's outline offset by `clearance` (0.5),
     plus `shim_space` (2.5 mm) at the back for the shim, with a
     `wall_lines` (4, 1.62 mm) shell round it. Lips reach `lip`
     (7.5 mm) in from each side, just past the rounded edge onto the
     front.
   - **Clear of the face:** the lips stop at ±17.9 mm. The buttons are at
     ±8.25 mm, and the display window is within ±8.5 mm.
   - **Fitting:** the case slides down from the top onto two ledges.
     `top_open` (15 mm) of it sticks out above the holder, with the
     antenna and switch, to lift it out by.
   - **USB gap:** the bottom is open across `usb_gap` (24 mm) in the
     middle for the plug and cable.
   - **Shim:** see item 7. Without it the case would have 3.5 mm of play
     front to back, so the holder isn't meant to be used without it.
5. **Print orientation:** on its bottom edge, like the phone holder. The
   whole cross-section lies in each layer, so the case pushing on the
   lips and the cup pulling on the slot load the layers along their
   length. About 71 × 48 mm on the bed with the feet, and 71 mm tall.
   - **Lock bar channel:** in print, its ceiling is a 3.8 mm bridge on
     each side of the slot, as on the antenna clamp.
   - **Lock bar:** flat, so its prongs flex along the layers.

6. **ASA, for a hot car (the user's choice):**
   - **Heat:** ASA's heat deflection temperature (about 95 °C) is above a
     closed car's cabin in the sun. The loads are small (a case of about
     150 g), so creep isn't a concern.
   - **Lightened:** the walls went from 5 lines to 4, as on the phone
     holder, and the cup block narrowed outside the lock bar's band.
     That took the holder from 30.7 to 22.8 cm³, about 26% less, without
     touching the feet, ledges or slot. The feet were 2.8 cm³ of the
     30.7. Deepening the channel for the shim brought it back to
     23.6 cm³.
7. **Anti-rattle shim (the user asked for a thin TPU shim that attaches
   to the mount):** in a car, the case rattled in its 0.5 mm clearance.
   - **What it does:** a TPU sheet lines the flat of the channel's back.
     Four fins on it press the case forward against the lips, and the
     friction of that stops it moving sideways or up as well.
   - **Why the channel is deeper:** a shim that fitted the 1 mm of play
     would have to squash, not flex. `shim_space` (2.5 mm) leaves a
     3.5 mm gap behind the case for the shim, which is 4 mm thick
     uncompressed (`shim_preload` 0.5).
   - **Fins, not ribs:** the first version had solid trapezoid ribs.
     Squashing them 0.5 mm along their length came to roughly 2,000 N,
     so it was changed before printing.
     - **Shape:** each fin is `fin_t` (0.9 mm, 2 lines) thick and leans
       outward at 45° from the sheet, so the case bends it down. Two
       lean each way, so they don't push the case sideways.
     - **Force:** a beam estimate gives about 12 N at the default
       preload, at about 5% strain at the root. TPU's stiffness varies
       a lot between filaments, so it could be 10–25 N. The phone
       holder's 6 N was easy to slide; 10 N was hard with a soft case.
   - **Holding it:** the shim stands on the ledges. Two diamond studs on
     the channel's back (`stud_x`, `stud_up`) snap into diamond holes
     near its bottom, so the case can't drag it up.
     - **Studs:** their top halves are cut back at 45° from the back, a
       ramp the shim's bottom edge rides up as it slides down. Their
       flat bottom faces hold it.
     - **Lips:** the shim is wider than the gap between the lips, so it
       can't fall out forward when the case is out.
     - **Fins:** they stop above the studs, so the studs' holes stay
       clear.
   - **Fitting:** slide the shim down from the top, fins out, until it
     clicks onto the studs, then slide the case in. The fins' top ends
     slope down as a lead-in. To remove the shim, lift its bottom edge
     off the studs through the gap at the bottom.
   - **Print orientation:** flat, its plain back on the bed. The fins'
     undersides are 45° overhangs, which print without support.
   - **Heat:** TPU is fine at car temperatures, but compression set
     grows with heat. If the grip fades, raise `shim_preload`.

## Tracker case: design and why

1. **The board:** a bare Heltec Wireless Tracker V1.1, without pin
   headers (the user's), and no battery (the user's choice; a LiPo in a
   hot car is a risk).
   - **Sizes:** from Heltec's dimension drawing (Wireless Tracker V1.1
     datasheet, section 4,
     https://resource.heltec.cn/download/Wireless_Tracker/Wireless%20Tracker1.1.pdf):
     PCB 63.64 × 28 mm, USB-C shell 2.2 mm past its end, GNSS patch
     4.6 mm tall over the last 20 mm, display 3.6 mm tall.
   - **Read off the drawing and pin map, not measured:** the display's
     visible area (`screen_y0`, `screen_y1`, `screen_w`), the buttons
     (`button_x` 8, `button_y` 4.6), the U.FL socket (about 9.7 mm left
     of centre, 20 mm up), and `pcb_t` (1.2). `button_h` (1.8) and
     `under_space` (4.5) are guesses: the drawing doesn't show the
     buttons' height or the board's underside.
   - **Facing:** USB down, display toward the room, as on the tracker
     holder (the user's choice). RST is then on the right seen from the
     room, USER on the left, and the U.FL socket on the left.
   - **GNSS:** the patch faces the room, with the board between it and
     the window, so the fix will be weaker than with the patch facing
     the sky.
2. **Two parts and a lock bar:**
   - **Base:** a channel with a back, two side walls and a bottom end,
     open at the front and the top. It holds the cup slot, the lock bar
     channel and the feet, all as on the tracker holder.
   - **Lid:** the front plate and the top end wall.
   - **Why the top end is on the lid:** the base prints on its bottom
     end, so a top end wall on it would be a ceiling. On the lid, which
     prints face down, it stands upright.
3. **Holding the board:**
   - **Across and in depth:** it drops in from the front onto two rails
     under its long edges (`rail_lines`). Skirts down the lid's long
     edges press the edges onto the rails, `pcb_preload` (0.1) into
     them. Only the 1.5 mm strip at each edge, where the header pads
     are, is touched.
   - **Along its length:** blocks either side of the USB opening stop
     its bottom end, and 45° wedges on the side walls catch its top
     corners, which print without overhang. Both stay below the PCB's
     top face.
4. **Snaps:** four diamond bumps on the skirts (`snap_y`, two each side)
   go into diamond windows in the base's side walls.
   - **Faces at 45° all round:** they ride in over the walls' lead-in
     and come out again with a firm pull, so no tool is needed. Pull the
     SMA connector first, then the bottom.
   - **Preload:** the windows sit `detent_clearance` × √2 low, so the
     board pushing the lid up by `pcb_preload` presses the bumps on the
     windows' top faces and the walls' spring holds the board.
   - **Flex:** the base's walls flex out over the bumps, along their
     layers. The skirts are shorter and stiffer, so they bend less.
5. **Buttons (the user asked for built-in ones):** a tongue in the front
   plate over each button, `key_layers` (3, 0.84 mm) thick, freed by a
   slit, with a plunger under it to `button_gap` (0.4) above the button.
   - **Shape:** the tongues run outward from roots near the centre
     line, below the window. Rooted above, they would run beside the
     window, which leaves no room.
   - **Force:** a beam estimate gives about 2.5 N to bring the plunger
     down 0.65 mm, plus the button's own force, at about 0.8% strain.
   - **Print:** the tongues lie in the first layers, so they bend along
     the layers.
6. **Display (the user asked for it exposed):** an open window
   `window_margin` (1 mm) round the visible area, widening at 45° to
   the front so it can be seen from an angle.
7. **USB (the user asked for it accessible):** an opening through the
   bottom end for a `usb_plug_w` × `usb_plug_h` (13 × 7.5 mm) overmold.
8. **Antenna (the user asked for the pigtail's nuts held secure):** the
   SMA bulkhead goes through the lid's end wall, `sma_wall_lines` (5,
   2 mm) thick, pointed toward the back.
   - **Inner nut:** two walls on its flats, inside the end wall, stop it
     turning, so the outer nut can be tightened with one wrench. The gap
     between them is open toward the back, and the nut slides in along
     the thread.
   - **Height:** the nut's corners face the lid and the back, so
     `sma_up` (1.5) is about as high as the axis can go under the lid
     plate. An assert checks it.
   - **Head space:** the case runs `sma_inside` + `cable_rise` (21 mm)
     past the board's top end. `sma_inside` (12) is an estimate of the
     inner nut, body and crimp. `cable_rise` (9) lets the 1.13 mm cable
     bend up over the GNSS patch at about a 5 mm radius.
   - **Cable:** it runs over the patch's left edge and down beside the
     display to the U.FL socket. `cable_space` (1.9) over the patch
     leaves room for it.
9. **Mounting, as on the tracker holder:** one cup, slot opening down,
   the case centred over it.
   - **Lock bar:** the band round its channel is `band_hw` (19.05) wide,
     so the tracker holder's bar fits; it sticks out 3 mm past the case
     at the back.
   - **Feet:** at the bottom corners, outside the cup's rim. Their inner
     edge rises straight from the pad for 2 mm before sloping in. The
     tracker holder's slope alone clipped the cup's rim by about 0.3 mm
     as the cup slid in.
10. **Print orientation:**
    - **Base:** on its bottom end. About 71 × 28 mm on the bed with the
      feet, 91 mm tall, 17 cm³.
    - **Lid:** face down. About 29 × 89 mm, 13.5 mm tall, 5.9 cm³.
    - **Lock bar:** flat.
    - **Material:** ASA, as for the tracker holder, if it's for a car.

## Hat stretcher: design and why

1. **Made for a flat cap,** 57 cm. The user chose an adjustable form
   (56–61 cm) over a fixed one size up.
   - **Size:** closed it's `closed_circ` (555 mm), so it drops into the
     cap; `stretch` (28 mm) adds twice that, to 611 mm. The oval's
     semi-axes come from `closed_circ` and `width_ratio` (0.8, a typical
     head) by Ramanujan's perimeter formula.
   - **Height:** `form_h` 25 mm. It was 50, but the user found the cap's
     band is narrower, and half the height works.
2. **Two halves split across the middle, spread front to back.** As they
   spread, the band runs straight across each side gap: both halves meet
   the split parallel to it, so the form becomes an oval with straight
   sides and the band isn't creased. So nothing needs to cover the gap;
   sliding strips that did would force straight sides on the closed form
   too, making it boxy.
3. **Turnbuckle, not a single screw.** A rod with a right-hand thread at
   one end, a left-hand one at the other and a knurled wheel in the
   middle. Each end runs in a printed nut captive behind a cross wall.
   - **Why:** the halves can then be identical, and the wheel sits in the
     gap between the cross walls (each `setback` from the split), reached
     through the open bottom, instead of a knob deep inside one half.
   - **Threads:** BOSL2 trapezoidal, 10 × 2.5 mm, `thread_angle = 90`
     (45° flanks), the same as the box holder, with 16 mm nuts 10 mm
     thick. One turn spreads 5 mm. The rod is in compression, across its
     layers, which is fine.
   - **Sized by the height:** the rod sits at mid-height (`rod_z`), as the
     flip symmetry requires, so the wheel and the nut slot must fit
     within `form_h`.
     - **At 50 mm:** the thread was 14 × 3 mm, with a 40 mm wheel and
       22 mm nuts.
     - **At 25 mm:** those would stick out of the form or break through its
       bottom.
     - **Now:** the wheel is 23 mm (`wheel_d`), so the form still stands
       on the table, and its scallops are spaced from its size
       (`knurls`).
     - **Asserts:** they catch a wheel or nut that's too big for
       `form_h`.
   - **Travel:** each thread reaches 1 mm past the back of its nut at
     full stretch; the threads running out is the stop.
4. **Identical halves.** The front half is the back half rotated 180°
   about the Y axis through the rod, so everything mirrors front to back
   and top to bottom. One STL, printed twice, both upright.
   - **Guide fins:** each half has two fins in its lower half (at
     `±fin_y`) reaching across into full-height slots in the other half.
     The other half's fins sit above them at the same y. They keep the
     halves in line (yaw and sideways); at full stretch they still reach
     `fin_engage` (12 mm) into the slots.
   - **No tongue between the stacked fins:** with identical halves the
     interface between them must be flat, because the rotation keeps y
     and swaps above and below. Vertical location comes from the rod and
     the table.
   - **Nut slot:** opens upward in print. In the turned-over half it
     opens downward, but the rod through both ends of the slot keeps the
     nut in.
5. **Vents:** diamond windows through the oval wall (`vents`) let the
   inside of a damp band dry. Their 45° sides print without support.
6. **Heat:** PETG softens in steam, so the notes say to steam the cap
   before fitting it, or print in ASA to steam it in place.
7. **Print orientation:**
   - **Half:** upright, as modelled. Every wall is vertical, the fins
     stand on the bed, the rod hole is a teardrop. About 150 × 157 mm, so
     one half per plate.
   - **Rod:** standing on its right-hand end. The wheel's underside is a
     45° cone that starts at the thread root, covering the thread's end.
   - **Nuts:** flat, marked R and L on top.
8. **Thicknesses, in 0.45 mm lines at 0.28 mm layers:** oval wall 5
   lines, cross wall, nut block and slot walls 6, fins 10.
9. **Vents:** `vent_w` is 12 mm (18 at the old 50 mm height), so the wall
   keeps a 6.5 mm rim above and below each diamond.
10. **Braces (`part="brace"`):** the user found the halves flexed where the
    turnbuckle joins. The rod pushes on the nut block in the middle of the
    cross wall, and the band pushes back on the oval wall at the cross wall's
    ends. The cross wall is 6 lines (2.4 mm) thick, about 157 mm long, and
    bends edgewise, so its middle bows back.
    - **What the brace does:** it carries the thrust from the back of the
      nut block straight to the back of the oval wall, where the band's
      force arrives, so the cross wall no longer bends.
    - **Shape:** a triangle in plan. A collar fits round the nut block and
      bears on its back face either side of a slot for the rod end
      (`rod_end` plus 2 mm). Two legs (`brace_leg_lines`, 10) run from the
      collar's back corners to a curved pad. The pad stands
      `brace_pad_gap` (3 mm) off the wall and bears on it through feet at
      ellipse angles `brace_feet` (±10° and ±30°), between the vents (0,
      ±20 and ±40°), so the vents still breathe. A spine runs from the
      collar straight back to the pad's middle.
    - **Why not hooks over the cross wall:** the user first asked for
      triangles that slide over the cross wall and the guide walls. A part
      behind the cross wall can only be held back by a face looking
      forward. That means either a hook over the cross wall's top, which
      sticks out above the back half and below the turned-over front
      half, so the form rocks on the table, or the oval wall's inner face.
      The user chose the oval wall.
    - **Fit:** it drops in from the open side of each half (from the top
      in the back half, from the bottom in the front half). It fits halves
      already printed, unchanged. The collar's `brace_side_clearance`
      (0.15 mm a side) is snug, so the brace stays in when the form is
      lifted. The feet clear the wall by `brace_clearance` (0.2 mm), which
      the band takes up as soon as it pulls.
    - **One STL, printed twice:** it's a 2D outline extruded `brace_h`
      (24 mm), symmetric in y. Both braces stand on the table, 1 mm below
      the form's top.
    - **Print orientation:** flat, as modelled. Every face is vertical, and
      the thrust runs along the layers. About 83 × 83 mm, 29 cm³ (37 g of
      PETG).

## Succulent liner: design and why

1. **The pot has no drainage hole,** so succulents planted straight in it
   sit in water and rot. The liner is `liner_h` (54 mm) tall overall
   (the user found a liner reaching to 8 mm off the floor much too
   tall, and chose 54 mm to clear the curve at the cup's bottom), so its
   floor stands 18 mm above the cup's bottom, room for about 44 ml of
   runoff. An assert keeps at least `spacer` (8 mm). A
   hex grid of 3 mm drain holes (`drain_d`) lets the water through. Lift
   the liner out to tip the water away. There's about 52.6 mm of soil.
2. **It hangs from the rim, with no feet (the user's call).** A collar
   rests on the rim, and the liner hangs in its bore by a 45° flare round
   its top (`flare`, 1.5 mm), seated in a matching countersink. The
   liner's top is flush with the collar's.
   - **Clearance:** the liner is 54 mm across, `clearance` (1 mm) a side
     inside the cup, so it clears the walls and the curved bottom. The
     bore is `bore_clearance` (0.3 mm) a side round the liner.
3. **Collar (the user asked for it):** a lip `lip_t` (3 mm) thick on the
   rim, and a skirt `skirt_h` (10 mm) down the outside, 0.75 mm clear of
   the cup (`skirt_clearance`), so the skirt centres it. It's about
   73 mm across. The first print came out 0.5 mm small inside (67.5 mm
   for 68 drawn), so `skirt_clearance` went from 0.5 to 0.75.
   - **History:** the user first asked for the lip to reach 13 mm out,
     from a 12 mm rim measurement that turned out wrong. With the real
     6 mm rim, the user chose a skirt that hugs the cup.
   - **Chamfers (the user asked for them, for printing):** 45° on the
     lip's outer top edge, the skirt's bottom edges and the bore's
     bottom edge.
4. **Vine (the user asked for it):** debossed `vine_depth` (0.6 mm) round
   the skirt. A stem makes `vine_waves` (6) waves, with a leaf rising
   from each trough and one hanging from each crest.
   - **Build:** each groove is hulled from thin slices with a 45° V, or
     a flat-bottomed trapezoid where it's wider than twice the depth,
     placed along the path on the cylinder. Their faces are never
     steeper than 45° from vertical, so they print on the vertical
     skirt.
   - **Asserts:** they check that the vine leaves 1 mm of skirt behind it
     and that every leaf stays on its band.
5. **Two parts:** the skirt hangs from the lip, so the collar can only
   print upside down, and in one piece the liner's floor would then be a
   54 mm bridge with holes in it.
6. **Print orientation:**
   - **Liner:** upright, on its floor. The walls and drain holes are
     vertical and the flare's underside is 45°. 4-line walls, a 5-layer
     floor, 16.9 cm³.
   - **Collar:** upside down, top on the bed. 5-line skirt, 9.8 cm³.

## Pocket utility knife: design and why

1. **Someone else's design, edited by import.** The three STLs share one
   frame: x along the knife (nose at -X, ring at +X), the Bottom's plate at
   z 0–2 with the blade cavity under it. The slide extends the blade
   toward -X.
   - **Licence:** the Printables page couldn't be read, so its meshes stay
     out of git, like the MTG card scanner's.
2. **Lettering removed (the user asked, for simpler prints):** a word
   engraved 0.5 mm into the Bottom's z = 2 face and "F1" 0.75 mm into its
   z = -4 face. Each is filled with a box from the face to 0.5 mm past its
   floor. The Top and Slide have none.
3. **How the stops work:**
   - **Pegs:** the Slide carries the blade in a 0.6 mm pocket. Its two pegs
     (Ø3.5, 6.5 mm apart, `peg_pitch`) pass through the blade's back
     notches and ride in the Bottom's slot.
   - **Fingers:** a sprung finger beside each end of the slot, freed by a
     slit on the slot's +y side, drops a 0.8 mm bump next to the end peg.
   - **Original stops:** retracted (as modelled, tip 2.7 mm inside the
     nose) and extended, 23.57 mm on (tip about 21 mm out along the edge).
4. **Third stop (the user asked for about 3 mm out, for box cutting):**
   `mid_stop` (3.0) sets it, in the units `mid_stop_measure` picks: the
   tip past the nose square to its face (`square`, the default), along
   the edge (`edge`), or the slide's travel from retracted (`travel`).
   The file works out `mid_travel` (6.51 mm by default) from the modelled
   blade, and every render echoes all three measures.
   - **Range:** 6.5–17 mm of travel, about 3.0–11 mm square. Below it the
     bump would press on a peg when retracted, and above it the pegs
     reach the extended stop. Asserts check both, and the low one names
     the least `mid_stop`. Fit, overhang and manifold checks pass across
     the range.
   - **What moves with it:** the bump, the finger and its slit
     (`finger_len` from the bump's middle) and the free-end gap.
   - **Bump:** fills the waist between the two pegs, clipped by the pegs'
     real footprint (from the Slide STL, with their root flare) at every
     stop, `bump_clearance` (0.1) clear. A peg meets it about 55° from
     the slot's axis, so it holds both ways, at least as firmly as the end
     bumps.
   - **Why at least 6.5 mm of travel:** any closer to retracted and the
     bump would press on the rear peg there. An assert keeps
     `mid_travel` at least `peg_pitch`. The user chose 6.5 over 5.75 mm, which would have
     needed a trimmed bump with 0.75 mm of play.
   - **Finger on the -y side:** the +y side has no room between the two
     existing fingers; a third would share a 1 mm root with one of them.
     The new finger mirrors their 2 mm width and 1.25 mm slit. Its root is
     `finger_len` (4.25 mm) from the bump's middle, as on the existing
     fingers, and a gap past the bump frees its end.
   - **Under it:** the finger lies over the blade cavity (to y -20.6). Its
     slit's outer edge lies over solid wall, so in print the slit has a
     1.25 mm bridged top.
5. **Print orientation:** the Bottom prints with its z = 2 face on the bed,
   the only way its plate doesn't bridge the cavity. The engraved word
   there printed as 115 mm² of bridged letter floors, which are now gone.

## Card scanner: design and why

1. **Stack in the box (the user's choice over a ramp):** each card is laid
   face up on the stack in an open box, under the camera.
   - **Why:** no ramp, least material, and the box walls keep the cards
     aligned.
   - **Unloading:** lift the box out and push the stack up through the
     hole in its floor (the user asked for this).
2. **Height (the user asked for it adjustable):** `cam_h` is measured
   from a full stack (the box's rim) to the lens (the user's choice). It
   can be set anywhere from `cam_lo` (130 mm) to `cam_hi` (205 mm).
   - **History:** it was a fixed 203.2 mm (8 in), the user's first ask,
     past the iPhone main camera's close-focus distance. The user found
     that too tall, and chose the range.
   - **Shelf top:** 181.4–256.4 mm.
   - **`bump_proud`:** 0, because with a case whose camera ring is flush
     the lens sits at the case's back.
3. **Phone:** screen up, its top end (the lenses) toward the front over
   the box, and its body back over the tower (the user's choice).
   - **Shelf length (the user asked for this):** `shelf_len` is 120 mm.
     The rest of the phone hangs off the front, so any phone with its
     lenses at the top works. The screen reads upside down from the front.
   - **Defaults:** the iPhone 16 Pro in its case (153 × 72 × 11 mm). Its
     main lens, at the top right of the face, is taken as 16.5 mm from
     the top and side edges (`lens_from_top`, `lens_from_side`, estimates).
     The box is centred `box_dx` (2.6 mm) in front of it (see item 8).
   - **Other phones:** the lens lands `phone_l - shelf_len -
     lens_from_top` past the shelf's front edge. A different phone moves
     it a little front to back, which the camera's wide view absorbs.
   - **Locating:** a back stop at the phone's bottom end, and side lips
     `phone_w` plus clearance apart.
   - **No platform (the user's call):** the phone lies on three rails.
   - **History:**
     - The first version had the top end toward the tower.
     - The second had a notch in the shelf under the camera and the
       shelf in one piece with the tower.
4. **Box:** for the largest card, a double-sleeved 67 × 93 mm, plus
   `card_clearance` (1.5 mm) a side. Inside it's 96 × 70 × 50 mm, with
   3-line walls.
   - **Push-out hole:** 74 × 50 mm. Sized so an unsleeved card anywhere in
     the box still rests `floor_overlap` (3 mm) on the floor each side.
   - **Vents (the user asked for them):** pointed slots, 4 × 20 mm, round
     the bottom of all four walls. They let air out from under a
     dropping card, so it settles faster. The table closes the floor's
     hole, so it doesn't vent.
5. **Tower (the user asked for it centred on the base, with the shelf
   separate, and then for its height to be adjustable):** a mast that
   slides in a sleeve, clamped by an M3 thumbscrew. The user chose a
   clamp and a scale over index holes, so any height works, and asked
   for parts printed, apart from M3 screws and nuts. Magnets aren't used,
   because a magnet detent can't hold between steps.
   - **Sleeve:** a U-channel round the mast, 6-line walls, its floor
     toward the box and its mouth at the back (-X).
     - **Lips:** at the mouth, they cover 45° chamfers (`mast_chamfer`,
       3.5 mm) on the mast's back corners, so the mast can't come out
       backward.
     - **Bottom stop:** a crossbar across the U at its foot. The mast
       rests on it at `cam_lo`.
     - **Foot:** it presses into the base's socket and stands on a 45°
       ledge 12 mm up.
     - **Top:** 2 mm under the shelf at `cam_lo`.
     - **Overlap:** at `cam_hi`, 74 mm of mast stays in the sleeve; an
       assert keeps at least 55.
   - **Clamp:** an M3 bolt in a boss on the sleeve's +Y wall, 10 mm below
     its top (`clamp_down`). It threads through a captive nut and presses
     the mast against the far wall.
     - **Nut slot:** opens through the mouth (up in print), its walls on
       the nut's flats.
     - **Bolt hole:** pointed toward the mouth.
     - **Bolt:** M3 × 12 to 20, socket head, with the printed knob
       pressed on. The knob is 14 mm across, so at `cam_lo` it clears the
       shelf; an assert checks it.
   - **Mast:** the truss column, two chords 30 mm apart with 4-line
     diagonals, 24 mm across, sliding with `sleeve_clearance` (0.2 mm) a
     face.
     - **Back chord:** `clamp_chord` (10 mm) wide, so the bolt always
       bears on solid chord, on the flat beside the chamfer. The front
       chord is 6 lines.
     - **Scale:** engraved 0.5 mm into the back chord, read from behind
       at the sleeve's top edge. A tick every 5 mm, longer every 10, and
       numbers (the lens-to-stack distance) every 25 and at 130.
   - **Top:** a solid tenon, `tenon_w` (16 mm) across, flush with the
     column's -Y face.
     - **Why narrower:** the three pockets are only 19.5 mm apart, so a
       full-width tenon would leave no walls between them.
     - **Why flush:** that face is on the bed in print, so the tenon
       needs no overhang.
6. **Shelf, three positions (the user asked for left, centre and right):**
   - **Mounting (the user asked for all four walls, for friction):**
     three pockets under the shelf, each walled on all four sides with a
     ceiling. The tenon presses into one, so the shelf sits at
     `shelf_pos` × `shelf_off` across.
   - **Offsets:** `shelf_off` is `phone_w / 2 - lens_from_side` (19.5 mm),
     so the lens comes over the box's centre.
     - **Right (+1):** lenses at the top right of the face (iPhone).
     - **Centre (0):** lenses in the middle.
     - **Left (-1):** lenses at the top left.
   - **Held:** the press fit on all four sides holds it on, and the
     pocket stops it moving any way.
   - **Structure:** three rails, 14 mm deep: one under each lip and one
     down the middle. The rails and crossbars make a closed box frame.
     - **Back:** the back stop runs down to the rails' bottoms and ties
       their back ends.
     - **Front:** a crossbar, flush with the rails' tops, ties their
       front ends (the user asked for the closed frame).
     - **Middle:** a shell round each pocket (3.5 mm ceilings), with
       its front and back walls carried across the full width to the
       outer rails.
7. **Press fits (the user asked for them):** the sleeve's foot in its socket and
   the tenon in its pocket are drawn size for size on all four sides
   (`socket_clearance` and `pocket_clearance` are 0). A 45° lead-in, `lead_in` (1 mm), at
   each mouth starts them.
   - **Tuning:** raise the clearance if a joint won't push home, or make
     it negative if it's loose.
   - **History:** the shelf first had a channel open at both ends, and a
     ridge on the tenon in V grooves, so only two faces gripped.
8. **Base:** two rails and three crossbars, 10 mm high, and the sleeve's
   socket, centred behind the box. The socket is 25 mm deep
   (`socket_depth`), because the sleeve's lever is longer than the old
   tower foot's.
   - **Box offset:** the sleeve's floor sits where the socket wall used
     to be. So the box, its frame and the front crossbar move `box_dx`
     (the floor plus its clearance, 2.6 mm) forward. The mast and shelf
     stay where the fixed tower had them, so the shelf printed for it
     still fits, and the lens is 2.6 mm behind the box's centre.
   - **Rails:** they run back under the phone's bottom end, so pressing
     either end of the phone can't tip the scanner. Crossbars tie them
     at the back end, behind the box and in front of it.
   - **Box:** it stands on the table inside the frame and lifts out.
9. **Print orientation:**
   - **Mast:** on its side, -Y down. The column is a 2D side profile
     extruded up from the bed, so it bends along the layers. The
     chamfer on the bed edge is a 45° overhang. About 162 × 30 mm on the
     bed, 24 mm tall.
   - **Sleeve:** on its floor, mouth up, so its bending also runs along
     the layers. The lips lean in at 45°, and the clamp boss's lower end
     is cut back at 45° to the wall. About 153 × 34 mm on the bed, 33 mm
     tall.
   - **Knob:** flat, head pocket up.
   - **Shelf:** right side up, standing on its rails, crossbars and
     pocket walls.
     - **Bridges:** its only bridges are the pockets' ceilings, 16 × 30 mm
       each (the user's printer bridges well).
     - **Size:** about 123 × 76 mm, 18 mm tall.
   - **Base and box:** flat, as mounted.
   - **Plastic:** about 56, 38, 29, 29 and 23 cm³ (mast, sleeve, shelf,
     base, box), and under 1 cm³ for the knob.
10. **Camera's view:** a cone from the lens to the largest card on the box
   floor clears every part and the phone, at every height.

## MTG card scanner: design and why

1. **Someone else's design, not committed.** `ScryScanner.3mf` (Bambu
   Studio) is under MakerWorld's Standard Digital File License, which
   doesn't allow sharing the files or derivatives. The project's
   `.gitignore` keeps every `.3mf` and `.stl` out of git; only
   `scry_scanner_magnets.scad` and `scry_3mf.py` are ours.
2. **Magnets the user has:** 3 × 1, 10 × 3 and 18 × 2 mm discs.
   - **Lid and body top:** the original's 15 × 2 mm discs become
     18 × 2 mm. The new pockets cover the old ones, at y 83.75 instead
     of 83.5 to even out the walls.
   - **Tray insert and the body's tray cavity:** the original's
     20 × 5 × 2 mm bars become one 10 × 3 mm disc per bar, about the same
     volume. There are four: one in each end face of the insert, and one
     in each end wall of the cavity (the second, at y = -21.25, is beside
     the column storage holes). The old slots are filled and a round
     pocket, pointed at the top for printing, is cut at each slot's
     centre.
   - **Walls:** at least 1.73 mm round the pockets (1.86 mm outside the
     disc pockets that replace the bars).
3. **Workflow:** `scry_3mf.py extract ScryScanner.3mf original` writes the
   parts' meshes in their own coordinates. The .scad imports them and
   edits only the pockets. Its `column` and `column_2` parts are the
   lid's two support dowels, imported unchanged; they render the same
   triangle sets as the originals. `scry_3mf.py replace` writes
   `ScryScanner_magnets.3mf` with the edited meshes, keeping the plates
   and print settings.
4. **Lightening (the user asked for less material):** `lighten_body`
   hollows the body, leaving every outside face, hole and socket as it
   was. The phone on the lid is the only load, carried by the columns
   into the end block.
   - **Where:** one void under the card ramp, its 45° gable roof
     following the ramp's 15° slope `skin_t` (3 mm) under it, and one in
     the column end block. Walls are `wall_lines` (8). With
     `open_bottom` they open through the underside.
   - **Why this layout:** the user prints with 2 perimeters and 10%
     infill (0.45 mm lines, 0.2 mm layers). At that infill a void only
     saves filament if it removes more infill than the perimeters and
     skins it adds. A voxel estimate for the body gave about 164 g as
     printed, 145 g for one open void, 148 g for two, 156 g for one
     closed and 172 g for four closed channels.
   - **Lid:** pockets under a 2 mm phone face added about 4 g, so
     `lighten_lid` is off.
   - **Outputs:** `scry_scanner_light_body.stl` and
     `ScryScanner_light.3mf` (light body, magnet-only lid and insert).
     The magnet-only body needs `-D lighten_body=false`.
5. **Checks:** differencing each edited part against the original leaves
   only the pocket regions (and, when lightened, the voids). The new pockets add no overhangs. To find
   every slot, search sections along all three axes for slot-sized loops
   of any vertex count. A first scan for 4-vertex loops missed the second
   bar slot in each part.
6. **Scanner V2.3 (`ScannerV2.3_profile.3mf`):** a different scanner,
   also not ours and not committed. It's a tower: a base plate, a frame,
   and a 2 mm phone platform on top (y 63–65), with a card slide and two
   card boxes. `scanner_v2_extension.scad` and `scanner_v2_3mf.py` are
   ours.
   - **Extracting:** `scanner_v2_3mf.py extract ScannerV2.3_profile.3mf
     original_v2` writes `v2_{scanner,slide,box_sleeved,box_unsleeved}.stl`
     in their own coordinates, which are the assembled orientation, +Y up.
     This 3MF keeps each mesh in its own file, so `scry_3mf.py` can't
     read it.
   - **Raising the phone (the user asked for about 50 mm more, for
     focus):** two attempts, both set aside for the new card scanner.
     - **Riser:** a snap-on cap over the platform. The user found it not
       sturdy enough, and it was removed.
     - **Stretched body (`part="body"`, unfinished):** the frame between
       y 22 (above the slide slot, y 4.8–15.2) and the platform is
       stretched 2.22× up Y. It stays braced, but the long diagonal rods
       then print at about 12° from the bed, and the overhang area grows
       from about 525 to 1710 mm² in the stretched zone. Not exported.
   - **Slide (the user asked for higher edges so cards don't fall off):**
     the 2 mm rails are raised to `slide_wall_h` (10 mm) above the ramp.
     - **Print:** on its edge, -X on the bed, as in the original 3MF. The
       layer lines then run down the ramp, along the cards' path.
     - **-X wall:** square to the ramp, solid down to the bed.
     - **+X wall:** at the top of the print a square wall would be a
       ceiling, so it leans out at 45° from the old rail's top inner
       corner. The slide is then 112 mm wide at the wall tops instead of
       101.
     - **Lane:** unchanged at the ramp: 92 mm, and 94 mm at the old rails'
       tops. The rails' own 2:1 sloped inner faces are the original's.
     - **Unknown:** how the slide sits on the scanner or box wasn't
       worked out, so the wider top hasn't been checked against them.
   - **Outputs:** `scanner_v2_slide.stl`, in print orientation.

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
   ends are acceptable:
   - **Antenna clamp body (either cup count):** the 3.8 mm ceiling of the
     lock channel, and the 1.8 mm and 4.2 mm flats at the closed ends of
     the cup slots.
   - **Box holder base (printed on its edge):** the 1.8 mm and 4.2 mm flats
     at the pointed end of the cup slot.
   - **Bird feeder:** the 1.8 mm and 4.2 mm cup slot flats, and the 10 mm
     bridge across the window top.
   - **Modular feeder:** the mount's 1.8 mm and 4.2 mm cup slot flats, and
     the 1 × 3.5 mm flat on top of each barb pocket in the tray. The panel,
     keys, perch, roof and roof brackets have none.
   - **Bird Buddy feeder:** the camera mount's lock bar channel ceiling
     (3.8 mm wide, the plate's length), and the 1.8 mm and 4.2 mm cup slot
     flats in the upper mount. In the upper mount, which prints
     tilted 15°, each flat shows up twice. There are also some zero-area
     slivers. The collar, cradle, cap, pins and frame have none.
   - **Bird Buddy on a post:** a 0.03 mm² sliver at the cap's inner
     ridge, and a zero-area sliver along the stem's bolt hole. The post
     mount, ball and ring have none.
   - **Phone holder angle adapter:** the 1.8 mm and 4.2 mm cup slot flats in
     each block, and a 0.02 mm² point at each knob tip.
   - **Tracker holder:** the 3.8 mm ceiling of the lock bar channel
     (11.5 mm long each side of the slot), the 1.8 mm and 4.2 mm flats
     at the cup slot's pointed end, and some zero-area slivers (also
     where the cup block's band starts to widen). The feet and the shim
     studs have none (the studs' sides are at 45°), and neither does the
     lock bar. The shim has none: its fins' undersides are at 45°.
   - **Tracker case:** on the base, the 3.8 mm lock bar channel
     ceiling (11.5 mm each side of the slot) and the 1.8 mm and 4.2 mm
     cup slot flats. On the lid, a 1.8 × 2 mm flat at the SMA hole's
     point. Both have some zero-area slivers. The lock bar has none.
   - **Phone holder:** the 1.8 mm and 4.2 mm flats at the bottom cup
     slot's pointed end, plus a sliver of facets at about 48° where the
     neck slot's circle meets its 45° point (a `$fn` artifact).
   - **Screw, nut and jaw:** none.
   - **Hat stretcher:** none (one degenerate sliver in the chamfer). The
     brace has none.
   - **Succulent liner:** none on either part.
   - **Pocket utility knife Bottom (z = 2 face on the bed):** only the
     new slit's 1.25 mm bridged top over the wall, at 0.01 mm into it
     (7.5 mm²). Laid on its z = -4 face instead, the original has about
     1,970 mm² of overhang, which is how its print orientation was found.
   - **Card scanner:** none on the sleeve, knob, base or box. On the mast,
     only the 0.5 mm-deep ceilings in the engraved scale. On the shelf,
     only the three pocket ceilings, 16 × 30 mm bridges.
   - **Scanner V2.3 slide:** only the original's +X
     rail inner face (1 × 70 mm at 63°, which the original has too) and
     zero-area slivers.
4. **Fit checks:** intersect the parts at each pose. Pass `part="none"` with
   `-D`, because an assignment before `include` gets overwritten.
   - **Antenna cap path:** the 2D `cap2d()` against `clamp_body2d()` plus the
     rod. Lower at `dx = cap_slide`, then slide home. Every pose must be
     empty.
   - **Box holder, poses that must be clear:** the jaw at both ends of its
     travel; the jaw lifting out at the drop-in opening; objects of 60, 62.5
     and 65 mm width by 20 and 25 mm thickness, inset 0.01 mm so faces that
     only touch don't count; the screw against the base; the nut in its
     slot, unrotated so its flats face ±Z.
   - **Bird feeder, poses that must be clear:** the panel seated and lifted
     out (10, 30 and 52 mm up); the knob at rest in each slot and on its
     way up from below.
   - **Bird feeder, poses that must overlap:** the panel moved 0.5 mm
     toward the glass, down or sideways; the knob moved 0.5 mm up, away
     from the glass or sideways.
   - **Modular feeder, poses that must be clear:**
     - The tray hanging on the mount, offset 0.01 mm from the mount face
       because the posts bear on it.
     - The tray lifted 5–30 mm along the mount face.
     - The tray pulled 0.5–8 mm away after a 21.6 mm lift.
     - The tray against the cups and glass at 0–27 mm of lift.
     - The cup knob at rest and on its way up into its slot.
     - The panel seated, 0.01 mm up because it rests on the channel, and
       lifted 10, 30 and 60 mm with the keys out.
     - Each lock key seated in the tray, and each key against the seated
       panel.
     - Each key sliding in from 1–20 mm out, with `lock_barb = 0`, because
       the arm flexes past the barb.
     - The perch seated, 0.01 mm up because it rests on the socket floors,
       and lifted 10 and 25 mm.
   - **Modular feeder roof, poses that must be clear:**
     - The brackets seated, offset 0.01 mm up and forward, and lifted 10,
       30 and 60 mm.
     - The roof seated, offset 0.01 mm up along its normal.
     - The roof sliding off forward 2–130 mm, with `roof_barb = -0.1`.
     - The roof against the mount, the cups and the glass.
     - The tray set (tray, panel, keys, perch) hanging, and lifted 22 mm
       and pulled away, against the roof and brackets.
   - **Modular feeder roof, poses that must overlap:**
     - A bracket moved 0.5 mm forward, down or sideways.
     - The roof moved 0.5 or 5 mm forward (the latch), 0.5 mm back (the
       stops), 0.5 mm up (the rails), 0.5 mm down (it rests on the rails)
       or sideways.
   - **Modular feeder, poses that must overlap:**
     - The tray moved 0.5 mm down, away from the glass or sideways.
     - The cup knob moved 0.5 mm up or away from the glass.
     - The panel moved 0.5 mm toward or away from the glass, down or
       sideways.
     - The panel moved 0.5 mm up or down with the keys in (the lock holds).
     - Each key moved 0.5 mm outward (the barb catches), inward (it
       bottoms out), up or toward the glass.
     - The perch moved 0.5 mm forward, down or sideways.
   - **Bird Buddy feeder, poses that must be clear:**
     - **Camera mount and its surroundings:** the camera mount, collar and
       collar pin against the tray set (hanging, lifted 5–22 mm, and pulled
       away 4, 8 and 30 mm), the feeder mount, its cups and the glass.
     - **Its cups:** each knob and cup body at rest. The neck path, head
       path and cup body sliding in 10, 25 and 40 mm from the open side.
     - **Lock bar:** the bar in its channel (0.01 mm up), against both
       knobs. Sliding in from 20, 80 and 150 mm with `cbar_barb = -0.05`.
     - **Collar and pin:** the collar in the fork (0.01 mm up), and slid
       out 5, 12 and 25 mm. The collar pin (0.01 mm up) against the mount
       and the collar.
     - **Cradle and camera:** at each 7.5° step from 0 to 45°, against the
       camera mount and collar, each other, the tray set (hanging, lifted and pulled
       away), the frame and the upper mount.
     - **Cap:** in each of those poses (with the camera, cradle and plug),
       against the camera mount and collar, frame, upper mount and tray set. At rest
       (0.03 mm up) against the camera, plug and cradle. Lowered in from
       5, 15 and 30 mm with `cap_detent = -0.05`.
     - **Camera and magnet:** the camera lowered into the cradle from 10,
       60 and 130 mm. The magnet in its slot, against the cradle and the
       camera.
     - **Turning:** the cradle lifted `spline_h` + 0.1 mm and turned half a
       step.
     - **Collar:** the cradle and camera lowered into it from 10, 30, 60
       and 100 mm. The cradle lifted 0.5 mm without the pin.
     - **Lock pin:** against the collar and mount, and against the cradle
       at each step.
     - **Panel:** the panel (box plus slab) in the frame, 0.01 mm up.
     - **Frame and upper mount:** the frame on the upper mount, 0.01 mm up.
       The upper mount against its knob, its cup body (at rest and sliding
       in 10 and 30 mm, with neck and head paths) and the glass. The frame
       and upper mount against the glass, the tray set (hanging, lifted
       and pulled away up to 30 mm), the feeder mount and the camera mount
       and collar.
   - **Bird Buddy feeder, poses that must overlap:**
     - The collar moved 0.5 mm up, down or back in the fork. Moved 0.5 mm
       out or sideways, it hits the collar pin.
     - The cradle seated half a step round (the teeth lock it), 0.3 mm
       lower (it rests on the seat) or 0.5 mm sideways.
     - The cradle lifted 0.5 mm with the pin in.
     - The cap moved 0.3 mm down (it rests on the camera) or 0.6 mm up
       (the detent).
     - The camera moved 0.8 mm back or sideways in the cradle.
     - The panel moved 0.6 mm sideways or down the slope in the frame.
     - The frame moved 1 mm sideways on the upper mount (the pins).
     - Each camera mount knob moved 0.5 mm deeper, up, down or off the
       glass, or 1 mm out against the lock bar. The upper mount's knob
       moved deeper or off the glass.
     - The lock bar pulled 0.5 mm up (the barbs catch) or pushed 0.5 mm
       down (the head stops).
   - **Bird Buddy on a post, poses that must be clear:**
     - **Which collar and cradle:** run these with them rendered and
       again with them imported from the variant's STLs.
     - **Clear:** measure each intersection's volume. Faces that only
       touch, like the collar pin's head on the fork, leave a
       zero-thickness result.
     - **Post mount:** against the collar and pins, and the wood (0.01 mm
       off).
     - **Turning:** at every 22.5° of camera angle, the cradle (0.05 mm
       up, as it rests on the seat), camera, magnet, plug, cap, cap screws
       and ring, against the post mount, collar, pins and wood.
     - **Cap:** at rest (0.03 mm up) and lowered on from 5, 15 and 30 mm,
       against the camera and cradle. The cap screws against the camera
       and magnet.
     - **Ring:** on the boss, turned 247.5° so the threads mesh, against
       the cap, camera and cradle. Passing over the stud (ball and stem),
       5–45 mm up its axis.
     - **Stem in the ball:** seated (0.01 mm up) and sliding in from 5
       and 10 mm.
     - **Stud:** at tilts of -33 to 38° (the keel side is negative) in
       eight headings, against
       the ring and cap.
     - **Panel:** the panel and stud at camera angles of 0, 90, 180 and
       270°, tilts of -33 to 38° and headings of -90 to 90° in 15° steps,
       against everything else and the wood.
     - **Screwdriver:** a pan head and a 6 mm shank, 150 mm out from each
       wood screw, against the post mount.
   - **Bird Buddy on a post, poses that must overlap:**
     - The stud moved 0.3 mm down, up or sideways.
     - The stem moved 0.3 mm sideways or toward its keel, or turned 5°,
       in the ball's pocket (the key).
     - The cap moved 0.3 mm down (it rests on the camera).
     - The ring turned 120° from its mesh (the threads engage).
     - The cap screws against the cradle (they bite into the spine).
   - **Phone holder, poses that must be clear:** with `fin_preload =
     -0.05`, the phone seated (0.01 mm up and back) and lowered in from
     10, 40, 80 and 150 mm above; each cup knob at rest, and swept 60 mm
     out toward its open end (neck and head hulled separately, because a
     hull of the whole knob fills in under the head); each cup body at rest
     and swept 60 mm out; the glass.
   - **Phone holder, poses that must overlap:** the phone seated at the
     default preload (only the fins); the phone moved 0.5 mm down, 0.5 mm
     out or 2 mm sideways; each knob moved 0.5 mm deeper, away from the
     glass or sideways; the glass moved up past `foot_gap`.
   - **Phone holder on the angle adapter, poses that must be clear:** the
     holder seated on both blocks (0.01 mm off the face); against the cups
     and glass; each block sliding 2–60 mm out of its slot; the blocks
     0.01 mm up on the cups; a cup knob at rest in a block and 5–40 mm out
     toward the open end.
   - **Phone holder on the angle adapter, poses that must overlap:** the
     holder moved 0.5 mm along y, sideways or off the face; the blocks
     moved 0.5 mm down, sideways or off the cups; a knob moved 0.5 mm
     deeper, sideways or off the glass.
   - **Tracker holder, poses that must be clear:**
     - The real enclosure (its three body STLs, moved into the holder's
       frame) seated 0.01 mm up, and lifted 10, 30, 60 and 85 mm.
     - A 13 × 7.5 mm USB-C plug, 30 mm long, under the USB notch.
     - The cup knob at rest. The neck and head swept 10, 25, 45 and 60 mm
       out of the bottom, each hulled separately. The cup body at rest
       and slid the same distances, and swept 80 mm out as one hull.
       The glass, and the glass moved 0.4 mm up (inside `foot_gap`).
     - The case is modelled pressed against the lips, so its clear poses
       are offset 0.01 mm back.
     - The shim seated (0.01 mm up), and lowered in from 5, 20, 40 and
       60 mm above with `stud_h = 0`. The case against the shim with
       `shim_preload = -0.05`, seated and lifted 10, 30 and 60 mm.
     - The lock bar in its channel, against the holder and the seated
       knob. The bar sliding in from 5, 15, 30 and 45 mm out, with
       `snap_barb = -0.05`.
   - **Tracker holder, poses that must overlap:** the case moved 0.5 mm
     down, 0.6 mm sideways, 0.5 mm toward the glass or 1.2 mm forward
     (the lips); the knob moved 0.5 mm up, sideways or off the glass;
     the knob moved 0.8 mm down onto the lock bar; the glass moved
     0.6 mm up (the feet); the shim against the case at the default
     preload (the fins); the shim moved 0.5 mm up or sideways (the
     studs) or down (the ledges); the shim moved 31 mm forward (the
     lips); the bar moved 0.5 mm
     in (the stop head), out (the barbs), or along y or z in its channel.
   - **Tracker case, poses that must be clear:**
     - The lid on the base. With `detent = 0`, the lid lowered on from
       0.5, 2, 5 and 12 mm.
     - The board (PCB, USB socket, display, GNSS patch, buttons, U.FL)
       in the base, and lowered in from 2, 10 and 30 mm. Against the lid
       with `pcb_preload = -0.05`, seated and lowered on from 2, 6 and
       15 mm.
     - The plungers against the buttons.
     - The SMA bulkhead, its nuts, antenna and the modelled cable against
       the lid, base and board. The inner nut sliding in 5 and 15 mm
       along the thread.
     - A 13 × 7.5 mm USB-C plug against the base, lid and board.
     - The cup knob at rest. The neck and head swept 10, 25, 45 and
       60 mm out of the bottom, each hulled separately. The cup body at
       rest and slid the same distances, and swept 80 mm out. The glass,
       and the glass moved 0.4 mm up.
     - The lock bar in its channel, against the base and the knob, and
       sliding in from 5, 15, 30 and 45 mm with `snap_barb = -0.05`.
     - The lid against the cup and the glass.
   - **Tracker case, poses that must overlap:** the board moved 0.5 mm
     down (the rails), along y (the stops) or along x (the walls); the
     board against the lid at the default preload (the skirts); the lid
     lifted 0.15 mm (the bumps press on the windows) or 0.6 mm (they
     catch); the plungers moved 0.5 mm down (they reach the buttons); the
     inner nut turned 10° either way (the walls); the knob moved 0.5 mm
     up, sideways or off the glass, or 0.8 mm down onto the lock bar; the
     glass moved 0.6 mm up (the feet); the bar moved 0.5 mm in, out, or
     along y or z.
   - **Hat stretcher, poses that must be clear:** the two halves at 0, 7,
     14, 21 and 28 mm spread; the rod (plain cylinders for the threads,
     plus the wheel) against each half at each spread; the nuts (plain
     hex prisms, 0.01 mm off the cross wall) against both halves.
   - **Hat stretcher brace, poses that must be clear:** each half's brace
     (0.01 mm off the nut block) against its own half, the other half, the
     rod (plain cylinders plus the wheel), the nuts and the other brace, at
     0, 7, 14, 21 and 28 mm spread; the brace lowered in from 5, 12, 20 and
     26 mm above.
   - **Hat stretcher brace, poses that must overlap:** the brace moved
     0.5 mm forward (the nut block), back (the oval wall) or sideways (the
     collar).
   - **Hat stretcher, poses that must overlap:** the front half moved
     0.5 mm sideways (the fins), or closed past zero; the rod's wheel with
     the halves closed past zero; a nut moved 0.5 mm back, sideways or out
     of its slot's closed side.
   - **Succulent liner, poses that must be clear** (the cup is `cup()`):
     the collar on the cup (0.01 mm up); the liner in the collar
     (0.01 mm up), against the cup and the collar; the liner lowered in
     from 10 and 30 mm; the liner moved 0.9 mm sideways, against the cup.
   - **Succulent liner, poses that must overlap:** the collar moved
     0.5 mm down (it rests on the rim) or 1 mm sideways (the skirt);
     the liner moved 0.5 mm down (it hangs on the flare).
   - **Card scanner, poses that must be clear:**
     - **Press fits:** run these with `socket_clearance` and
       `pocket_clearance` at 0.05. At 0 a seated part only touches,
       with zero volume.
     - The sleeve in its socket (0.01 mm up), and lowered in from 5 and
       13 mm.
     - The mast resting on the sleeve's stop (0.01 mm up), and lowered
       in from 90 and 180 mm. The nut in its slot.
     - The box in the frame (0.01 mm up), and slid forward 60 and 140 mm
       at 11 mm up, against the base and sleeve.
     - At `cam_h` 130, 167.5 and 205:
       - the mast in the sleeve; the bolt against the sleeve; the knob
         against the sleeve, mast and base;
       - the box lifted 11 and 100 mm against the sleeve, mast, shelf and
         knob;
       - at each `shelf_pos` (-1, 0, 1), the shelf (0.01 mm up) against
         the mast, sleeve, base, knob and bolt, and the phone on the
         shelf (0.01 mm up);
       - the view cone (lens, 0.2 mm down, to the largest card on the
         box floor) against every part and the phone.
   - **Card scanner, poses that must overlap:**
     - At each of those heights, the mast moved 0.5 mm along X (the floor
       and the lips) or Y (the walls), and the bolt 0.1 mm further in
       (it bears on the mast). At `cam_lo`, the mast moved 0.5 mm down
       (the stop).
     - The sleeve moved 0.3 mm along X or Y (with `socket_clearance` 0),
       or 0.5 mm down.
     - The box moved 0.7 mm along X or Y.
     - At each `shelf_pos`, the shelf moved 0.3 mm each way along X and Y
       (all four pocket walls), or 0.3 mm down.
     - The phone moved 0.7 mm back (the stop), sideways (the lips) or
       down.
   - **Pocket utility knife, Slide against Bottom (intersection volume):**
     - **Clear:** at 0, `mid_travel` and 23.57 mm, at the default and
       with `mid_travel` at 6.5, 10 and 16 (`mid_stop_measure="travel"`). Also the new bump and
       finger alone at 0 and 23.57, and the modelled blade (`blade_at`)
       at all three.
     - **Overlap:** at `mid_travel` ± 0.2 and ± 0.5 (the new bump, both
       ways), at 0.5 and 23.07 (the original bumps), and past either end.
     - **Diff against the original Bottom:** only the two lettering
       areas, the bump, and the slit and its gap.
     - **Unchanged:** the Top and Slide exports have the originals'
       triangle sets.
     - **Manifold:** the Bottom has a sliver under 0.01 mm where the
       bump meets the slot's chamfer at z = 0. With exact vertices every
       edge is shared by two triangles; rounding to 4 places merges it and
       flags 4 edges.
   - **Bird feeder diff:** `difference()` the new feeder and the original
     both ways. The only pieces left should be at the towers, the window
     and rail block, and the ridges.
   - **Box holder pads, poses that must be clear:** each pad seated in its
     groove; each pad sliding out upward; objects against the pads.
     Offset the pads 0.01 mm off the faces and inset the objects 0.05 mm,
     so faces that only touch don't count.
   - **Box holder, poses that must overlap:** the jaw lifting at its
     working positions; an object pushed outward 0.6 mm and 1.5 mm against
     the lips; pads pulled 0.5 mm off the jaw face (the dovetail holds
     them); pads pushed 0.5 mm down (the ledge stops them).
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
for p in mounted all bottom top slide; do
  r pocket-utility-knife pocket_utility_knife pocket_utility_knife_$p $p
done
r pocket-utility-knife pocket_utility_knife pocket_utility_knife_mounted_retracted mounted 'view_stop="retracted"'
r pocket-utility-knife pocket_utility_knife pocket_utility_knife_mounted_extended mounted 'view_stop="extended"'
```

## Tuning notes for the user

- **Antenna lock bar:** `lock_clearance` sets how freely it slides.
  `snap_barb` sets how firmly the snap holds; use 0.4–0.5 for PLA.
- **Antenna clamp cup count:** `cups` (1 or 2). For a thinner antenna
  with either version, set `rod_d`.
- **Cups:** if they're hard to slide in, increase `slot_clearance` in
  `library/suction_cup.scad`.
- **Box holder nut:** if it binds on the screw, raise `thread_slop`.
- **Grip pads:** if they're too loose or too tight in the groove, adjust
  `pad_clearance`. `pad_t` sets how soft the grip is; the jaws re-space
  automatically.
- **Feeder panel:** if it's too loose or too tight in its rails, adjust
  `panel_clearance`. The window size is set by `win_w`, `win_bottom` and
  `win_top`.
- **Modular feeder:** if the tray knobs are loose or tight in the mount,
  adjust `slot_clearance` in `library/suction_cup.scad`, which also changes the cup
  slots. Use `drain_d` for the hole size, `front_h` for how low the front
  is, and `perch_drop` and `perch_reach` for where the perch sits.
  `lock_barb` sets how firmly the panel lock keys snap in, and
  `lock_clearance` how freely they slide.
- **Roof:**
  - **Size and shape:** `roof_headroom` (150 mm above the perch, which
    gives about 160 mm over the perch rail) sets the roof's height, `roof_pitch` its slope, and `roof_overhang` and
    `roof_side_overhang` its size.
  - **Fit:** `roof_barb` sets how firmly it latches, and `roof_clearance`
    how freely the brackets and rails slide.
- **Bird Buddy feeder:**
  - **Camera side:** `buddy_side`. For the -X side, re-export the camera
    mount with `-D buddy_side=-1`.
  - **Camera mount:** `cm_cup_top` and `cm_cup_bot` place its cups.
    `joint_clearance` sets the fit of the collar's tab in the fork.
    `cbar_clearance` sets how freely the lock bar slides, and `cbar_barb`
    how firmly it snaps in.
  - **Camera:** `cam_h`, `cam_w`, `cam_d`, `cam_bump` and the lens and
    button positions. `cam_clearance` sets how loose it sits in the
    cradle.
  - **Magnet:** if the camera doesn't wake in the cradle, move
    `cam_magnet_from_top` to where its bump is, or stack more with
    `cam_magnets`. `cam_magnet_d` and `cam_magnet_t` set the magnet's
    size.
  - **Cap:** set `usb_space` to suit the plug (a right-angle plug needs
    less), and `cap_eave` for how far the roof overhangs. `cable_d` sets the cable slot, and
    `cap_detent` how firmly the cap stays on.
  - **Camera position:** `cam_lens_y` sets its height, and `cam_x` and
    `cam_z` where it pivots.
  - **Turning:** `cam_yaw_step` sets the steps, `spline_clearance` the fit
    of the teeth, and `cam_yaw` the angle shown in the mounted view.
  - **Collar:** `collar_h` sets where the camera is held. Lower it only
    as far as the assert allows (`cam_view_half`). `seat_w` sets the
    seat's width.
  - **Lens:** if the camera binds sliding in, raise `cam_lens_proud`.
  - **Pin:** `lock_pin_clearance` sets how snug the pin is in its posts.
  - **Panel:** `sp_*`, `jbox_*` and `socket_from_edge`. `sp_clearance`
    sets the fit in the frame.
  - **Bolt:** a different bolt length changes `panel_bolt_len`, which
    re-sizes the upper mount. Check the socket is at least
    `socket_engage` deep.
  - **Roof:** `roof_pitch` and `roof_headroom`.
- **Bird Buddy on a post:**
  - **Reach:** `cam_z`. Below 130 it limits which ways the panel can face.
  - **Wood screws:** `wp_screw_d` sets the hole and `wp_screw_x` their
    spacing.
  - **Cap screws:** `wp_cap_screw_d`, `wp_cap_screw_len` and
    `wp_cap_screw_down`. The asserts keep them in the solid part of the
    spine.
  - **Ball joint:**
    - **Grip:** if the ring won't clamp the ball, lower
      `wp_ring_clearance`. If it binds on the boss, raise
      `wp_thread_slop`.
    - **Range:** `wp_ring_lat` trades grip for tilt range
      (`wp_max_tilt`, `wp_max_tilt_round`). A smaller `wp_keel` gives
      more tilt toward the keel but a narrower flat on the bed.
    - **Bolt:** a different bolt changes `wp_bolt_len`, which moves the
      stem's plate.
  - **Mounted view:** `wp_panel_tilt` and `wp_panel_heading` pose the
    panel, and `cam_yaw` the camera.
- **Phone holder:**
  - **Different phone or case:** set `phone_w`, `phone_h`, `phone_t` and
    `phone_corner_r`.
  - **Grip:** `fin_preload` sets how firmly the phone is held. If it's
    loose or rattles, raise it. If it's hard
    to slide in, lower it.
  - **Camera bump:** if it touches the back, raise `camera_clearance`.
  - **Buttons:** move the windows with `window_y0` and `window_y1`, and
    the crossbars with `left_bars` and `right_bars`.
  - **Fit:** if the case still drags on the walls, raise `side_clearance`
    or `depth_clearance`.
  - **Height:** `top_open` sets how much of the phone sticks out above the
    holder.
  - **Angle adapter:** `adapter_angle` sets the turn. If the holder's
    corner touches the glass or a cup, raise `adapter_z`. If the holder
    is loose or tight between the rails, adjust `rail_clearance`.
- **Tracker holder:**
  - **Fit:** if the case is tight or rattles in the channel, adjust
    `clearance`.
  - **Different enclosure:** set `case_w`, `case_h`, `case_t`,
    `case_edge_r` and `case_corner_r`. Keep `lip` past the rounded
    edge (an assert checks it).
  - **USB plug:** if a bulky plug doesn't fit, widen `usb_gap`.
  - **Lock bar:** `lock_clearance` sets how freely it slides, and
    `snap_barb` how firmly it snaps in.
  - **Feet:** `foot_gap` sets how close they come to the glass. If they
    touch the cup's rim or tab, raise `foot_clearance`.
  - **Thickness:** `wall_lines` (4) sets the back, walls and lips.
  - **Shim grip:** if the case is hard to slide in, lower
    `shim_preload`; if it still rattles, raise it. `fin_t` also changes
    the stiffness, steeply. Only the shim needs reprinting for either.
  - **Shim on its studs:** if it's hard to get onto the studs, lower
    `stud_h`; if it's loose on them, lower `stud_clearance`.
  - **Height:** `top_open` sets how much of the case sticks out above
    the holder.
- **Tracker case:**
  - **Check first:** measure the PCB's thickness (`pcb_t`), how tall the
    buttons stand (`button_h`) and the parts under the board
    (`under_space`). Hold the lid over the board to check the window and
    plungers line up (`screen_*`, `button_x`, `button_y`).
  - **Buttons:** if a button is pressed all the time, raise
    `button_gap`; if a press doesn't reach it, lower it. `key_layers`
    sets how stiff they are.
  - **Board fit:** if it rattles, raise `pcb_preload`; if the lid won't
    snap on, lower it. `clearance` sets the room round the board.
  - **Snaps:** `detent` sets how firmly the lid holds, `lid_clearance`
    its fit between the walls.
  - **Antenna:** measure the pigtail: `sma_inside` is how far its inner
    nut, body and crimp reach inside the end wall. `sma_nut_af` and
    `sma_nut_t` are the nut's size, and `sma_x` its position.
  - **USB plug:** if a bulky plug doesn't fit, raise `usb_plug_w` and
    `usb_plug_h`.
  - **Lock bar and feet:** as on the tracker holder.
- **Hat stretcher:**
  - **Size:** `closed_circ` must be a little under the hat's size;
    `stretch` sets how far it opens (circumference grows by twice it).
  - **Threads:** if the nuts bind, raise `thread_slop`.
  - **Height:** with `form_h`, keep `wheel_d` under it and `nut_af` small
    enough for the nut slot; the asserts say which is too big.
  - **Fins:** if they're tight or loose in their slots, adjust
    `guide_clearance`.
  - **Brace:** if it's hard to push onto the nut block, or falls out, adjust
    `brace_side_clearance`. If it won't drop in past the oval wall, raise
    `brace_clearance`. Move the feet with `brace_feet` if the vents change.
- **Pocket utility knife:**
  - **Third stop:** set `mid_stop` (mm), measured as `mid_stop_measure`
    says: `square` (tip past the nose, square to its face), `edge` (along
    the cutting edge) or `travel` (the slide's travel). The echo shows
    all three. The blade measures assume a standard 61 mm blade
    (`blade_*`, `nose_*`); `travel` doesn't depend on them.
  - **Mounted view:** `view_stop` picks the stop it shows.
  - **Detent:** if it's too stiff or too weak, change `bump_depth` (0.8,
    as on the original bumps) or `finger_len` (longer is softer). `bump_clearance` sets the play at the stop.
- **Card scanner:**
  - **Phone:** set `phone_l`, `phone_w`, `lens_from_top` and
    `lens_from_side`. `shelf_pos` picks the shelf position for the
    lenses' side; the shelf STL has all three grooves.
  - **Shelf:** `shelf_len` sets how much of the phone it carries. If the
    camera bump stands proud of the case, set `bump_proud` and shorten
    `shelf_len` so the bump hangs past the front edge.
  - **Height:** loosen the knob, slide the mast and read the scale at
    the sleeve's top: it gives the lens-to-card distance with the box
    full. `cam_lo` and `cam_hi` set the range (the sleeve and mast are
    sized from them), and `cam_h` only poses the mounted view.
    `box_depth` sets the box's capacity.
  - **Clamp:** if the mast is stiff or loose in the sleeve, adjust
    `sleeve_clearance`. If the knob slips on the bolt head, lower
    `head_press` or add a drop of glue. A longer bolt only moves the
    knob out; `bolt_len` poses it.
  - **Cards:** `card_w`, `card_l` and `card_clearance` size the box.
  - **Vents:** `vent_h`, `vent_w` and `vent_gap`.
  - **Fit:** `box_clearance` (box in frame). The press fits are
    `socket_clearance` (sleeve in socket) and `pocket_clearance` (shelf on
    the tower): raise them if too tight, lower them (negative) if loose.
- **Succulent liner:**
  - **Fit:** if the collar is tight or loose on the cup, adjust
    `skirt_clearance`. If the liner rubs the cup, raise `clearance`.
    `bore_clearance` sets how much it moves in the collar.
  - **Height:** `liner_h` sets the liner's height. A shorter liner leaves
    more water room and less soil; the assert stops it coming closer
    than `spacer` to the cup's floor. If soil washes through, lower `drain_d`
    or lay a scrap of mesh on the floor.
  - **Vine:** `vine_waves`, `vine_amp`, `leaf_len`, `leaf_w`,
    `leaf_angle` and `vine_depth`. The asserts say if a leaf runs off
    the band.
- **Scanner V2.3:**
  - **Slide:** `slide_wall_h` sets the walls' height above the ramp.
- **Box holder object:** if your object is a fixed size, set `obj_t_max` to
  its thickness so the lips sit right at its front face.
