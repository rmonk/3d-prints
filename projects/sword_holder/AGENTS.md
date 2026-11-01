# Sword strap holder

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `sword_strap_holder.scad`: the sword strap holder. Plain OpenSCAD,
  no libraries.
- `sword_strap_holder.stl`: the holder, in print orientation.
- `sword_strap_holder_lock.stl`: the lock bar, flat.
- `sword_strap_holder_test.stl`: a 10 mm fit test of the holder
  (`part="test"`, length `test_len`). Use it to check the blade and
  the strap's folded end before printing the full holder.

## Sword strap holder: design and why

1. **A holder, not a sheath (the user's call):** the sword is Nerf foam,
   not sharp, so the holder only has to keep it on the back strap.
   - **Blade:** 55 × 20 mm at most. Its faces slope gently from the
     centre ridge, then bevel steeply to the edges, so near the edges
     it's thicker than a diamond would be. A section 72 mm wide
     (`wide_w`), 64 mm below the hilt, rests on the holder.
   - **Strap:** 44.5 × 2.2 mm, with a folded end about 5 mm thick
     (`strap_fold_t`). It runs along the blade (the user's choice),
     threaded through the holder, so the strap has to be unbuckled to
     fit it.
2. **A sleeve, `sleeve_len` (80 mm) long:** it sits on the blade below
   the wide section. The sword drops through it tip first, and the wide
   section rests on a flange round its top, `flange` (4 mm) wide. The
   sword draws straight up over the shoulder.
   - **Bore:** the blade's section, `clearance` (1.5) a side, so
     58 × 23 mm.
     - **Shape:** a hexagon. The ridge is `blade_t` thick, and the bevels
       start `bevel_w` (8) from each edge, where the blade is `bevel_t`
       (12) thick. Both bevel values are generous estimates.
     - **Corners:** rounded `blade_edge_r` (2).
     - **Lead-in:** 1 mm at 45° round the top, to guide the tip.
   - **History:**
     - **First print:** a diamond of 51 × 19 mm with 0.4 mm clearance.
       It was too tight.
     - **Second print:** a diamond of 55 × 20 mm with 1.5 mm. The blade
       jammed, because its bevelled edges stand about 2 mm proud of a
       diamond's faces. The user's photo showed it.
   - **Shell:** `wall_lines` (4).
3. **Strap channel and lock bar (the user's choice):** on the first
   print, a 2.8 mm channel with pinch ridges made the folded end hard to
   thread. The user asked for something that goes on easily, then
   tightens.
   - **Channel:** a closed slot down the back plate, the full length.
     It's `strap_clearance` (0.75) wider a side than the strap and
     `strap_fold_t` + `fold_clearance` (5.8 mm) deep, so the folded end
     passes freely. The wall against the back is `back_lines` (4), and
     flat.
   - **Web:** it joins the diamond's back point to the plate.
   - **Lock bar (`part="lock"`):** once the strap is through, a flat bar
     pushes down the channel from the top, between the strap and the
     sleeve. It's `strap_squeeze` (0.4) thicker than the space the strap
     leaves, so it presses the strap against the back wall along its
     whole length.
     - **Lead-in:** a ramp on the tip's strap face starts it.
     - **Head:** it stops on the sleeve's top.
     - **Prongs:** two at the bottom, each freed by a slit
       `snap_len` (16) long. Their `snap_barb` (1 mm) barbs snap past
       the square bottom of the channel's sides, about 1% strain.
     - **Removing it:** squeeze the prongs together and pull the bar
       out by its head.
     - **Size:** about 87 × 50 × 4 mm, 15.6 cm³.
4. **One cross-section extruded along the blade,** so every wall is
   vertical in print.
5. **Print orientation:**
   - **Holder:** upside down, flange on the bed. Only the chamfers
     slope. The sword's weight runs across the layers, which is
     acceptable for a foam sword. About 69 × 38 mm on the bed, 80 mm
     tall, 32.6 cm³.
   - **Lock bar:** flat, its strap face up, so its prongs flex along
     the layers and the ramp is on top.

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Sword strap holder:** none on the holder or the lock bar.

### Fit checks

- **Sword strap holder, poses that must be clear:**
  - The ghost blade (`blade()`) seated 0.01 mm up, and lifted 20 and
    60 mm.
  - The strap (`strap()`) 0.01 mm off the back wall, and a strap of
    `strap_fold_t` thickness passing through.
  - The lock bar 0.01 mm off the channel's sleeve side, against the
    holder and the blade. Against the strap with
    `strap_squeeze = -0.05`. Sliding in from 10, 40 and 70 mm with
    `snap_barb = -0.05`.
- **Sword strap holder, poses that must overlap:**
  - The blade moved 1.6 mm sideways, toward the back or away from it
    (the bore), or 0.5 mm down (the wide section on the flange).
  - The lock bar against the strap at the default squeeze.
  - The lock bar moved 0.5 mm down (the head), 0.5 mm up (the barbs),
    or 0.5 mm sideways.

## Tuning notes for the user

- **Sword strap holder:**
  - **Blade fit:** if the blade is loose or tight in the sleeve, adjust
    `clearance`. Measure the bevels: `bevel_w` is how far from each edge
    the face turns steep, and `bevel_t` the blade's thickness there.
    `blade_edge_r` is the corners' rounding.
  - **Strap:** if the folded end is still hard to thread, raise
    `strap_fold_t` or `fold_clearance`. `strap_clearance` sets the side
    gaps.
  - **Lock bar:** if the holder slides on the strap, raise
    `strap_squeeze`. If the bar is too hard to push in, lower it. Only
    the bar needs reprinting for either. `snap_barb` sets how firmly it
    snaps, `lock_clearance` its side play.
  - **Length:** `sleeve_len`. The bar follows it.
  - **Test piece:** `part="test"` is the holder cut to `test_len`
    (10 mm), with the flange, for checking the blade and the folded
    strap end. There's no test bar (the user's call), and the lock bar
    can't be used with it.
