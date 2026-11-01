# Tracker holder

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `suction_cup_tracker_holder.scad`: the tracker holder. Uses
  `library/BOSL2`.
- `suction_cup_tracker_holder.stl`: the holder, in print orientation.
- `suction_cup_tracker_holder_lock.stl`: the lock bar, flat.
- `suction_cup_tracker_holder_shim.stl`: the TPU anti-rattle shim, flat.
- The enclosure itself isn't in the repo. It's "Heltec Tracker LoRa
  Meshtastic Enclosure V3" on Printables (model 1204874), licensed CC
  BY-NC, which doesn't fit this repo's CC BY-SA. Download its STLs to
  run the fit checks against the real case.

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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Tracker holder:** the 3.8 mm ceiling of the lock bar channel
  (11.5 mm long each side of the slot), the 1.8 mm and 4.2 mm flats
  at the cup slot's pointed end, and some zero-area slivers (also
  where the cup block's band starts to widen). The feet and the shim
  studs have none (the studs' sides are at 45°), and neither does the
  lock bar. The shim has none: its fins' undersides are at 45°.

### Fit checks

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

## Tuning notes for the user

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
