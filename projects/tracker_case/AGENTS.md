# Tracker case

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `suction_cup_tracker_case.scad`: the tracker case. Uses
  `library/BOSL2`.
- `suction_cup_tracker_case_{base,lid,lock}.stl`: exported parts, in
  print orientation. The lock bar is the tracker holder's
  (`../tracker_holder/`), triangle for triangle.

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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Tracker case:** on the base, the 3.8 mm lock bar channel
  ceiling (11.5 mm each side of the slot) and the 1.8 mm and 4.2 mm
  cup slot flats. On the lid, a 1.8 × 2 mm flat at the SMA hole's
  point. Both have some zero-area slivers. The lock bar has none.

### Fit checks

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

## Tuning notes for the user

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
