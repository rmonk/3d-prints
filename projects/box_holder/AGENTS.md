# Box holder

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `suction_cup_box_holder.scad`: the box holder. Its threads use
  `library/BOSL2`.
- `suction_cup_box_holder.stl`: a combined export.

## Hardware and measured dimensions

These came from measuring the user's real parts. Don't change the
defaults without asking.

| Item | Value |
|---|---|
| Box holder object | 60–65 mm wide and 20–25 mm thick. It's a light rectangular prism, used indoors. |

## Box holder: design and why

1. **One suction cup.** Its slot opens through the bottom edge (-Y), so the
   holder hangs on the knob and gravity keeps it seated.
   - **Twisting:** with only one cup, the holder can turn around the knob.
     The object is centred over the cup so its weight doesn't twist it.
2. **The object rests on a base plate between two jaws,** with a ledge
   along the bottom edge carrying its weight.
   - **Fixed jaw:** has a 45° lip that wraps over the object's front edge.
   - **Sliding jaw:** has the same lip, and its dovetail foot runs in a
     track in the plate. A notch at the bottom lets it ride over the ledge.
   - **Fitting the sliding jaw:** it drops in through an opening at the
     inner end of the track, then slides outward.
3. **A printed thumbscrew in a printed nut pushes the sliding jaw closed.**
   This answers the user's question about whether a printed screw would
   work: it does for light indoor loads.
   - **Threads:** BOSL2 `trapezoidal_threaded_rod` and
     `trapezoidal_threaded_nut`, 10 mm × 2.5 mm pitch, with
     `thread_angle = 90`. That gives 45° flanks that print without support,
     where the ISO 60° form wouldn't.
   - **Print orientation:** both threads print with the axis vertical.
   - **Nut:** its bottom outer chamfer is turned off (`bevel1 = false`)
     because it overhangs on the bed. It sits captive in a slot in the end
     block that opens upward.
4. **Optional TPU grip pads (`pads = true`).** One pad covers each jaw
   face. A 45° dovetail rib on the back slides down into a groove in the
   jaw, and the pad stands on the ledge.
   - **Spacing:** every position is derived from `obj_x0`, the object's
     side, and `pad_eff`. The fixed jaw, the sliding jaw's travel, the end
     block and the screw length all move out by the pad thickness.
   - **Lips:** they reach `lip + pad_eff` from the jaw face. Their 45°
     underside starts `pad_eff` lower (`lip_wall_z`), so it crosses the pad
     face just above the thickest object.
   - **Pad top:** it follows the lip underside, 0.3 mm below it.
   - **Past bug:** before this fix, objects could move 2 mm outward before
     reaching the lips. The `obj_lip_small` fit test catches it.
   - **Without pads:** `pads = false` reproduces the padless geometry
     exactly.
5. **Print orientation:**
   - **Base:** prints on its bottom edge (-Y, where the cup slot opens),
     like the antenna clamp body. The plate, fixed jaw, lip and end block
     then lie in each layer, so clamping force runs along the layers.
     - **Why:** printed flat, the fixed jaw and end block were attached to
       the plate by a layer boundary. Clamping pushed them along it,
       shearing between layers and pulling them apart. The user caught
       this.
     - **Features changed for this orientation:**
       - The jaw track is a pure 45° dovetail, with no straight-sided
         slit, which would print as an unsupported ledge.
       - The drop-in opening has a 45° peaked top.
       - The nut slot opens through the top edge (+Y).
       - The screw hole's teardrop points +Y.
       - The plate is rounded only on its glass-side edges, in the XZ
         profile.
   - **Sliding jaw:** prints on its outer face, so its layers run up the
     jaw.
   - **Pads:** print two, grip face down and rib up.
   - **Screw:** prints standing on its head.
   - **Nut:** prints flat.

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Box holder base (printed on its edge):** the 1.8 mm and 4.2 mm flats
  at the pointed end of the cup slot.
- **Screw, nut and jaw:** none.

### Fit checks

- **Box holder, poses that must be clear:** the jaw at both ends of its
  travel; the jaw lifting out at the drop-in opening; objects of 60, 62.5
  and 65 mm width by 20 and 25 mm thickness, inset 0.01 mm so faces that
  only touch don't count; the screw against the base; the nut in its
  slot, unrotated so its flats face ±Z.
- **Box holder pads, poses that must be clear:** each pad seated in its
  groove; each pad sliding out upward; objects against the pads.
  Offset the pads 0.01 mm off the faces and inset the objects 0.05 mm,
  so faces that only touch don't count.
- **Box holder, poses that must overlap:** the jaw lifting at its
  working positions; an object pushed outward 0.6 mm and 1.5 mm against
  the lips; pads pulled 0.5 mm off the jaw face (the dovetail holds
  them); pads pushed 0.5 mm down (the ledge stops them).

## Tuning notes for the user

- **Box holder nut:** if it binds on the screw, raise `thread_slop`.
- **Grip pads:** if they're too loose or too tight in the groove, adjust
  `pad_clearance`. `pad_t` sets how soft the grip is; the jaws re-space
  automatically.
- **Box holder object:** if your object is a fixed size, set `obj_t_max` to
  its thickness so the lips sit right at its front face.
