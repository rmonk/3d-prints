# Phone holder

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `suction_cup_phone_holder.scad`: the phone holder. Uses `library/BOSL2`.
- `suction_cup_phone_holder.stl`: the holder, in print orientation.
- `suction_cup_phone_holder_adapter.stl`: the angle adapter's two
  blocks, in print orientation.

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

10. **Walls and lips can't go below 4 lines.** `body2d()` is wrapped in
    `round2d(or = 0.8)`. That opening erases anything under 1.6 mm, so
    with 3-line walls or lips (1.23 mm) they vanish without a warning:
    the STL lost its lips and 28% of its volume. 4 lines (1.62 mm) is
    just above the limit.

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Phone holder angle adapter:** the 1.8 mm and 4.2 mm cup slot flats in
  each block, and a 0.02 mm² point at each knob tip.
- **Phone holder:** the 1.8 mm and 4.2 mm flats at the bottom cup
  slot's pointed end, plus a sliver of facets at about 48° where the
  neck slot's circle meets its 45° point (a `$fn` artifact).

### Fit checks

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

## Tuning notes for the user

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
