# Hat stretcher

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `hat_stretcher.scad`: the hat stretcher. Uses `library/BOSL2` and
  `library/shapes.scad`.
- `hat_stretcher_{half,rod,nuts,brace}.stl`: exported parts, in print
  orientation. Print the half and the brace twice.

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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Hat stretcher:** none (one degenerate sliver in the chamfer). The
  brace has none.

### Fit checks

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

## Tuning notes for the user

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
