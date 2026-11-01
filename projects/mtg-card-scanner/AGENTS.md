# MTG card scanners

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `scry_scanner_magnets.scad`: the ScryScanner's magnet pockets and
  lightened body, edited from imported meshes.
- `scry_3mf.py`: extracts the ScryScanner 3MF's meshes and writes edited
  ones back.
- `scanner_v2_extension.scad`: the Scanner V2.3 slide with taller walls.
- `scanner_v2_3mf.py`: extracts the Scanner V2.3 3MF's meshes.
- **Not committed:** the 3MFs, the extracted `original/` and
  `original_v2/` meshes, and every exported STL (the project's
  `.gitignore`).

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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Scanner V2.3 slide:** only the original's +X
  rail inner face (1 × 70 mm at 63°, which the original has too) and
  zero-area slivers.

### Fit checks


## Tuning notes for the user

- **Scanner V2.3:**
  - **Slide:** `slide_wall_h` sets the walls' height above the ramp.
