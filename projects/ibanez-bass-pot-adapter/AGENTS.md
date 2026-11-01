# Ibanez bass pot adapter

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `Ibanez short pot adapter.stl`: the user's original. Don't change it.
- `a250k_pot_adapter.scad`: the A250K adapter. Plain OpenSCAD, no
  libraries.
- `a250k_pot_adapter.stl`: the A250K adapter, in print orientation.

## A250K pot adapter: design and why

1. **Copied from the user's Ibanez adapter:** its STL is a 15 mm square
   flange 2 mm thick, corners rounded to 17 mm across, and a 9 mm boss
   5 mm long, with an M8 × 0.75 right-hand thread through it (found by
   fitting its vertices). This one keeps the flange and boss length.
   - **Boss:** 9.5 mm (`hole_d` 9.7 less `hole_clearance` 0.1 a side),
     for the user's 9.7 mm hole.
   - **Pot:** an A250K whose bushing thread measures 7.77 mm, so
     M8 × 0.75, the same as the original's.
2. **No printed thread (the user's call):** the bore is plain,
   `bore_d` (7.4 mm), and the pot's metal thread forms its own in the
   PETG as it's screwed in.
   - **Why:** a 0.75 mm pitch is under three layers at 0.28 mm, so it
     wouldn't print cleanly. An ISO 60° internal thread printed upright
     also has 30° flanks, 95 mm² of overhang; the original's are about
     40°.
   - **Wall:** 1.05 mm at the bore and 0.87 mm outside the cut thread,
     against 0.5 mm on the original.
   - **Lead-in:** a 45° chamfer, `lead_in` (0.6 mm), at the boss's end
     starts the bushing straight. A 0.3 mm chamfer at the flange end
     stops elephant's foot closing the bore.
   - **Sizing:** M8 × 0.75's tap drill is 7.25 mm. Holes print a little
     small, so 7.4 is drawn. An assert keeps it at least 0.2 mm under
     the bushing.
3. **Print orientation:** flat, flange on the bed, boss up, like the
   original. No overhangs. About 0.5 cm³.

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **A250K pot adapter:** none.

### Fit checks

- **A250K pot adapter:** the boss in the 9.7 mm hole of a body under
  the flange (0.01 mm down) must be clear. Moved 0.2 mm sideways it
  must overlap (the hole), and lowered 0.3 mm it must overlap (the
  flange).

## Tuning notes for the user

- **A250K pot adapter:**
  - **Pot fit:** if the pot is too hard to screw in, raise `bore_d`. If
    it's loose or strips, lower it.
  - **Body hole:** `hole_d` and `hole_clearance`. The boss's length is
    `boss_l`.
