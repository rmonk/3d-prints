# Succulent liner

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `succulent_liner.scad`: the succulent liner. Plain OpenSCAD, no
  libraries.
- `succulent_liner_{liner,collar}.stl`: exported parts, in print
  orientation.

## Hardware and measured dimensions

These came from measuring the user's real parts. Don't change the
defaults without asking.

| Item | Value |
|---|---|
| La Fermière terracotta pot | 56 mm inside, 68 mm outside at the rim, 69 mm deep inside (first measured as 44). Straight walls that curve inward over the bottom couple of mm. |

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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Succulent liner:** none on either part.

### Fit checks

- **Succulent liner, poses that must be clear** (the cup is `cup()`):
  the collar on the cup (0.01 mm up); the liner in the collar
  (0.01 mm up), against the cup and the collar; the liner lowered in
  from 10 and 30 mm; the liner moved 0.9 mm sideways, against the cup.
- **Succulent liner, poses that must overlap:** the collar moved
  0.5 mm down (it rests on the rim) or 1 mm sideways (the skirt);
  the liner moved 0.5 mm down (it hangs on the flare).

## Tuning notes for the user

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
