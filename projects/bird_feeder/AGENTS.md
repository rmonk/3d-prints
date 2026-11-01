# Bird feeders

This project's notes. The rules shared by every project (layout,
conventions, how to verify, export and preview) are in the root
`AGENTS.md` (`../../AGENTS.md`).

## Files

- `suction_cup_bird_feeder_original.stl`: the user's feeder, designed in
  another CAD tool. `suction_cup_bird_feeder.scad` imports it, by a path
  relative to the .scad file, and edits it. Don't change this file.
- `suction_cup_bird_feeder.scad` and
  `suction_cup_bird_feeder_{feeder,panel}.stl`: the reworked feeder and
  its exported parts.
- `suction_cup_bird_feeder_modular.scad` and
  `suction_cup_bird_feeder_modular_{mount,tray,panel,lock,perch,roof,roof_bracket}.stl`:
  the modular feeder and its exported parts.
- `suction_cup_bird_feeder_buddy.scad` and
  `suction_cup_bird_feeder_buddy_{camera_mount,cam_lock_bar,camera_collar,collar_pin,camera_cradle,camera_cap,cam_pin,upper_mount,solar_frame}.stl`:
  the Bird Buddy variant and its new parts (for `buddy_side = 1`). It
  `include`s the modular file and reuses its mount, tray, panel, keys
  and perch unchanged.
  - **`modular_output`:** the modular file renders its parts only when
    this is true. The variant sets it to false after the include.
  - **`buddy_output`:** the same for the variant. The post version sets
    it to false.
  - **Names:** the variant must not reuse a variable or module name from
    the modular file or the library. The intended overrides are
    `part`, `modular_output`, `roof_pitch`, `roof_headroom` and
    `roof_back_gap`.
    - **Why:** OpenSCAD silently uses the last value everywhere, so a
      clash changes the reused parts. A `post_d` for the lock pin's
      posts once changed the tray's corner posts.
    - **Check:** the reused parts' triangle sets must match the modular
      file's own renders.
- `suction_cup_bird_feeder_buddy_complete.scad`: a generated
  single-file copy of the variant with the suction cup library and
  the modular file inlined (about 66 kB), so it can be opened or
  exported anywhere. Don't edit it. Regenerate it after any change to
  the variant or what it includes (see **Exporting** in the root `AGENTS.md`).
- `bird_buddy_post.scad` and
  `bird_buddy_post_{post_mount,post_cap,ball,stem,ball_ring}.stl`: the
  Bird Buddy camera on a wooden post. It `include`s the variant, and
  BOSL2 for the ball joint's thread. It reuses the variant's collar,
  collar pin, cradle and lock pin; print those from the variant's STLs.
  - **Names:** new names start `wp_`. The intended overrides are `part`,
    `buddy_output`, `cam_yaw`, `cam_z`, `cap_down`, `cap_wall_lines` and
    `cap_eave`.
  - **Reused parts:** rendered from this file they don't match the
    variant's STLs. `cam_z` moves the collar, and BOSL2's `cylinder`
    facets a few of the cradle's circles differently. So the file
    doesn't offer them as parts, and the fit checks also run against the
    variant's STLs.
- `Suction Cup Bird Feeder Mk2.stl`: an incomplete export of the feeder
  (only one keyhole plate). Not used.

## Bird feeder: design and why

1. **Edits an imported STL rather than remodelling.** This keeps the user's
   own design (drain hole pattern, the 45° fin along the inside top of the
   back wall) exactly as drawn. Everything outside the edited regions must
   stay identical to the original.
   - **Flush faces:** the STL stores float32 values, and its bottom face is
     at 4.3e-15, not 0. New faces that must be flush with the original use
     the exact values (`stl_x1`, `stl_bed`). Elsewhere new solids overlap
     the original by 0.5–1 mm instead of meeting it face to face.
   - **No 2D polygons on the bed:** OpenSCAD rounds 2D coordinates slightly,
     so a `linear_extrude` standing on the bed ends up about 1e-5 mm off
     it. The spacer ridges are built from 3D primitives for this reason.
2. **Cup slots:** both towers are rebuilt with the library `cup_slot`,
   opening through the bottom like the box holder. The hollow behind the
   slot stays open at the top and bottom, as in the original. The cup
   centre (`cup_z = 38.5`) is 1.8 mm lower than the old keyhole top, so the
   pointed slot end fits under the tower top.
3. **Window and panel:** a window in the back wall, with a clear panel
   that slides down into rails on the outside of the wall (the glass side).
   - **Not on the inside:** the fin along the inside top of the wall
     blocks a panel from going in from above.
   - **Window shape:** 45° top corners with a 10 mm bridge, because a flat
     60 mm top would be a long unsupported bridge. Its top stays below the
     fin (z 40.4 in the original).
   - **Holding the panel:** it stands on a 2 mm ledge. Lips on the rails
     and a strip along the bottom hold it against the seed.
4. **Spacer ridges:** the original single centre ridge, which rests on the
   glass, sat where the panel goes. It's replaced by two identical 45°
   ridges at `±spacer_x`.
5. **Print orientation:** the feeder prints upright, as the original does.
   The panel prints flat.
6. **Model coordinates:** the cup slots follow the shared convention: x
   along the feeder, y up, z away from the glass. z = 0 is the tower
   fronts; the real glass, where the ridges touch, is at `glass_z` (-7).

## Modular bird feeder: design and why

1. **The mount stays on the glass and the tray lifts off.** The mount bar
   holds both cups in library `cup_slot`s on its glass side. Two more
   T-slots on its front face open upward. Knobs on the tray's back corner
   posts drop into them.
   - **Removing the tray:** lift it about 22 mm and pull it away. The feet
     stay clear of the cups up to 27 mm of lift.
2. **Why knobs and slots:** the tray prints upright, so it can't have a
   French cleat. A cleat's hooking lip points down and starts in mid-air.
   A downward-facing bearing surface printed upright has to be a 45°
   pointed hole top or a 45° knob underside.
   - **Knob shape:** the head has a 45° point underneath. The neck runs
     straight down to a point at the same depth (`knob_apex`), so every
     layer joins the post. A plain mushroom knob would print its head's
     lowest layers as a floating island.
   - **Tray slots:** the knob outlines offset by `slot_clearance`, not
     `cup_slot`.
3. **Keeping seeds out of the gap:** the tray hangs 23 mm off the glass
   (`bar_t + cup_standoff`), which is more than a seed's length. Nothing in
   the gap has a flat top. The mount's top slopes 45° toward the tray, and
   the two feet that brace the tray bottom have peaked tops.
   - **Ruled out: sitting the feeder against the glass.** Seeds got stuck
     between the glass and the feeder. The user reported this.
4. **Seed level:** the tray's whole back wall is the clear panel. It
   slides into grooves in the corner posts and a channel in the floor,
   which has drain holes. The mount sits above the tray rim, so it doesn't
   hide the panel.
   - **Panel lock:** the user wanted a very solid lock, because the panel
     rarely comes out once fitted.
     - **Keys:** two keys slide in from the tray's outer sides, through
       slots in the corner posts, and through notches in the panel's edges
       near the top.
     - **Double shear:** each key spans the panel groove and is held in
       post material on both sides. Lifting the panel loads it in double
       shear.
     - **Clip:** a latch arm with a barb, freed by a slit, snaps into a
       pocket in the slot. The arm flexes sideways, along the layers. To
       release a key, press the arm end in at the tray's outer face.
     - **Print shape:** keys and slots have flat bottoms and 45° pointed
       tops. The left key is the mirror of the right, and `part="lock"`
       renders both.
     - **Room for the keys:** `panel_lip` (3) and `post_d` (12) were
       increased to fit them.
5. **Drainage:** a hexagonal grid of 3.5 mm vertical holes across the
   floor. That's about the size of the original's holes, and smaller than
   a sunflower seed is thick. The front wall is lower (35 mm) than the
   back (50 mm) for the birds.
6. **Perch:** a rail on two arms. Dovetail tongues on the arms slide down
   into sockets in bosses on the front wall.
7. **Optional roof:** the user chose to attach it to the mount and to keep
   the sockets on the mount always, so the roof can be added later without
   reprinting the mount.
   - **Where it sits:** the roof stays on the window while the tray lifts
     out beneath it. Its back edge, `roof_back_gap` from the glass, covers
     the gap behind the tray. It's a single slope, `roof_pitch` 15°,
     shedding rain off the front past the perch.
   - **Height:** `roof_headroom = 150` gives about 160 mm over the perch,
     enough for cardinals and grosbeaks, the main in-shell sunflower
     eaters. The first version (100 mm, about 107 mm over the perch) only
     suited sparrow-sized birds. `roof_overhang` went from 20 to 32 mm to
     offset the extra driving rain.
   - **Mount end blocks:** end blocks beyond the tray's width carry
     vertical half-dovetail sockets. The blocks are extruded from the same
     2D bottom edge as the bar, so they're flush on the bed.
   - **Brackets:** side plates with a half-dovetail tongue down their back
     edge and a half-dovetail rail along their top edge.
   - **Fitting the roof:** it slides up the slope onto the rails. Its rib
     channels are open at the back and closed at the front, so the closed
     front ends stop against the rails' front ends.
     - **Ruled out: channels closed at the back.** The solid rib behind
       the channel then has to pass over the rail.
   - **Latch:** a barb on a flexible arm near each bracket's back snaps up
     into a pocket in the channel ceiling. It only rides under the rib for
     the last ~15 mm.
   - **Order:** fit the panel lock keys before the brackets.
8. **Print orientation:**
   - **Mount:** on its bottom edge.
   - **Tray:** upright.
   - **Perch:** upright, as mounted. It's built with its bottom at y = 0
     (`perch_local`), so the 2D rail outline lands exactly on the bed.
   - **Panel:** flat.
   - **Lock keys:** on their flat bottoms. They're built with y = 0 at the
     bottom (`lock_key_local`), for the same 2D-rounding reason as the
     perch.
   - **Roof brackets:** flat, on their outer faces, so bending runs along
     the layers. The half-dovetails are flat on the bed side. The two
     brackets are laid out end to end, tongues 5 mm apart, so they fit a
     250 mm bed (235 × 158 mm).
   - **Roof:** upside down, its smooth top on the bed. It's about
     234 × 171 mm.
9. **Measured value:** `cup_standoff = 7` is the distance from the glass
   to the top of a cup. It comes from the original feeder's spacer ridge.

## Bird Buddy feeder: design and why

1. **A variant file, not a fork.** `suction_cup_bird_feeder_buddy.scad`
   includes the modular file and uses its mount, tray, panel, keys and
   perch unchanged, so a mount already printed is reused. The roof and
   roof brackets aren't used.
   - **Side:** `buddy_side` picks it (1 = +X, on the left seen from
     indoors). Only the camera mount's STL changes with it. The collar,
     cradle, upper mount and frame are symmetric about their own centres.
2. **Camera mount:** a window mount of its own, touching nothing on the
   feeder, so the tray still lifts off on its own.
   - **History:** it was first a side mount that hung in the feeder
     mount's roof bracket socket. The user asked for it to be separate,
     on two cups one above the other.
   - **Cups:** one at `cm_cup_top` (60) and one at `cm_cup_bot` (-40),
     both at the camera's x, either side of the arm.
     - **Spacing:** they're kept far enough from y = 0 to clear the
       feeder mount's nearest cup, which an assert checks.
     - **Slots:** both open sideways through the side away from the
       feeder (+X), and the slots' sides hold the knobs up and down.
       - **History:** they first opened in opposite directions; the user
         asked for them on one side with a lock bar, like the antenna clamp.
     - **Lock bar:** `cam_lock_bar` slides down a channel just past both
       heads, at head-pocket height, the full length of the plate.
       - **Stops:** its stop head rests on the top of the plate, and its
         snap prongs' barbs catch the bottom face.
       - **Width:** the channel and its outer wall set the mount's width,
         `cm_w`, about 32 mm.
       - **Removal:** squeeze the prongs to pull it out.
     - **Fitting:** slide both cups in from the open side, push the bar
       down until it snaps, then press both cups onto the glass.
   - **Profile:** it's one side profile, [z, y], extruded `cm_w` (about 32 mm)
     across.
     - **Plate:** on the glass, `cm_t` thick. A foot at each end, beyond
       the cups, reaches to `foot_gap` from the glass.
     - **Arm:** it runs out at the collar's height and ends in a fork.
     - **Gussets:** 45° gussets join the arm to the plate.
     - **Seeds:** the bottom foot's top slopes at 45°, so seeds don't rest
       on it.
   - **In-plane loads:** the cups, the arm and the camera all lie in one
     y–z plane, so the loads stay in the profile's plane.
3. **Collar and joint:** the collar is a separate part, because it has to
   print flat (axis vertical) for its teeth and seat.
   - **Tab:** it has a `tab_len` × `tab_t` tab that slides into the arm's
     fork.
   - **Pin:** `collar_pin` (5 mm) drops through the fork and tab, head on
     top.
   - **Load path:** the tab's top and bottom faces bear on the fork's
     prongs, so they carry the camera's moment. The pin only stops the
     tab sliding out.
4. **Camera:** a Bird Buddy 2 module, measured by the user.
   - **Size:** 122 × 51 × 37.5 mm, plus a 2 mm magnet bump on the back.
   - **Shape:** from the front it's a pill: the 51 mm width has full
     semicircular ends. Across its depth it's nearly rectangular, with
     edges rounded about 3 mm. This came from photos and from a
     community holder for the same module (Printables "Bird Buddy Bath",
     498120), whose pocket is 52 mm wide with round ends and about 31 mm
     deep.
   - **Magnet:** the module only switches on when it senses a magnet.
     Bird Buddy's own holder and community holders use an 18 × 2 mm disc
     magnet behind the top of the camera's back. The bump's size
     (`cam_bump_d`, 18) and position (`cam_magnet_from_top`, 25) are
     estimates, so check them against the camera.
     - **How many:** one magnet wasn't enough. The user had to break
       open the first print's slot to stack three before the camera
       reported it was ready for birds. `cam_magnets` (3) sets the
       stack, and the slot and spine grow with it.
   - **Front:** the lens (26 mm glass) is 97 mm down from the top. Its
     bezel is assumed to stand 1 mm proud (`cam_lens_proud`). A 10 mm
     button sticks out 13 mm, 25 mm down from the top.
   - **USB-C:** on top.
   - **Facing:** portrait, looking across the tray along the perch (-X
     for the +X side), with its lens at `cam_lens_y` (-22, 15 mm above
     the perch top). That's above the tray's side wall, so it sees in.
5. **Cradle:** a sleeve, open at the top.
   - **Height:** its walls run from a floor under the camera up to the
     top of the band.
   - **Shape:** it follows the pill outline, so its floor is a trough
     round under the camera's bottom end. In plan the pocket's corners
     and the walls' corners are both rounded like the camera's, so the
     walls are 4 lines thick all round.
     - **Past bug:** the first print's pocket had square corners inside
       rounded walls, leaving 0.07 mm at each corner. The slicer showed
       them as vertical slots, and the user spotted them.
   - **Front:** a window round the lens with a pointed top.
     - **Groove:** a groove up the front wall's inside lets the lens's
       proud bezel slide down as the camera goes in. A rib outside keeps
       the wall thickness over it. The rib is as wide as the window, so
       no sliver is left beside the window, and its underside is 45°.
     - **Button:** it never reaches the walls, which stop below it.
   - **Drainage:** drain holes go through the bottom of the trough.
   - **Spine:** a spine rises up the back to above the magnet. Behind
     the pocket it holds:
     - a channel for the camera's bump;
     - a 2-line skin;
     - the magnet slot, deep enough for `cam_magnets` stacked;
     - a 3-line back skin.

     Both the channel and the slot open at the top of the spine, so the
     magnets drop in from above and the cap covers them.
6. **Cap (the user asked for it):** a roof over the camera's top.
   - **Purpose:** it keeps rain off the USB-C plug.
   - **History:** the first version was a hood that hugged the camera's
     top. The user found it too small and asked for something more like a
     roof.
   - **Shape:** straight walls round the camera's top, under a hipped roof
     with 45° slopes. The eaves reach `cap_eave` (8 mm) past the walls,
     so water drips clear of them. The roof is a shell 4 lines thick, and
     the eaves' undersides are cut back at 45°, so it prints upright.
     It's about 70 × 71 mm and 65 mm tall.
   - **Inside:** it follows the camera's round top over the shoulders,
     then opens up into the roof. The roof's height is set so there's
     `usb_space` (35 mm) above the camera's top over the plug, room for a
     straight plug and the cable's bend.
   - **Seating:** it rests on the camera's shoulders. It's modelled
     settled there, `cap_sink` = `cap_clearance` × √2 lower than
     concentric.
   - **Detents:** two 45° bumps on the back of the spine, one each side
     of the cable slot, reach `cap_detent` into diamond windows in the
     cap's back wall, so wind can't lift it off.
   - **Front:** a notch, open at the bottom, clears the button.
   - **Cable:** it leaves through a slot up the middle of the back wall,
     under the eave (the user asked for the back; it was first in the
     side). The slot is open at the bottom, so the cap goes on with the
     cable already plugged in.
   - **Print orientation:** upright, open bottom on the bed.
7. **Held at its middle, turned and locked (the user asked for this):**
   - **Why the middle:** on the first version the camera stood on a
     toothed pad at its bottom. The user pointed out the torque that put
     on the mount, since anything pressing on the top had the camera's
     whole height as a lever.
   - **Collar:** it's pinned in the camera mount's fork. The cradle hangs
     in it by a band round its middle.
   - **Height:** the seat is `collar_h` (60 mm) above the camera's
     bottom, about its middle. That keeps the lever to the top short, and
     the camera's centre of mass is near the collar.
   - **Out of the view:** the collar's bottom inner edge and the band's
     cone stay above the lens's view. An assert checks they're at least
     `cam_view_half` (55°) above horizontal, seen from the lens centre;
     they're at 64°.
   - **Seat:** the sleeve below the band passes through the collar's bore
     (`r_bore`). The band's underside is a 45° cone that rests on a
     matching 45° seat, which centres it.
   - **Teeth:** `n_teeth` (360 / `cam_yaw_step`, 7.5° steps) round the
     band mesh with internal teeth in the collar.
     - **Printing:** they're vertical extrusions, and the band's teeth have
       their bottoms cut back on the same cone.
     - **Facets:** the collar's circles use `fn_teeth` (4 × `n_teeth`)
       facets, so every step lines up.
   - **Lock:** `cam_pin` goes through two posts at the back of the collar
     (toward the glass), just over the band's top edge, so the cradle
     can't be lifted off the teeth.
     - **Pin:** it's round with a flat for printing, and goes in flat side
       up.
     - **Posts:** they stand outside the band, so the cradle lifts out once
       the pin is pulled.
   - **Turning it:** pull the pin, lift the cradle `spline_h` (5 mm), turn
     it and drop it back.
   - **Range:** the fit checks cover 0–45° outward, where nothing hits.
   - **Ruled out:**
     - **A toothed pad under the camera with a thumbscrew clamp:** the
       first version. It had the torque problem above.
     - **A sprung latch on the collar:** any arm that could reach over the
       band would bend across its layers.
8. **Solar panel:** 197 × 165 mm.
   - **Thickness:** 5 mm at the edge and 7 mm by the junction box. The box
     is the full 15 mm.
   - **Box:** 50.5 × 72 mm, 47 mm from the cable edge.
   - **Socket:** 1/4"-20, centred along the 197 mm side, 57 mm (2.25 in)
     from the cable edge.
   - **Back holes:** the four small holes in the panel's back aren't used.
   - **Weight:** 210 g, plus 50 g of cable.
9. **Frame (the roof):**
   - **Orientation:** the panel goes in with its long side along the
     feeder and its cable edge toward the glass.
   - **Plate:** the box sits on the frame's plate. The plate is open
     under the panel except for a band round the box and two ribs.
   - **Rim:** ledges in the rim carry the panel's edges 10 mm up. The rim
     wall stops 1.5 mm below the panel's face, so water runs off the
     front.
   - **Cable:** a notch in the back rim lets the cable out.
   - **Size:** the frame is 250 mm wide (`frame_w`, the bed limit), from
     7 mm past the tray on the far side, so on the camera side it covers
     the camera at 0° but not all of it when turned.
   - **Height:** its front edge is `roof_headroom` above the perch top,
     as with the modular roof.
10. **Upper mount and bolt:** the panel's socket faces down at 15°, so a
   bolt from below needs a face for its head to bear on.
   - **Bolt head:** the bracket's bottom is parallel to the roof, and the
     bolt runs straight through it, so the head bears on the first layer.
     A pocketed head would need a bridged ceiling.
   - **Bolt and height:** a 1/4"-20 × 2 in steel bolt with a washer
     (`panel_bolt_len`, `socket_engage` 8 mm into the socket) sets the
     bracket's height, `um_h`.
   - **Turning:** two pins on the pad go into holes in the plate, so the
     frame can't turn on the bolt.
   - **Load:** the cup is at the socket's x, so the panel's weight doesn't
     twist the knob.
   - **Feet:** two feet outside the cup (`um_feet_x`) take the cantilever
     against the glass.
   - **Fixed angle:** the tilt is fixed at `roof_pitch`, as the user
     chose.
11. **Print orientation:**
   - **Rule (the user's):** each part prints flat, turned so its main
     loads in use run along the layers.
   - **Camera mount:** on its side (its -X face on the bed), so its side
     profile lies in every layer.
     - **Loads:** the cups' pull and push on the glass, the camera's
       weight and the arm's bending are all in that plane, so they load
       it along the layers.
     - **Cup slots:** they run up through it, closed ends at the bottom as
       floors.
     - **Lock bar channel:** its ceiling is a 3.8 mm bridge along the
       plate, as on the antenna clamp.
     - **Fork pin hole:** pointed at the top.
     - **Size:** about 175 × 72 mm on the bed and 32 mm tall.
   - **Collar:** flat, as mounted, so the ring, tab and seat take the
     cradle's weight along the layers. About 99 × 79 mm, 16 mm tall.
   - **Collar pin and lock pin:** flat, on their flats, so they bend along
     their layers.
   - **Camera mount lock bar:** flat, so its prongs flex along the layers.
     It's about 182 mm long.
   - **Cradle:** upright, on its floor. About 74 mm across the band and
     115 mm tall.
     - **Why upright:** it's the only orientation where its teeth and
       45° cone print.
     - **Exception to the rule:** below the band, the camera's weight
       hangs from the walls across the layers. That's about 2 N over
       300 mm² of wall, roughly 0.01 MPa.
   - **Cap:** upright, open bottom on the bed. Its export used to sit
     `cap_sink` (0.71 mm) below the bed, because `camera_cap_print` didn't
     allow for the cap settling; the post's version always did.
   - **Pin:** flat, on its flat.
   - **Upper mount:** on its bottom, so the cup slot leans 15°. Its pointed
     end's faces are then about 47° from horizontal, still printable.
   - **Frame:** flat, plate on the bed, 250 × 172 mm.

## Bird Buddy on a wooden post: design and why

1. **A file of its own, not a change to the variant.**
   `bird_buddy_post.scad` includes the Bird Buddy variant and keeps its
   collar, collar pin, cradle and lock pin, so a camera set up for the
   window moves across unchanged.
   - **Mounting (the user's choice):** any flat face of wood, the camera
     on its side of it, held by wood screws.
2. **Post mount:** the camera mount's profile (arm, fork, 45° gussets) on
   a plate `wp_t` (8 mm) thick, `wp_w` (36 mm) wide and about 105 mm tall.
   - **Screws:** four pan head wood screws (#8 or 4 mm; `wp_screw_d` is
     the 4.5 mm hole), two above the arm and two below. They sit past the
     gussets, so a screwdriver reaches them straight on.
   - **Reach:** `cam_z` is 130 mm here (105 on the window).
     - **Why:** at 105 the panel's corner hit the wood with the panel
       turned 45°. At 130 the panel clears the wood at any tilt the ball
       allows, either way, with its cable edge anywhere within 90° of
       facing the wood.
     - **Same collar:** the collar is the same part. Only the arm is
       longer.
   - **Camera angle:** nothing on the post mount reaches the cradle, so
     the camera can face any way, in `cam_yaw_step` steps. The mounted
     view shows 90°, straight out from the wood.
3. **Cap (the user asked for it to carry the panel):**
   - **Thicker:** `cap_wall_lines` is 6 (4 on the window).
   - **No eaves (the user's call):** `cap_eave` is 0 (8 on the window),
     because the panel keeps the rain off. The walls run straight up into
     the 45° roof.
     - **Why:** the eaves were the hardest part to print. Their
       undersides are 45°, but the hip corners slope at about 35°, and
       the eave edge starts as a thin edge in mid-air.
     - **Same height:** the roof's apex, and so the ball and panel, stay
       where they were.
   - **Longer:** `cap_down` is 48.5 (22 on the window). The cap reaches
     down over the solid part of the cradle's spine and stops just above
     the collar's lock pin posts. An assert checks it clears them.
   - **Screws:** two M3 × 10 pan head screws (`wp_cap_screw_len`) go
     through the back wall, either side of the cable slot, into the spine
     below its bump channel. Drill 2.5 mm pilots through the cap's holes
     the first time, so the cradle prints unchanged.
     - **Why:** the detents only stopped wind lifting a bare cap. The
       panel's weight and wind need a real fixing.
   - **Detent grooves:** grooves up the inside of the back wall let the
     spine's detents slide up to their windows. Without them the wall
     would have to flex over the detents for 30 mm of travel.
   - **Load:** the cap still rests on the camera's shoulders. The panel's
     weight goes to the cradle through the camera and through the screws.
4. **Ball joint (the user asked for an adjustable angle with a ball
   joint):**
   - **Socket:** a threaded boss on the cap's roof holds a bowl for a
     36 mm ball. The bowl stops just below the ball's equator, so the
     ball drops in. A drain runs from the bowl's bottom out of the boss's
     back.
   - **Thread:** BOSL2 trapezoidal, 46 × 2.5 mm, `thread_angle = 90`
     (45° flanks), as on the box holder. The bevels are set to the thread
     depth: BOSL2's default bevel on the ring's internal thread flared it
     away over nearly its whole length.
   - **Ring:** it screws down over the boss and grips the ball's upper
     half, from just above its equator up to `wp_ring_lat` (28°).
     - **Tilt:** its opening lets the stem tilt 39° (`wp_max_tilt_round`)
       most ways, but only `wp_max_tilt` (33.5°) toward the stem's keel,
       which reaches further from the axis. The keel is on the cable-edge
       side, so the usual tilt, low edge away from the wood, gets the
       full 39°.
     - **Heading:** the ball also spins in the socket, so the panel can
       face any way.
     - **Modelled clear:** the ring is drawn `wp_ring_clearance`
       (0.1 mm) off the ball.
     - **Thread phase:** the ring's thread meshes with the boss's at ring
       turns of 195–300°; the fit checks use 247.5°.
   - **Ball and stem, two parts (the user asked for the stem's layers to
     run along the panel's force):**
     - **Why two:** in one piece the stem had to print upright with the
       ball, so the panel's bending pulled its layers apart. The stem
       now prints on its side, its layers along it.
     - **Stem:** its cross-section is a teardrop cut flat `wp_keel`
       (8 mm) below its axis. The flat is the bed face, and the keel keys
       the stem in the ball. It flares at 45° to a 30 mm plate (D-shaped,
       cut by the same flat) that bears on the junction box.
     - **Ball:** the stem's end plugs 13 mm into a keyed pocket in the
       ball's top (`wp_pocket_floor`, `wp_pocket_clearance`). The ball
       prints upright. It takes only bearing loads, from the ring, the
       bowl and the stem in its pocket, and those lie along its layers.
     - **Bolt:** a steel 1/4"-20 × 2-1/2" flat head screw (82°
       countersink, `wp_bolt_len`) goes up through the ball and the stem
       into the panel's socket, `socket_engage` (8 mm) deep, and clamps
       all three together. Its head sits in a countersink under the
       ball.
     - **Ring first:** the plate is smaller than the ring's opening, so
       the ring slips over the stem before the stem goes into the ball.
     - **Ball's underside:** cut flat where it reaches 45°. A 45° cone,
       as on the feeder's knobs, would stick out of the sphere. The first
       version had one, and it dug 0.6 mm into the bowl, more when tilted.
   - **Panel limit:** with the cable edge more than about 90° from facing
     the wood, the panel's long side (108 mm from the socket) reaches the
     wood. Tilting the cable edge down toward the wood is fine.
5. **Fitting order:**
   1. Screw the mount to the wood.
   2. Fit the collar and the collar pin.
   3. Put the magnets and the camera in the cradle, and plug in.
   4. Push the cap on and drive the M3 screws.
   5. Lower the cradle into the collar and fit the lock pin.
   6. Put the ring over the stem, plug the stem into the ball, and bolt
      both to the panel through the ball.
   7. Set the ball in the socket and screw the ring down.
6. **Print orientation:**
   - **Post mount:** on its side, like the camera mount. About
     90 × 105 mm on the bed, 36 mm tall.
   - **Cap:** upright, open bottom on the bed. It's the only way the
     boss's thread and the ball's bowl print. About 55 × 57 mm, 110 mm
     tall.
   - **Ball:** upright, on its flat, 29 mm tall.
   - **Stem:** on its side, keel down, so its layers run along it. About
     30 × 40 mm on the bed, 23 mm tall.
   - **Ring:** upside down, its top on the bed, so the face that grips the
     ball faces up. 56 mm across, 21.5 mm tall.
7. **Wind (an estimate, not tested):** the panel is about 0.03 m². A
   20 m/s gust could push on it with roughly 10 N, about 1.5 N·m on the
   cradle and collar at the panel's height. The window version never
   carried that. If the cradle rocks in the collar in strong wind, look
   at that joint first.

## Verification

These are the project parts of the root `AGENTS.md` verification
workflow, steps 3 and 4.

### Accepted overhangs

- **Bird feeder:** the 1.8 mm and 4.2 mm cup slot flats, and the 10 mm
  bridge across the window top.
- **Modular feeder:** the mount's 1.8 mm and 4.2 mm cup slot flats, and
  the 1 × 3.5 mm flat on top of each barb pocket in the tray. The panel,
  keys, perch, roof and roof brackets have none.
- **Bird Buddy feeder:** the camera mount's lock bar channel ceiling
  (3.8 mm wide, the plate's length), and the 1.8 mm and 4.2 mm cup slot
  flats in the upper mount. In the upper mount, which prints
  tilted 15°, each flat shows up twice. There are also some zero-area
  slivers. The collar, cradle, cap, pins and frame have none.
- **Bird Buddy on a post:** a 0.03 mm² sliver at the cap's inner
  ridge, and a zero-area sliver along the stem's bolt hole. The post
  mount, ball and ring have none.

### Fit checks

- **Bird feeder, poses that must be clear:** the panel seated and lifted
  out (10, 30 and 52 mm up); the knob at rest in each slot and on its
  way up from below.
- **Bird feeder, poses that must overlap:** the panel moved 0.5 mm
  toward the glass, down or sideways; the knob moved 0.5 mm up, away
  from the glass or sideways.
- **Modular feeder, poses that must be clear:**
  - The tray hanging on the mount, offset 0.01 mm from the mount face
    because the posts bear on it.
  - The tray lifted 5–30 mm along the mount face.
  - The tray pulled 0.5–8 mm away after a 21.6 mm lift.
  - The tray against the cups and glass at 0–27 mm of lift.
  - The cup knob at rest and on its way up into its slot.
  - The panel seated, 0.01 mm up because it rests on the channel, and
    lifted 10, 30 and 60 mm with the keys out.
  - Each lock key seated in the tray, and each key against the seated
    panel.
  - Each key sliding in from 1–20 mm out, with `lock_barb = 0`, because
    the arm flexes past the barb.
  - The perch seated, 0.01 mm up because it rests on the socket floors,
    and lifted 10 and 25 mm.
- **Modular feeder roof, poses that must be clear:**
  - The brackets seated, offset 0.01 mm up and forward, and lifted 10,
    30 and 60 mm.
  - The roof seated, offset 0.01 mm up along its normal.
  - The roof sliding off forward 2–130 mm, with `roof_barb = -0.1`.
  - The roof against the mount, the cups and the glass.
  - The tray set (tray, panel, keys, perch) hanging, and lifted 22 mm
    and pulled away, against the roof and brackets.
- **Modular feeder roof, poses that must overlap:**
  - A bracket moved 0.5 mm forward, down or sideways.
  - The roof moved 0.5 or 5 mm forward (the latch), 0.5 mm back (the
    stops), 0.5 mm up (the rails), 0.5 mm down (it rests on the rails)
    or sideways.
- **Modular feeder, poses that must overlap:**
  - The tray moved 0.5 mm down, away from the glass or sideways.
  - The cup knob moved 0.5 mm up or away from the glass.
  - The panel moved 0.5 mm toward or away from the glass, down or
    sideways.
  - The panel moved 0.5 mm up or down with the keys in (the lock holds).
  - Each key moved 0.5 mm outward (the barb catches), inward (it
    bottoms out), up or toward the glass.
  - The perch moved 0.5 mm forward, down or sideways.
- **Bird Buddy feeder, poses that must be clear:**
  - **Camera mount and its surroundings:** the camera mount, collar and
    collar pin against the tray set (hanging, lifted 5–22 mm, and pulled
    away 4, 8 and 30 mm), the feeder mount, its cups and the glass.
  - **Its cups:** each knob and cup body at rest. The neck path, head
    path and cup body sliding in 10, 25 and 40 mm from the open side.
  - **Lock bar:** the bar in its channel (0.01 mm up), against both
    knobs. Sliding in from 20, 80 and 150 mm with `cbar_barb = -0.05`.
  - **Collar and pin:** the collar in the fork (0.01 mm up), and slid
    out 5, 12 and 25 mm. The collar pin (0.01 mm up) against the mount
    and the collar.
  - **Cradle and camera:** at each 7.5° step from 0 to 45°, against the
    camera mount and collar, each other, the tray set (hanging, lifted and pulled
    away), the frame and the upper mount.
  - **Cap:** in each of those poses (with the camera, cradle and plug),
    against the camera mount and collar, frame, upper mount and tray set. At rest
    (0.03 mm up) against the camera, plug and cradle. Lowered in from
    5, 15 and 30 mm with `cap_detent = -0.05`.
  - **Camera and magnet:** the camera lowered into the cradle from 10,
    60 and 130 mm. The magnet in its slot, against the cradle and the
    camera.
  - **Turning:** the cradle lifted `spline_h` + 0.1 mm and turned half a
    step.
  - **Collar:** the cradle and camera lowered into it from 10, 30, 60
    and 100 mm. The cradle lifted 0.5 mm without the pin.
  - **Lock pin:** against the collar and mount, and against the cradle
    at each step.
  - **Panel:** the panel (box plus slab) in the frame, 0.01 mm up.
  - **Frame and upper mount:** the frame on the upper mount, 0.01 mm up.
    The upper mount against its knob, its cup body (at rest and sliding
    in 10 and 30 mm, with neck and head paths) and the glass. The frame
    and upper mount against the glass, the tray set (hanging, lifted
    and pulled away up to 30 mm), the feeder mount and the camera mount
    and collar.
- **Bird Buddy feeder, poses that must overlap:**
  - The collar moved 0.5 mm up, down or back in the fork. Moved 0.5 mm
    out or sideways, it hits the collar pin.
  - The cradle seated half a step round (the teeth lock it), 0.3 mm
    lower (it rests on the seat) or 0.5 mm sideways.
  - The cradle lifted 0.5 mm with the pin in.
  - The cap moved 0.3 mm down (it rests on the camera) or 0.6 mm up
    (the detent).
  - The camera moved 0.8 mm back or sideways in the cradle.
  - The panel moved 0.6 mm sideways or down the slope in the frame.
  - The frame moved 1 mm sideways on the upper mount (the pins).
  - Each camera mount knob moved 0.5 mm deeper, up, down or off the
    glass, or 1 mm out against the lock bar. The upper mount's knob
    moved deeper or off the glass.
  - The lock bar pulled 0.5 mm up (the barbs catch) or pushed 0.5 mm
    down (the head stops).
- **Bird Buddy on a post, poses that must be clear:**
  - **Which collar and cradle:** run these with them rendered and
    again with them imported from the variant's STLs.
  - **Clear:** measure each intersection's volume. Faces that only
    touch, like the collar pin's head on the fork, leave a
    zero-thickness result.
  - **Post mount:** against the collar and pins, and the wood (0.01 mm
    off).
  - **Turning:** at every 22.5° of camera angle, the cradle (0.05 mm
    up, as it rests on the seat), camera, magnet, plug, cap, cap screws
    and ring, against the post mount, collar, pins and wood.
  - **Cap:** at rest (0.03 mm up) and lowered on from 5, 15 and 30 mm,
    against the camera and cradle. The cap screws against the camera
    and magnet.
  - **Ring:** on the boss, turned 247.5° so the threads mesh, against
    the cap, camera and cradle. Passing over the stud (ball and stem),
    5–45 mm up its axis.
  - **Stem in the ball:** seated (0.01 mm up) and sliding in from 5
    and 10 mm.
  - **Stud:** at tilts of -33 to 38° (the keel side is negative) in
    eight headings, against
    the ring and cap.
  - **Panel:** the panel and stud at camera angles of 0, 90, 180 and
    270°, tilts of -33 to 38° and headings of -90 to 90° in 15° steps,
    against everything else and the wood.
  - **Screwdriver:** a pan head and a 6 mm shank, 150 mm out from each
    wood screw, against the post mount.
- **Bird Buddy on a post, poses that must overlap:**
  - The stud moved 0.3 mm down, up or sideways.
  - The stem moved 0.3 mm sideways or toward its keel, or turned 5°,
    in the ball's pocket (the key).
  - The cap moved 0.3 mm down (it rests on the camera).
  - The ring turned 120° from its mesh (the threads engage).
  - The cap screws against the cradle (they bite into the spine).
- **Bird feeder diff:** `difference()` the new feeder and the original
  both ways. The only pieces left should be at the towers, the window
  and rail block, and the ridges.

## Tuning notes for the user

- **Feeder panel:** if it's too loose or too tight in its rails, adjust
  `panel_clearance`. The window size is set by `win_w`, `win_bottom` and
  `win_top`.
- **Modular feeder:** if the tray knobs are loose or tight in the mount,
  adjust `slot_clearance` in `library/suction_cup.scad`, which also changes the cup
  slots. Use `drain_d` for the hole size, `front_h` for how low the front
  is, and `perch_drop` and `perch_reach` for where the perch sits.
  `lock_barb` sets how firmly the panel lock keys snap in, and
  `lock_clearance` how freely they slide.
- **Roof:**
  - **Size and shape:** `roof_headroom` (150 mm above the perch, which
    gives about 160 mm over the perch rail) sets the roof's height, `roof_pitch` its slope, and `roof_overhang` and
    `roof_side_overhang` its size.
  - **Fit:** `roof_barb` sets how firmly it latches, and `roof_clearance`
    how freely the brackets and rails slide.
- **Bird Buddy feeder:**
  - **Camera side:** `buddy_side`. For the -X side, re-export the camera
    mount with `-D buddy_side=-1`.
  - **Camera mount:** `cm_cup_top` and `cm_cup_bot` place its cups.
    `joint_clearance` sets the fit of the collar's tab in the fork.
    `cbar_clearance` sets how freely the lock bar slides, and `cbar_barb`
    how firmly it snaps in.
  - **Camera:** `cam_h`, `cam_w`, `cam_d`, `cam_bump` and the lens and
    button positions. `cam_clearance` sets how loose it sits in the
    cradle.
  - **Magnet:** if the camera doesn't wake in the cradle, move
    `cam_magnet_from_top` to where its bump is, or stack more with
    `cam_magnets`. `cam_magnet_d` and `cam_magnet_t` set the magnet's
    size.
  - **Cap:** set `usb_space` to suit the plug (a right-angle plug needs
    less), and `cap_eave` for how far the roof overhangs. `cable_d` sets the cable slot, and
    `cap_detent` how firmly the cap stays on.
  - **Camera position:** `cam_lens_y` sets its height, and `cam_x` and
    `cam_z` where it pivots.
  - **Turning:** `cam_yaw_step` sets the steps, `spline_clearance` the fit
    of the teeth, and `cam_yaw` the angle shown in the mounted view.
  - **Collar:** `collar_h` sets where the camera is held. Lower it only
    as far as the assert allows (`cam_view_half`). `seat_w` sets the
    seat's width.
  - **Lens:** if the camera binds sliding in, raise `cam_lens_proud`.
  - **Pin:** `lock_pin_clearance` sets how snug the pin is in its posts.
  - **Panel:** `sp_*`, `jbox_*` and `socket_from_edge`. `sp_clearance`
    sets the fit in the frame.
  - **Bolt:** a different bolt length changes `panel_bolt_len`, which
    re-sizes the upper mount. Check the socket is at least
    `socket_engage` deep.
  - **Roof:** `roof_pitch` and `roof_headroom`.
- **Bird Buddy on a post:**
  - **Reach:** `cam_z`. Below 130 it limits which ways the panel can face.
  - **Wood screws:** `wp_screw_d` sets the hole and `wp_screw_x` their
    spacing.
  - **Cap screws:** `wp_cap_screw_d`, `wp_cap_screw_len` and
    `wp_cap_screw_down`. The asserts keep them in the solid part of the
    spine.
  - **Ball joint:**
    - **Grip:** if the ring won't clamp the ball, lower
      `wp_ring_clearance`. If it binds on the boss, raise
      `wp_thread_slop`.
    - **Range:** `wp_ring_lat` trades grip for tilt range
      (`wp_max_tilt`, `wp_max_tilt_round`). A smaller `wp_keel` gives
      more tilt toward the keel but a narrower flat on the bed.
    - **Bolt:** a different bolt changes `wp_bolt_len`, which moves the
      stem's plate.
  - **Mounted view:** `wp_panel_tilt` and `wp_panel_heading` pose the
    panel, and `cam_yaw` the camera.
