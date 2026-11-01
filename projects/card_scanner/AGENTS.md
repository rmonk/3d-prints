# Card scanner

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `card_scanner.scad`: the card scanner. Uses `library/shapes.scad`.
- `card_scanner_{mast,sleeve,knob,shelf,base,box}.stl`: exported parts,
  in print orientation. The shelf STL serves all three positions and
  every height.

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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Card scanner:** none on the sleeve, knob, base or box. On the mast,
  only the 0.5 mm-deep ceilings in the engraved scale. On the shelf,
  only the three pocket ceilings, 16 × 30 mm bridges.

### Fit checks

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

## Tuning notes for the user

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
