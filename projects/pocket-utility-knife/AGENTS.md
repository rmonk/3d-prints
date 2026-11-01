# Pocket utility knife

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `{Bottom,Top,Slide} - 0.4 PETG or PC.stl`: the original parts. Don't
  change them.
- `pocket_utility_knife.scad`: imports them and edits the Bottom.
- `pocket_utility_knife_{bottom,top,slide}.stl`: exported parts, in the
  originals' frame (not on the bed: the Bottom prints on its z = 2
  face, the Top and Slide on their lowest faces; `part="all"` shows
  them so). The top and slide are the originals unchanged.
- **Not committed:** the project's `.gitignore` keeps every `.stl` and
  `.3mf` out of git, because the design's licence hasn't been checked.

## Pocket utility knife: design and why

1. **Someone else's design, edited by import.** The three STLs share one
   frame: x along the knife (nose at -X, ring at +X), the Bottom's plate at
   z 0–2 with the blade cavity under it. The slide extends the blade
   toward -X.
   - **Licence:** the Printables page couldn't be read, so its meshes stay
     out of git, like the MTG card scanner's
     (`../mtg-card-scanner/`).
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

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Pocket utility knife Bottom (z = 2 face on the bed):** only the
  new slit's 1.25 mm bridged top over the wall, at 0.01 mm into it
  (7.5 mm²). Laid on its z = -4 face instead, the original has about
  1,970 mm² of overhang, which is how its print orientation was found.

### Fit checks

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

## Tuning notes for the user

- **Pocket utility knife:**
  - **Third stop:** set `mid_stop` (mm), measured as `mid_stop_measure`
    says: `square` (tip past the nose, square to its face), `edge` (along
    the cutting edge) or `travel` (the slide's travel). The echo shows
    all three. The blade measures assume a standard 61 mm blade
    (`blade_*`, `nose_*`); `travel` doesn't depend on them.
  - **Mounted view:** `view_stop` picks the stop it shows.
  - **Detent:** if it's too stiff or too weak, change `bump_depth` (0.8,
    as on the original bumps) or `finger_len` (longer is softer). `bump_clearance` sets the play at the stop.
