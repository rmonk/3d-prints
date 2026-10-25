// Bird Buddy Variant of the Modular Suction Cup Bird Feeder
// -------------------------------------------------------------
// The modular feeder (suction_cup_bird_feeder_modular.scad), with a
// Bird Buddy 2 camera module beside the tray and a solar panel for a
// roof. The mount, tray, panel, lock keys and perch are the modular
// feeder's parts, unchanged; the roof and its brackets are replaced by:
//
//  - camera_mount: a window mount of its own beside the feeder, on two
//    suction cups one above the other. A plate on the glass carries an
//    arm out to the camera. Both cup slots open through the side away
//    from the feeder, and it touches nothing on the feeder, so the tray
//    still lifts off on its own.
//  - cam_lock_bar: slides down a channel just in front of both cup heads
//    and snaps out of the bottom of the plate, as on the antenna clamp, so
//    the heads can't slide back out. Squeeze its prongs to pull it out.
//  - camera_collar: a toothed ring the camera hangs in. A tab on it
//    slides into a fork at the end of the arm and collar_pin locks it.
//  - camera_cradle: a sleeve the camera drops into, looking across the
//    tray along the perch. A toothed band round its middle drops into
//    the collar, so the camera is held
//    near its middle, just above the lens's view, not from its bottom.
//    A 45 degree cone under the band seats it in the collar, and the
//    teeth set its angle, outward (away from the glass) in steps of
//    cam_yaw_step. The sleeve follows the camera's pill shape, and a spine
//    up its back holds the stack of 18 x 2 mm magnets (3 by default)
//    the camera needs to switch on, behind the camera's magnet bump.
//  - cam_pin: a pin through two posts on the collar, over the band's top
//    edge, so the cradle can't be lifted out of the teeth.
//  - camera_cap: a hipped roof over the top of the camera that keeps rain
//    off the USB plug, its eaves reaching cap_eave past the walls so
//    water drips clear. It rests on the camera's rounded top, two small
//    detents on the spine hold it down, and the cable leaves through a
//    slot in its back wall under the eave, between the detents, open at
//    the bottom so the cap goes on with the cable in.
//  - upper_mount: a bracket with one suction cup, higher up the glass,
//    that the panel bolts to through its 1/4"-20 socket with a steel
//    bolt (panel_bolt_len, with a washer).
//  - solar_frame: the roof. The panel sits in its rim, the junction box
//    on the frame's plate, and the bolt clamps bracket, plate and box
//    together. The frame reaches past the panel to cover the tray and
//    most of the camera, and two pins on the bracket stop it turning.
//
// Fitting: hang the mount and tray as for the modular feeder. Slide the
// camera mount's cups into its slots from the side away from the feeder,
// push the lock bar down its channel from the top until its prongs snap
// out of the bottom, and press both cups onto the glass. Slide the collar's tab into the arm's
// fork and drop collar_pin in from the top. Drop the magnets into the slot at the top of the
// cradle's spine and the camera into the cradle, then lower the cradle
// into the collar at the angle you want and push the pin through the
// posts. Plug in the cable and push the cap down over the top. To turn
// the camera, pull the pin, lift the cradle 5 mm off the teeth, turn it
// and drop it back. Bolt the panel
// into the frame on the upper mount (bolt up from under the bracket),
// then fit the upper mount's cup to the glass above the feeder.
//
// Designed to print with no supports:
// Each part prints flat, turned so its main loads in use run along the
// layers, not across them:
//  - camera_mount: on its side. Its side profile (plate, arm, gussets,
//    fork) lies in every layer, so the cups pulling on the glass, the
//    camera's weight and the arm bending all load it along the layers.
//    The cup slots run up through it with their closed ends at the
//    bottom, the lock bar channel's ceiling is a 3.8 mm bridge, and the
//    pin hole has a pointed top
//  - cam_lock_bar: flat, so its prongs flex along the layers
//  - camera_collar: flat, as mounted, so the ring, its tab and the seat
//    take the cradle's weight along the layers. The seat is a 45 degree
//    cone, the teeth are vertical and the lock pin hole has a pointed top
//  - collar_pin: flat, like cam_pin
//  - camera_cradle: upright, on its floor. The band's underside is a 45
//    degree cone, its teeth are vertical, and the lens window has a
//    pointed top
//  - cam_pin: flat, on the flat along its side
//  - camera_cap: upright, open bottom on the bed. The roof's slopes and
//    the undersides of its eaves are 45 degrees, its inside rises at 45
//    degrees over the camera's shoulders, and the slots have pointed tops
//  - upper_mount: on its bottom, which is parallel to the roof, so the
//    bolt hole is vertical and the bolt head bears on the first layer.
//    The cup slot leans 15 degrees, and the bracket's underside rises at
//    45 degrees to the front of the pad
//  - solar_frame: flat, plate on the bed, rim up
// Set part = "mounted" to view the assembly as it sits on the glass.
// All dimensions in mm.

include <suction_cup_bird_feeder_modular.scad>

/* [Output] */
// Which part to render
part = "mounted"; // [all, mounted, camera_mount, cam_lock_bar, camera_collar, collar_pin, camera_cradle, camera_cap, cam_pin, upper_mount, solar_frame, mount, tray, panel, lock, perch]
// Side the camera goes on (+X is on the left seen from indoors)
buddy_side = 1; // [1:Left from indoors (+X), -1:Right from indoors (-X)]

/* [Camera] */
// Camera module height (portrait)
cam_h = 122;
// Camera module width
cam_w = 51;
// Camera module thickness, front to back, without the magnet bump
cam_d = 37.5;
// Magnet bump on the back: height, diameter, and centre down from the top
cam_bump = 2;
cam_bump_d = 18;
cam_magnet_from_top = 25;
// Magnets in the cradle that switch the camera on: diameter, thickness,
// and how many are stacked in the slot (one wasn't enough)
cam_magnet_d = 18;
cam_magnet_t = 2;
cam_magnets = 3;
// Rounding of the camera's front and back edges (for the reference model)
cam_edge_r = 3;
// Lens centre, down from the top
cam_lens_from_top = 97;
// Lens glass diameter, and how far its bezel stands proud of the front
cam_lens_d = 26;
cam_lens_proud = 1;
// Front button: centre down from the top, diameter and how far it sticks out
cam_button_from_top = 25;
cam_button_d = 10;
cam_button_out = 13;
// Clearance around the camera in the cradle (per side)
cam_clearance = 0.75;
// Height of the lens centre (the perch top is at -37)
cam_lens_y = -22;
// Pivot position: along the feeder and out from the glass
cam_x = 136;
cam_z = 105;
// Angle shown in the mounted view, outward from straight across the tray
cam_yaw = 0;
// Angle steps of the toothed ring
cam_yaw_step = 7.5;
// Height of the collar's seat above the camera's bottom: about its middle,
// just above the lens's view
collar_h = 60;
// Half-angle of the lens's view above horizontal that the collar and band
// must stay out of
cam_view_half = 55;
// Cradle wall thickness, in lines
cradle_wall_lines = 4;

/* [Cap] */
// Headroom above the camera's top for the USB plug and the cable's bend
usb_space = 35;
// How far the roof's eaves reach past its walls
cap_eave = 8;
// Width of the space for the plug
usb_plug_w = 16;
// Cable diameter (the exit slot is a little wider)
cable_d = 4.5;
// How far the cap reaches down from the camera's top
cap_down = 22;
// Clearance between the cap and the camera (per side)
cap_clearance = 0.5;
// How far the detent that holds the cap down sticks out
cap_detent = 0.5;
// Cap wall thickness, in lines
cap_wall_lines = 4;

/* [Swivel] */
// Height of the teeth that lock the cradle's angle
spline_h = 5;
// Tooth depth
spline_depth = 1.2;
// Clearance between the cradle's teeth and the collar's (per side)
spline_clearance = 0.2;
// Width of the 45 degree seat the band rests on in the collar
seat_w = 2.5;
// Thickness of the collar under its seat
collar_floor = 2;

/* [Lock Pin] */
// Pin diameter
lock_pin_d = 4;
// Clearance round the pin in its holes
lock_pin_clearance = 0.15;

/* [Camera Mount] */
// Heights of the two cups' centres, above and below the arm (on the
// glass, at the camera's x). They must clear the feeder mount's cup.
cm_cup_top = 60;
cm_cup_bot = -40;
// Lock bar: width across the slots, clearance in its channel (per side),
// wall outside the channel, stop head length, snap barbs, prongs, slit
cbar_w = 6;
cbar_clearance = 0.3;
cbar_wall = 2;
cbar_head = 4;
cbar_barb = 0.6;
cbar_snap_len = 14;
cbar_slit = 1.6;
// Thickness of the plate on the glass
cm_t = 10;
// Prongs of the fork above and below the collar's tab
cm_prong = 6;
// Gussets from the plate to the arm (45 degrees)
cm_gusset = 25;
// Collar's tab: length into the fork and thickness
tab_len = 20;
tab_t = 6;
// Clearance in the fork (per side)
joint_clearance = 0.2;
// Pin through the fork and tab
joint_pin_d = 5;

/* [Solar Panel] */
// Panel size: along the feeder and front to back
sp_w = 197;
sp_d = 165;
// Panel corner radius
sp_corner_r = 8;
// Thickness at the edge, and overall at the junction box
sp_edge_t = 5;
sp_t = 15;
// Junction box: width (along the feeder), length, corner radius
jbox_w = 50.5;
jbox_l = 72;
jbox_r = 9;
// Distance from the panel's back edge (the cable side) to the box
jbox_near = 47;
// Distance from the panel's back edge to the 1/4"-20 socket
socket_from_edge = 57.15;
// Clearance round the panel in the frame (per side)
sp_clearance = 0.5;

/* [Roof Frame] */
// Overall width of the frame (fits a 256 mm bed up to 250)
frame_w = 250;
// How far the frame reaches past the tray on the side away from the camera
frame_inner_overhang = 7;
// Plate thickness
frame_t = 3;
// Width of the ledges under the panel's edges
ledge_w = 3;
// Rim wall thickness, in lines
rim_lines = 4;
// Frame beyond the front of the panel's rim
front_skirt = 3;
// Width of the notch in the back rim for the panel's cable
cable_notch = 50;
// Slope of the roof, down toward the front
roof_pitch = 15;
// Height of the frame's front edge (underneath) above the top of the perch
roof_headroom = 150;
// Gap between the back of the frame and the glass
roof_back_gap = 3;

/* [Upper Mount] */
// Length of the steel 1/4"-20 bolt (2 in)
panel_bolt_len = 50.8;
// How far the bolt goes into the panel's socket
socket_engage = 8;
// Washer thickness under the bolt head
washer_t = 1.6;
// Width of the bracket (along the feeder)
um_w = 30;
// Gap between the feet and the glass
foot_gap = 0.5;

/* [Slicer] */
// Extrusion line width
line_w = 0.45;
// Layer height
layer_h = 0.28;

/* [Hidden] */
modular_output = false;
// Render the parts below. A file that includes this one sets it to false
// after the include and renders its own.
buddy_output = true;

// ---------- derived values ----------
// Wall thickness of n perimeter lines: the slicer overlaps neighbouring
// lines, so they are line_w - layer_h * (1 - pi / 4) apart.
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));

mside = buddy_side < 0 ? 1 : 0;           // mirror for the -X side

// Cradle, in its own frame: pivot on the y axis, y = 0 under its floor,
// the camera looking along -X
cw        = lines(cradle_wall_lines);
pin_x     = cam_d + 2 * cam_clearance;               // pocket, front to back
pin_z     = cam_w + 2 * cam_clearance;               // pocket, side to side
cb        = 2.4 + cam_clearance;                     // camera bottom: floor + clearance
cam_top   = cb + cam_h;
x_cf      = -pin_x / 2 + cam_clearance;              // camera front face
x_cb      = x_cf + cam_d;                            // camera back face
y_mag     = cam_top - cam_magnet_from_top;           // magnet and bump centre
// Spine up the back of the cradle: a channel for the bump, a skin, the
// magnet slot and a back skin
mag_stack = cam_magnets * cam_magnet_t;
xm0       = pin_x / 2 + cam_bump + cam_clearance + lines(2);  // magnet slot, front face
x_sp1     = xm0 + mag_stack + 0.3 + lines(3);     // back of the spine
sp_wd     = max(cam_magnet_d, cam_bump_d) + 2 * cam_clearance + 2 * lines(4);
sp_top    = cam_top - 10;
sl_r      = cam_edge_r + cam_clearance + cw;         // corner radius of the walls, in plan
sl_half   = norm([pin_x / 2 + cw - sl_r, pin_z / 2 + cw - sl_r]) + sl_r;
r_bore    = max(sl_half, norm([x_sp1, sp_wd / 2])) + 0.5;   // collar bore: the sleeve passes through
r_root    = r_bore + seat_w;                         // band: teeth roots
r_tip     = r_root + spline_depth;
n_teeth   = round(360 / cam_yaw_step);
fn_teeth  = 4 * n_teeth;                             // facets of the collar's circles, in step with the teeth
r_pad     = r_tip + spline_clearance + lines(5);     // collar outside radius
collar_y  = cb + collar_h;                           // seat: the bottom of the band's teeth
band_top  = collar_y + spline_h;
dcone     = r_root - (pin_x / 2 + cw);               // the band's cone reaches the front and back faces
lens_y    = cb + cam_h - cam_lens_from_top;          // lens centre above the base
win_r     = cam_lens_d / 2 + 6;                      // lens window

// Cap, in the cradle's frame
capw      = lines(cap_wall_lines);
cap_y0    = cam_top - cap_down;                      // bottom edge
cap_yc    = cam_top - cam_w / 2;                     // centre of the camera's top arc
cap_r     = cam_w / 2 + cap_clearance;
cap_xf    = x_cf - cap_clearance - capw;             // front, outside
cap_xb    = x_sp1 + cap_clearance + capw;            // back, outside the spine
det_y     = cam_top - 17;                            // detents
det_z     = (cable_d + 0.6) / 2 + 4;                 // either side of the cable slot
cap_sink  = cap_clearance * sqrt(2);                 // the cap settles onto the camera's shoulders
cap_x_usb = x_cf + cam_d / 2;                        // plug and cable slot, front to back
// The roof: hipped at 45 degrees over the walls' footprint grown by
// cap_eave, a shell capw thick, its eaves cut back at 45 degrees underneath.
// Inside it's open above cap_open; below, the inside follows the camera's
// shoulders, which it rests on.
cap_hz    = cap_r + capw;                            // walls, half width
cap_c     = capw * sqrt(2);                          // the shell's thickness, measured vertically
cap_X0    = cap_xf - cap_eave;                       // eaves' footprint
cap_X1    = cap_xb + cap_eave;
cap_Z     = cap_hz + cap_eave;
cap_open  = cam_top - 2;
// eaves' height: usb_space of headroom over the plug
cap_ye    = cam_top + usb_space + cap_c - min(cap_x_usb - cap_X0, cap_X1 - cap_x_usb, cap_Z);
cap_ct    = cam_top + 8;                             // top of the cable slot
assert(sp_top > y_mag + cam_magnet_d / 2 + 1, "the spine must reach above the magnet");
assert(cap_ct + (cable_d + 0.6) / 2 < cap_ye - cap_c + cap_eave - 1, "the cable slot must stay under the roof");
assert(cap_ye - cap_c > cap_open, "the eaves must be above the cap's seat");
assert(det_z + 2.5 < sp_wd / 2 - 1, "the detents must be on the spine");
assert(det_y > cap_y0 + 3 && det_y < sp_top - 3, "the detent must be on the spine, inside the cap");
assert(abs(n_teeth * cam_yaw_step - 360) < 0.01, "cam_yaw_step must divide 360");

// Collar, in model coordinates
cam_y0    = cam_lens_y - lens_y;                     // bottom of the cradle
y_seat    = cam_y0 + collar_y;
y_sb      = y_seat - seat_w - collar_floor;          // bottom of the collar
ring_top  = y_seat + spline_h - 0.5;
// Lock pin: across the back of the collar (toward the glass), over the
// band's top edge, held in two posts outside the band
pin_off   = r_tip - 1.5;                             // pin's distance from the axis
pin_yc    = y_seat + spline_h + 0.3 + lock_pin_d / 2;
lock_post_d    = 6;
post_t0   = sqrt(pow(r_tip + 0.7, 2) - pow(pin_off - lock_post_d / 2, 2));
post_t1   = post_t0 + 5;
post_top  = pin_yc + lock_pin_d / 2 + 2.5;
pin_len   = 2 * (post_t1 + 1.5);
// The collar's bottom inner edge and the band's lowest edge, seen from the
// lens centre, must be above its view
view_collar = atan((y_sb - cam_lens_y) / (r_bore - abs(x_cf)));
view_band   = atan((y_seat - dcone - cam_lens_y) / (pin_x / 2 + cw - abs(x_cf)));
assert(min(view_collar, view_band) >= cam_view_half, "the collar is in the lens's view: raise collar_h");

// Camera mount (mounted orientation): a side profile [z, y] extruded across
// x = cm_x0..cm_x1, printed on its side
cbar_chan = cbar_w + 2 * cbar_clearance;
cbar_x0   = cam_x + head_r;                           // lock bar channel, just past the heads
cbar_x1   = cbar_x0 + cbar_chan;
cbar_t    = pocket_h - 2 * cbar_clearance;
cm_w      = 2 * (head_r + cbar_chan + cbar_wall);     // width, along the feeder (its height in print)
cm_x0     = cam_x - cm_w / 2;
cm_x1     = cam_x + cm_w / 2;
y_pb      = cm_cup_bot - cup_d / 2 - 1 - foot_h;      // bottom of the plate
y_pt      = cm_cup_top + cup_d / 2 + 1 + foot_h;      // top of the plate
y_a0      = y_sb - joint_clearance - cm_prong;        // arm: bottom and top
y_a1      = y_sb + tab_t + joint_clearance + cm_prong;
z_fe      = cam_z - r_pad - 0.5;                      // end of the fork, clear of the collar ring
z_jpin    = z_fe - tab_len / 2;                       // pin through fork and tab
jpin_len  = y_a1 - y_a0 + 1;
cbar_len  = y_pt - y_pb + 0.3;                        // lock bar body: the barbs catch the bottom face
cbar_ramp = 3;
assert(cm_t >= floor_t + pocket_h + roof_thickness, "cm_t is too thin for the cup slots");
assert(cm_w / 2 >= head_r + tip_extra + roof_thickness, "cm_w is too narrow for the cup slots");
assert(min(norm([cam_x - cup_x, cm_cup_top]), norm([cam_x - cup_x, cm_cup_bot])) > cup_d + 1,
       "the camera mount's cups must clear the feeder mount's cup");

// Roof frame: local x across, y = v (normal to the roof, v = 0 under the
// plate), z = u (down the slope from the back edge)
rim_t     = lines(rim_lines);
pu0       = rim_t + sp_clearance;                     // panel's back edge
fL        = pu0 + sp_d + sp_clearance + rim_t + front_skirt;
fx0       = -(tray_w / 2 + frame_inner_overhang);
fx1       = fx0 + frame_w;
pcx       = (fx0 + fx1) / 2;                          // panel centre and socket, across
u_s       = pu0 + socket_from_edge;                   // socket, down the slope
v_ledge   = frame_t + sp_t - sp_edge_t;               // where the panel's edges rest
v_wall    = frame_t + sp_t - 1.5;                     // rim wall top, below the panel's face
roof_y_f  = perch_top + roof_headroom;                // front edge, underneath
Y0        = roof_y_f + fL * sin(roof_pitch);          // back edge, underneath
function rz(u, v) = roof_back_z + u * cos(roof_pitch) + v * sin(roof_pitch);
function ry(u, v) = Y0 - u * sin(roof_pitch) + v * cos(roof_pitch);
function u_at_z(z, v) = (z - roof_back_z - v * sin(roof_pitch)) / cos(roof_pitch);
assert(frame_w <= 250, "frame_w must fit the bed");
assert(fL <= 250, "the frame must fit the bed");

// Upper mount: its bottom is parallel to the roof, um_h under the plate,
// so the bolt runs straight through it
um_h      = panel_bolt_len - frame_t - socket_engage - washer_t;
pad_t     = 5;                                        // bracket under the front of the pad
u_pad1    = pu0 + jbox_near + jbox_l - 4;             // front end of the pad, under the box
u_be      = u_pad1 - (um_h - pad_t);                  // where the 45 degree underside starts
washer_r  = 9.5;
pins_u    = [u_s - 20, u_s + 30];                     // locating pins on the pad
pin_d     = 6;
y_c4      = ry(u_at_z(0, 0), 0) - slot_end - roof_thickness - 2;   // upper cup centre
y_ob      = ry(u_at_z(0, -um_h), -um_h);              // bottom of the bracket at the glass
um_feet_x = cup_d / 2 + 1;                            // feet outside the cup
assert(u_be >= u_s + washer_r, "the bolt head must bear on the bracket's bottom");

echo(str("Camera mount: cups at x ", cam_x, ", y ", cm_cup_bot, " and ", cm_cup_top, ", plate ", y_pt - y_pb,
         " tall; cradle pivot at x ", cam_x, ", z ", cam_z,
         "; collar ", 2 * r_pad, " across, ", n_teeth, " teeth (", cam_yaw_step, " deg), seat ",
         collar_h, " above the camera's bottom, clear of the lens's view to ",
         min(view_collar, view_band), " deg  Lock pin: ", lock_pin_d, " x ", pin_len,
         "  Collar pin: ", joint_pin_d, " x ", jpin_len,
         "  Frame: ", frame_w, " x ", fL, ", panel centre x ", pcx,
         "  Upper mount: cup at x ", pcx, ", y ", y_c4, ", ", um_h, " thick under the plate",
         "  Panel bolt: 1/4\"-20 x ", panel_bolt_len, " with a ", washer_t, " washer"));

// ---------- helpers ----------
// 2D [x, u] shape extruded along v, in the roof frame
module ext_v(v0, v1) {
    mirror([0, 1, -1]) translate([0, 0, v0]) linear_extrude(v1 - v0, convexity = 10) children();
}

// The roof frame
module frame_tf() translate([0, Y0, roof_back_z]) rotate([roof_pitch, 0, 0]) children();

module rounded_rect2d(p0, p1, r) {
    translate(p0 + [r, r]) offset(r = r) square(p1 - p0 - [2 * r, 2 * r]);
}

// ---------- swivel teeth ----------
// The cradle's base outline: a circle with n_teeth teeth round its rim
module spline2d() {
    pa = 360 / n_teeth;
    polygon([for (i = [0 : n_teeth - 1], k = [0 : 3])
        let(a = i * pa + [-0.3, -0.1, 0.1, 0.3][k] * pa,
            r = [r_root, r_tip, r_tip, r_root][k])
        [r * cos(a), r * sin(a)]]);
}

// ---------- camera mount (mounted orientation, +X side; prints on its side) ----------
// Side profile, as [z, y]: the plate on the glass with a foot at each
// end, the arm out to the fork, and 45 degree gussets between them
module camera_mount2d() {
    gz = glass_z + foot_gap;
    // plate, with feet reaching to the glass beyond the cups. The bottom
    // foot's top slopes at 45 degrees, so seeds don't rest on it.
    polygon([[gz, y_pb], [cm_t, y_pb], [cm_t, y_pt], [gz, y_pt], [gz, y_pt - foot_h],
             [0, y_pt - foot_h + gz], [0, y_pb + foot_h - gz], [gz, y_pb + foot_h]]);
    // arm
    translate([cm_t - eps, y_a0]) square([z_fe - cm_t + eps, y_a1 - y_a0]);
    // gussets
    polygon([[cm_t - eps, y_a1 - eps], [cm_t + cm_gusset, y_a1 - eps], [cm_t - eps, y_a1 + cm_gusset]]);
    polygon([[cm_t - eps, y_a0 + eps], [cm_t + cm_gusset, y_a0 + eps], [cm_t - eps, y_a0 - cm_gusset]]);
}

module camera_mount() {
    difference() {
        extrude_x(cm_x0, cm_x1) camera_mount2d();
        // fork for the collar's tab, open toward the camera
        box([cm_x0 - 1, y_sb - joint_clearance, z_fe - tab_len - joint_clearance],
            [cm_x1 + 1, y_sb + tab_t + joint_clearance, z_fe + 1]);
        // cup slots, both opening toward +X (away from the feeder)
        for (y = [cm_cup_top, cm_cup_bot])
            translate([cam_x, y, 0]) rotate([0, 0, 90]) cup_slot(-cm_w / 2);
        // lock bar channel, the full length of the plate, at head-pocket
        // height just past the heads
        box([cbar_x0, y_pb - 1, floor_t], [cbar_x1, y_pt + 1, floor_t + pocket_h]);
        // pin hole through the fork, pointed toward +X (up when printed)
        r = joint_pin_d / 2 + joint_clearance;
        translate([cam_x, y_a0 - 1, z_jpin]) rotate([-90, 0, 0])
            linear_extrude(y_a1 - y_a0 + 2, convexity = 10) rotate(-90) pointed_circle2d(r, r * sqrt(2));
    }
}

// ---------- collar (mounted orientation, prints flat) ----------
module camera_collar() {
    difference() {
        union() {
            translate([cam_x, 0, cam_z]) rotate([-90, 0, 0])
                translate([0, 0, y_sb]) cylinder(r = r_pad, h = ring_top - y_sb);
            // tab into the arm's fork
            box([cm_x0, y_sb, z_fe - tab_len], [cm_x1, y_sb + tab_t, cam_z - 20]);
            // block behind the ring for the lock pin posts
            box([cam_x - post_t1, y_sb, cam_z - pin_off - lock_post_d / 2], [cam_x + post_t1, ring_top, cam_z - 20]);
            // lock pin posts, outside the band
            for (s = [-1, 1])
                box([cam_x + (s > 0 ? post_t0 : -post_t1), ring_top - eps, cam_z - pin_off - lock_post_d / 2],
                    [cam_x + (s > 0 ? post_t1 : -post_t0), post_top, cam_z - pin_off + lock_post_d / 2]);
        }
        translate([cam_x, 0, cam_z]) rotate([-90, 0, 0]) {
            // bore the cradle hangs through
            translate([0, 0, y_sb - 1]) cylinder(r = r_bore, h = ring_top - y_sb + 2, $fn = fn_teeth);
            // 45 degree seat for the band's cone
            translate([0, 0, y_seat - seat_w]) cylinder(r1 = r_bore, r2 = r_root, h = seat_w + eps, $fn = fn_teeth);
            // teeth
            translate([0, 0, y_seat]) linear_extrude(spline_h + 1, convexity = 10)
                offset(delta = spline_clearance) spline2d();
        }
        // lock pin hole, pointed at the top
        extrude_x(cam_x - post_t1 - 1, cam_x + post_t1 + 1)
            translate([cam_z - pin_off, pin_yc])
                pointed_circle2d(lock_pin_d / 2 + lock_pin_clearance, (lock_pin_d / 2 + lock_pin_clearance) * sqrt(2));
        // collar pin hole through the tab
        translate([cam_x, y_sb - 1, z_jpin]) rotate([-90, 0, 0])
            cylinder(d = joint_pin_d + 2 * joint_clearance, h = tab_t + 2);
    }
}

// ---------- camera cradle (its own frame: pivot on the y axis, base at y = 0) ----------
// The camera's outline seen from the front, as [z, y]: a pill with round
// ends, bottom at yb
module pill2d(w, h, yb) {
    hull() {
        translate([0, yb + w / 2]) circle(d = w);
        translate([0, yb + h - w / 2]) circle(d = w);
    }
}

// The cradle's walls in plan, as [x, z]
module sleeve_plan2d() {
    offset(r = sl_r) square([pin_x + 2 * cw - 2 * sl_r, pin_z + 2 * cw - 2 * sl_r], center = true);
}

// 2D [x, z] shape extruded upward from y0 to y1, in the cradle's frame
module ext_up(y0, y1) translate([0, y0, 0]) rotate([-90, 0, 0]) linear_extrude(y1 - y0, convexity = 10) children();

module camera_cradle_local() {
    difference() {
        union() {
            // walls, up to the top of the band
            ext_up(0, band_top) sleeve_plan2d();
            // rib outside the front wall, over the lens groove
            // (as wide as the window, so no sliver is left beside it), its
            // underside at 45 degrees
            rx0 = -pin_x / 2 - cw;
            rd = cam_lens_proud + 0.3;
            extrude_z(-win_r - cw, win_r + cw)
                polygon([[rx0 + eps, lens_y - rd], [rx0 - rd, lens_y], [rx0 - rd, band_top], [rx0 + eps, band_top]]);
            // band: a 45 degree cone up from the walls to the teeth
            intersection() {
                hull() {
                    ext_up(collar_y - eps, collar_y) circle(r_root, $fn = fn_teeth);
                    ext_up(collar_y - dcone, collar_y - dcone + eps) sleeve_plan2d();
                }
                translate([0, collar_y - dcone, 0]) rotate([-90, 0, 0])
                    cylinder(r1 = r_root - dcone, r2 = r_root, h = dcone, $fn = fn_teeth);
            }
            // teeth, their bottoms cut back on the same 45 degree cone
            intersection() {
                ext_up(collar_y - eps, band_top) spline2d();
                translate([0, collar_y - eps, 0]) rotate([-90, 0, 0])
                    cylinder(r1 = r_root - 0.5, r2 = r_root - 0.5 + spline_h + eps, h = spline_h + eps, $fn = fn_teeth);
            }
            // spine up the back, for the magnet
            box([pin_x / 2 - eps, 0, -sp_wd / 2], [x_sp1, sp_top, sp_wd / 2]);
            // detents for the cap, either side of its cable slot: small 45
            // degree bumps on the spine's back, reaching cap_detent into
            // the cap's back wall
            dh = cap_clearance + cap_detent;
            for (sz = [-1, 1]) extrude_z(sz * det_z - 1.5, sz * det_z + 1.5)
                polygon([[x_sp1 - eps, det_y - dh], [x_sp1 + dh, det_y], [x_sp1 - eps, det_y + dh]]);
        }
        // pocket: the camera's outline, round at the bottom, open at the
        // top, its corners in plan rounded like the camera's, so the
        // walls are cw thick there too
        intersection() {
            extrude_x(-pin_x / 2, pin_x / 2) {
                offset(delta = cam_clearance) pill2d(cam_w, cam_h, cb);
                translate([-pin_z / 2, cb + cam_w / 2]) square([pin_z, cam_h + 50]);
            }
            ext_up(-1, cam_top + 50) offset(r = sl_r - cw)
                square([pin_x - 2 * (sl_r - cw), pin_z - 2 * (sl_r - cw)], center = true);
        }
        // lens window in the front wall, pointed at the top
        extrude_x(-pin_x / 2 - cw - cam_lens_proud - 1, -pin_x / 2 + eps)
            translate([0, lens_y]) pointed_circle2d(win_r, win_r * sqrt(2));
        // groove the proud lens bezel slides down as the camera goes in
        box([-pin_x / 2 - cam_lens_proud - 0.3, lens_y, -cam_lens_d / 2 - 0.5],
            [-pin_x / 2 + eps, band_top + 1, cam_lens_d / 2 + 0.5]);
        // channel for the camera's bump, and the magnet slot behind it,
        // both open at the top of the spine
        box([pin_x / 2 - eps, y_mag - cam_bump_d / 2 - cam_clearance, -cam_bump_d / 2 - cam_clearance],
            [pin_x / 2 + cam_bump + cam_clearance, sp_top + 1, cam_bump_d / 2 + cam_clearance]);
        box([xm0, y_mag - cam_magnet_d / 2 - 0.2, -cam_magnet_d / 2 - 0.2],
            [xm0 + mag_stack + 0.3, sp_top + 1, cam_magnet_d / 2 + 0.2]);
        // drain holes along the bottom of the pocket
        for (sx = [-1, 0, 1])
            translate([sx * (pin_x / 2 - 4), -1, 0])
                rotate([-90, 0, 0]) cylinder(d = 3, h = cb + 2, $fn = 12);
    }
}

// The camera, for reference, in the cradle's frame
module camera_local() {
    hull() {
        extrude_x(x_cf + cam_edge_r, x_cb - cam_edge_r) pill2d(cam_w, cam_h, cb);
        extrude_x(x_cf, x_cb) offset(delta = -cam_edge_r) pill2d(cam_w, cam_h, cb);
    }
    translate([x_cb - eps, y_mag, 0]) rotate([0, 90, 0]) cylinder(d = cam_bump_d, h = cam_bump);
    translate([x_cf, lens_y, 0]) rotate([0, -90, 0]) cylinder(d = cam_lens_d, h = cam_lens_proud);
    translate([x_cf, cam_top - cam_button_from_top, 0])
        rotate([0, -90, 0]) cylinder(d = cam_button_d, h = cam_button_out);
}

// The magnet and a USB-C plug, for reference
module magnet_local() translate([xm0 + 0.15, y_mag, 0]) rotate([0, 90, 0]) cylinder(d = cam_magnet_d, h = mag_stack);
module usb_plug_local() translate([cap_x_usb - 3.5, cam_top, -6]) cube([7, usb_space - usb_plug_w / 2 - 2, 12]);

// ---------- camera cap (cradle frame, mounted orientation) ----------
// Inside, below cap_open, as [z, y]: round over the camera's shoulders
module cap_inner2d() {
    intersection() {
        union() {
            translate([0, cap_yc]) pointed_circle2d(cap_r, cap_r * sqrt(2));
            translate([-cap_r, cap_y0 - 1]) square([2 * cap_r, cap_yc - cap_y0 + 1]);
        }
        translate([-cap_r - 1, cap_y0 - 2]) square([2 * cap_r + 2, cap_open - cap_y0 + 2]);
    }
}

// The roof's hip, its eaves at ye: 45 degree slopes up from the
// footprint's edges to the ridge, and the footprint carried down `below`
module cap_hip(ye, below) {
    m = min(cap_X1 - cap_X0, 2 * cap_Z) / 2;
    hull() {
        box([cap_X0, ye - below, -cap_Z], [cap_X1, ye, cap_Z]);
        box([cap_X0 + m - eps, ye + m - eps, -cap_Z + m - eps], [cap_X1 - m + eps, ye + m, cap_Z - m + eps]);
    }
}

// Drawn where it rests: settled onto the camera's shoulders
module camera_cap_local() translate([0, -cap_sink, 0]) {
    difference() {
        union() {
            // walls, up into the roof
            intersection() {
                box([cap_xf, cap_y0, -cap_hz], [cap_xb, cap_ye + 100, cap_hz]);
                cap_hip(cap_ye, 200);
            }
            // roof shell, its eaves cut back at 45 degrees underneath
            intersection() {
                difference() {
                    cap_hip(cap_ye, 200);
                    cap_hip(cap_ye - cap_c, 200);
                }
                hull() {
                    box([cap_X0 + cap_c, cap_ye - cap_c, -cap_Z + cap_c], [cap_X1 - cap_c, cap_ye - cap_c + eps, cap_Z - cap_c]);
                    box([cap_X0 - 60, cap_ye + 60, -cap_Z - 60], [cap_X1 + 60, cap_ye + 60 + eps, cap_Z + 60]);
                }
            }
        }
        // inside: the seat over the shoulders, open above it into the roof
        extrude_x(cap_xf + capw, cap_xb - capw) cap_inner2d();
        intersection() {
            box([cap_xf + capw, cap_open - eps, -cap_r], [cap_xb - capw, cap_ye + 100, cap_r]);
            cap_hip(cap_ye - cap_c, 200);
        }
        // notch in the front for the camera's button
        bt = cam_top - cam_button_from_top + cam_button_d / 2 + 1;
        bw = cam_button_d / 2 + 1;
        extrude_x(cap_xf - 1, cap_xf + capw + 1)
            polygon([[-bw, cap_y0 - 1], [bw, cap_y0 - 1], [bw, bt], [0, bt + bw], [-bw, bt]]);
        // cable slot out through the back wall, under the eave, open at
        // the bottom, over the middle of the spine
        cs = (cable_d + 0.6) / 2;
        extrude_x(cap_xb - capw - 1, cap_xb + 1)
            polygon([[-cs, cap_y0 - 1], [cs, cap_y0 - 1], [cs, cap_ct], [0, cap_ct + cs], [-cs, cap_ct]]);
        // windows in the back for the detents on the spine
        for (sz = [-1, 1]) extrude_x(cap_xb - capw - 1, cap_xb + 1)
            translate([sz * det_z, det_y + cap_sink]) polygon([[-2.5, 0], [0, -2.5], [2.5, 0], [0, 2.5]]);
    }
}

module cradle_pose() translate([cam_x, cam_y0, cam_z]) rotate([0, cam_yaw, 0]) children();

// ---------- lock pin (print orientation: flat, along X) ----------
// Round with a flat along its underside, and a head with a pointed top
module d_pin(d, len) {
    zc = d / 4;                              // the flat leaves no face steeper than 60 degrees
    intersection() {
        translate([0, 0, zc]) rotate([0, 90, 0]) cylinder(d = d, h = len);
        translate([0, -d, 0]) cube([len, 2 * d, d]);
    }
    hw = d / 2 + 2;
    translate([-3, 0, 0]) rotate([90, 0, 90]) linear_extrude(3, convexity = 10)
        polygon([[-hw, 0], [hw, 0], [hw, d + 1], [0, d + 1 + hw], [-hw, d + 1]]);
}
module cam_pin() d_pin(lock_pin_d, pin_len);

// ---------- camera mount lock bar (print orientation, flat) ----------
// As on the antenna clamp. x = 0 is the stop head's inner face, which sits
// on the top of the plate; the barbs catch its bottom face.
module cam_lock_bar2d() {
    w = cbar_w;
    difference() {
        union() {
            translate([-cbar_head, -w / 2 - 2]) square([cbar_head, w + 4]);
            translate([0, -w / 2]) square([cbar_len, w]);
            for (s = [-1, 1])
                polygon([[cbar_len, s * (w / 2 + cbar_barb)], [cbar_len + cbar_ramp, s * w / 2],
                         [cbar_len + cbar_ramp, 0], [cbar_len, 0]]);
        }
        // slit that lets the prongs flex inward, with a round relief at its root
        translate([cbar_len + cbar_ramp - cbar_snap_len, -cbar_slit / 2]) square([cbar_snap_len + 1, cbar_slit]);
        translate([cbar_len + cbar_ramp - cbar_snap_len, 0]) circle(d = cbar_slit);
    }
}
module cam_lock_bar() linear_extrude(cbar_t, convexity = 10) cam_lock_bar2d();

// The lock bar in place, head on top of the plate
module cam_lock_bar_mounted()
    translate([(cbar_x0 + cbar_x1) / 2, y_pt, floor_t + cbar_clearance]) rotate([0, 0, -90]) cam_lock_bar();
module collar_pin() d_pin(joint_pin_d, jpin_len);

// The collar pin in place, head up, through the fork and tab
module collar_pin_mounted() translate([cam_x, y_a1, z_jpin - joint_pin_d / 4]) rotate([0, 0, -90]) collar_pin();

// The pin in place, through the posts
module cam_pin_mounted() {
    // flat side up, so its round side lies just over the band
    translate([cam_x - pin_len / 2, pin_yc + lock_pin_d / 4, cam_z - pin_off])
        rotate([90, 0, 0]) cam_pin();
}

// ---------- upper mount (mounted orientation, +X side) ----------
// Bracket profile in the roof frame, as [u, v]: the top is the frame's
// underside, the bottom is parallel to it, and the front rises at 45
// degrees (in print) to the front of the pad. Cut at the glass face below.
module um_profile2d() {
    u_back = u_at_z(-20, 0);
    polygon([[u_back, -um_h], [u_be, -um_h], [u_pad1, -pad_t], [u_pad1, 0], [u_back, 0]]);
}

module upper_mount() {
    difference() {
        union() {
            intersection() {
                frame_tf() union() {
                    extrude_x(pcx - um_w / 2, pcx + um_w / 2) um_profile2d();
                    // crossbar along the bottom, carrying the feet
                    translate([pcx - um_feet_x - foot_t, -um_h, u_at_z(-20, -um_h)])
                        cube([2 * (um_feet_x + foot_t), foot_h, u_at_z(bar_t, -um_h) - u_at_z(-20, -um_h)]);
                }
                union() {
                    // in front of the glass face...
                    box([-500, -500, 0], [500, 500, 500]);
                    // ...except the feet, which reach to the glass
                    for (s = [0, 1]) translate([pcx, 0, 0]) mirror([s, 0, 0])
                        box([um_feet_x, -500, glass_z + foot_gap], [um_feet_x + foot_t, 500, 1]);
                }
            }
            // locating pins for the frame
            frame_tf() for (u = pins_u)
                translate([pcx, -1, u]) rotate([-90, 0, 0]) cylinder(d = pin_d, h = frame_t + 0.6);
        }
        translate([pcx, y_c4, 0]) cup_slot(y_ob - y_c4);
        // bolt hole, straight through from the bottom
        frame_tf() translate([pcx, -um_h - 1, u_s]) rotate([-90, 0, 0]) cylinder(d = 6.9, h = um_h + 2);
    }
}

// ---------- solar frame (roof frame coordinates, +X side) ----------
module panel2d(grow = 0) {
    offset(delta = grow)
        rounded_rect2d([pcx - sp_w / 2, pu0], [pcx + sp_w / 2, pu0 + sp_d], sp_corner_r);
}

module jbox2d() {
    rounded_rect2d([pcx - jbox_w / 2, pu0 + jbox_near], [pcx + jbox_w / 2, pu0 + jbox_near + jbox_l], jbox_r);
}

module solar_frame_local() {
    difference() {
        union() {
            // plate: open under the panel except a band round the junction
            // box and ribs out to the rim
            ext_v(0, frame_t) {
                difference() {
                    translate([fx0, 0]) square([frame_w, fL]);
                    panel2d(-ledge_w);
                }
                offset(r = 6) jbox2d();
                translate([pcx - 8, 0]) square([16, fL]);
                translate([fx0, u_s - 8]) square([frame_w, 16]);
            }
            // ledges under the panel's edges
            ext_v(frame_t - eps, v_ledge) difference() {
                panel2d(sp_clearance + rim_t);
                panel2d(-ledge_w);
            }
            // rim wall round the panel
            ext_v(frame_t - eps, v_wall) difference() {
                panel2d(sp_clearance + rim_t);
                panel2d(sp_clearance);
            }
        }
        // notch in the back rim for the cable
        translate([pcx - cable_notch / 2, frame_t, -1]) cube([cable_notch, 50, pu0 + ledge_w + 1]);
        // bolt hole and locating pin holes
        translate([pcx, -1, u_s]) rotate([-90, 0, 0]) cylinder(d = 7, h = frame_t + 2);
        for (u = pins_u)
            translate([pcx, -1, u]) rotate([-90, 0, 0]) cylinder(d = pin_d + 0.6, h = frame_t + 2);
    }
}

// The panel, for reference, in the roof frame
module solar_panel_local() {
    ext_v(v_ledge, v_ledge + sp_edge_t) panel2d();
    ext_v(frame_t, v_ledge + 0.1) jbox2d();
}

// ---------- output ----------
// Camera mount on its side (its -X face on the bed); collar flat
module camera_mount_print() translate([0, 0, -cm_x0]) rotate([0, -90, 0]) camera_mount();
module camera_collar_print() translate([0, 0, -y_sb]) rotate([90, 0, 0]) camera_collar();
module camera_cradle_print() rotate([90, 0, 0]) camera_cradle_local();
module camera_cap_print() translate([0, 0, -(cap_y0 - cap_sink)]) rotate([90, 0, 0]) camera_cap_local();
module upper_mount_print()
    translate([0, 0, um_h]) rotate([90, 0, 0])
        rotate([-roof_pitch, 0, 0]) translate([0, -Y0, -roof_back_z]) upper_mount();
module solar_frame_print() rotate([90, 0, 0]) solar_frame_local();

if (buddy_output && part == "mounted") {
    color("silver") mount();
    translate([0, -tray_drop, 0]) {
        tray();
        color("lightblue", 0.6)
            translate([0, pg_y0, pg_z0 + panel_clearance]) panel();
        color("orange") lock_keys();
        color("peru") perch();
    }
    mirror([mside, 0, 0]) {
        color("tan") camera_mount();
        color("tan") camera_collar();
        color("orange") collar_pin_mounted();
        color("orange") cam_lock_bar_mounted();
        color("peru") cradle_pose() camera_cradle_local();
        color("peru") cradle_pose() camera_cap_local();
        %cradle_pose() { camera_local(); usb_plug_local(); }
        color("orange") cam_pin_mounted();
        color("tan") upper_mount();
        color("sienna", 0.8) frame_tf() solar_frame_local();
        %frame_tf() solar_panel_local();
        // suction cups, for reference
        for (y = [cm_cup_top, cm_cup_bot])
            %translate([cam_x, y, glass_z]) cylinder(d1 = cup_d, d2 = 20, h = cup_standoff);
        %translate([pcx, y_c4, glass_z]) cylinder(d1 = cup_d, d2 = 20, h = cup_standoff);
    }
    for (s = [-1, 1])
        %translate([s * cup_x, 0, glass_z]) cylinder(d1 = cup_d, d2 = 20, h = cup_standoff);
} else if (buddy_output && part == "all") {
    // This variant's own parts in print orientation, side by side. The
    // feeder's parts are the modular file's "all". Only the camera mount
    // changes with buddy_side; it's centred first, so either side fits.
    mirror([mside, 0, 0]) translate([29.4, -10, 0]) camera_mount_print();
    translate([-60, -97.5, 0]) solar_frame_print();
    translate([85, 50, 0]) camera_cradle_print();
    translate([79, -40, 0]) camera_cap_print();
    translate([38, 144, 0]) camera_collar_print();
    translate([145, -10, 0]) upper_mount_print();
    translate([-30, 110, 0]) cam_lock_bar();
    translate([-30, 125, 0]) collar_pin();
    translate([0, 125, 0]) cam_pin();
} else if (buddy_output) {
    mirror([mside, 0, 0]) {
        if (part == "camera_mount") camera_mount_print();
        if (part == "camera_collar") camera_collar_print();
        if (part == "camera_cradle") camera_cradle_print();
        if (part == "camera_cap") camera_cap_print();
        if (part == "upper_mount") upper_mount_print();
        if (part == "solar_frame") solar_frame_print();
    }
    if (part == "cam_pin") cam_pin();
    if (part == "collar_pin") collar_pin();
    if (part == "cam_lock_bar") cam_lock_bar();
    if (part == "mount") mount_print();
    if (part == "tray") tray_print();
    if (part == "panel") panel();
    if (part == "lock") lock_print();
    if (part == "perch") perch_print();
}
