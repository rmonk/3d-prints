// Bird Buddy Camera on a Wooden Post
// -------------------------------------------------------------
// The Bird Buddy variant's camera (suction_cup_bird_feeder_buddy.scad)
// screwed to a wooden post or board instead of a window, with its solar
// panel carried by the camera's cap on a ball joint. The collar, collar
// pin, cradle and lock pin are the variant's parts, unchanged; the camera
// mount, its lock bar, the cap, the upper mount and the frame are
// replaced by:
//
//  - post_mount: the camera mount's arm, fork and gussets on a plate that
//    four pan head wood screws hold to the wood. Its collar, pin and
//    cradle fit exactly as on the window.
//  - post_cap: the camera's cap, thicker (cap_wall_lines 6), without eaves
//    (the panel keeps the rain off) and reaching
//    down over the solid part of the cradle's spine, where two M3 screws
//    through its back wall hold it to the spine. A threaded boss on its
//    roof holds the ball joint's socket.
//  - ball: the ball joint's ball. It sits in the boss's socket.
//  - stem: the stem and the plate that bears on the panel's junction box.
//    Its end plugs into a keyed pocket in the ball, and a steel flat head
//    bolt up through the ball and the stem into the panel's 1/4"-20 socket
//    clamps all three together. It's a separate part so it can print on
//    its side, with its layers along the panel's bending.
//  - ball_ring: a knurled ring that screws down over the boss and clamps
//    the ball, so the panel can be tilted (up to wp_max_tilt toward the
//    stem's keel, further the other ways) and turned to any heading, then
//    locked by hand.
//
// The cradle turns in the collar as on the window, and here it can face
// any way, in cam_yaw_step steps: nothing on the post mount reaches it.
// The ball joint turns the panel independently, so it can face the sun
// whichever way the camera looks.
//
// Fitting: screw the post mount to the wood, arm level. Slide the collar's
// tab into the fork and drop the collar pin in. Put the magnets and the
// camera in the cradle, plug in the cable, push the cap down over the
// camera's top (the cable slot is open at the bottom) and drive the two
// M3 screws through the cap into the spine. The first time, drill 2.5 mm
// pilot holes about wp_cap_screw_len deep into the spine through the
// cap's holes. Lower the cradle into the collar at the angle you want and
// push the lock pin through the posts. Slip the ring over the stem, plug
// the stem into the ball's pocket and bolt both to the panel through the
// ball. Set the ball in the boss's socket and screw the ring down until it holds the
// panel where you want it.
//
// Designed to print with no supports, each part turned so its main loads
// run along the layers:
//  - post_mount: on its side, like the camera mount, so its side profile
//    (plate, arm, gussets, fork) lies in every layer. The screw holes and
//    the fork's pin hole have pointed tops
//  - post_cap: upright, open bottom on the bed, like the window cap. The
//    boss's thread has 45 degree flanks, its socket is a bowl, and the
//    screw and drain holes have pointed tops
//  - ball: upright, as mounted, on the flat under the ball, which is cut
//    where the ball's underside reaches 45 degrees (a cone there would
//    stick out of the ball's sphere and bind in the socket when tilted).
//    The bolt's countersink is 49 degrees from horizontal. The ball only
//    takes bearing loads: the ring, the bowl and the stem in its pocket
//  - stem: on its side, so its layers run along it and the panel's bending
//    pulls them along their length, not apart. Its cross-section is a
//    teardrop cut flat wp_keel below its axis (the keel, on the bed),
//    which also keys it in the ball's pocket. The bolt hole has a pointed
//    top and the flare to the plate is 45 degrees
//  - ball_ring: upside down, its top on the bed, so the face that grips
//    the ball faces up
// Set part = "mounted" to view the assembly on the post.
// All dimensions in mm.

include <suction_cup_bird_feeder_buddy.scad>
include <../../library/BOSL2/std.scad>
include <../../library/BOSL2/threading.scad>

/* [Output] */
// Which part to render
// (print the collar, collar pin, cradle and lock pin from the Bird Buddy
// variant's STLs)
part = "mounted"; // [all, mounted, post_mount, post_cap, ball, stem, ball_ring]
// Camera angle shown in the mounted view: 0 looks along the wood, 90
// straight out from it
cam_yaw = 90;

/* [Post Mount] */
// Reach: the cradle's pivot from the wood (105 on the window). At 130 the
// panel clears the wood at any tilt the ball allows, either way, with its
// cable edge anywhere within 90 degrees of facing the wood.
cam_z = 130;
// Plate thickness, against the wood
wp_t = 8;
// Width of the plate and arm (across the arm; at least the collar's tab)
wp_w = 36;
// Gussets from the plate to the arm (45 degrees)
wp_gusset = 30;
// Wood screws: clearance hole, pan head diameter, distance of each screw
// either side of the arm's centre line
wp_screw_d = 4.5;
wp_screw_head = 9;
wp_screw_x = 9;
// Plate beyond the screws
wp_plate_end = 8;

/* [Cap] */
// The cap reaches down over the solid part of the cradle's spine (it ends
// just above the collar's lock pin posts) with thicker walls
cap_down = 48.5;
cap_wall_lines = 6;
// No eaves: the panel keeps the rain off, so the walls run straight up
// into the 45 degree roof, which leaves no overhang round the cap
cap_eave = 0;
// M3 screws through the cap's back wall into the spine: clearance hole,
// length (pan head, under the head), height down from the camera's top
wp_cap_screw_d = 3.4;
wp_cap_screw_len = 10;
wp_cap_screw_down = 42;

/* [Ball Joint] */
// Ball diameter
wp_ball_d = 36;
// Stem diameter, from the ball up to the flare
wp_stem_d = 13;
// The stem prints on its side: its teardrop cross-section is cut flat this
// far below its axis, on the bed. That keel is on the panel's cable-edge
// side.
wp_keel = 8;
// How far into the ball the stem's end goes (the pocket's floor, above the
// ball's centre), and the clearance round it in the pocket
wp_pocket_floor = 3;
wp_pocket_clearance = 0.15;
// Plate that bears on the panel's junction box (it passes through the ring)
wp_plate_d = 30;
wp_plate_t = 4;
// Steel bolt into the panel's socket: 1/4"-20 x 2-1/2" flat head (82
// degree countersink), its head diameter, and the clearance hole
wp_bolt_len = 63.5;
wp_bolt_head_d = 12.7;
wp_bolt_hole_d = 6.6;
// Thickness of the cap's roof under the ball's socket
wp_bowl_floor = 3;
// Clearance round the ball in its socket
wp_bowl_clearance = 0.15;
// Thread on the boss and in the ring: diameter, pitch, length, and slop
wp_thread_d = 46;
wp_thread_pitch = 2.5;
wp_thread_l = 14;
wp_thread_slop = 0.2;
// Ring: outside diameter, and the highest latitude on the ball it grips to
// (sets its opening)
wp_ring_d = 56;
wp_ring_lat = 28;
// Gap between the ring's lip and the ball as modelled: the ring screws
// this much further down to clamp it
wp_ring_clearance = 0.1;

/* [Panel Pose] */
// Panel tilt (the low edge's way is set by the heading) and heading in the
// mounted view. Heading 0 has the cable edge toward the wood and the low
// edge away from it.
wp_panel_tilt = 15;
wp_panel_heading = 0;

/* [Hidden] */
buddy_output = false;

// ---------- derived values ----------
// Model coordinates are the Bird Buddy variant's: x along the wood, y up,
// z out from the wood, which is at z = 0. The cradle's pivot is at x =
// cam_x, z = cam_z, as on the window.

// Post mount: a side profile [z, y] extruded across x, as the camera mount
wp_x0     = cam_x - wp_w / 2;
wp_x1     = cam_x + wp_w / 2;
wp_sy1    = y_a1 + wp_gusset + wp_screw_head / 2 + 1;     // screw rows, clear of the gussets
wp_sy0    = y_a0 - wp_gusset - wp_screw_head / 2 - 1;     // for the screwdriver
wp_y1     = wp_sy1 + wp_plate_end;
wp_y0     = wp_sy0 - wp_plate_end;
assert(wp_w >= cm_w, "wp_w must be at least the collar's tab");
assert(wp_screw_x + wp_screw_d / 2 < wp_w / 2 - 2, "the screws must be inside the plate");

// Cap, in the cradle's frame. The hip's apex, outside and in.
wp_hip     = min(cap_X1 - cap_X0, 2 * cap_Z) / 2;
wp_apex    = cap_ye + wp_hip - cap_sink;
wp_bx      = (cap_X0 + cap_X1) / 2;                       // ball centre over the roof's centre
wp_r       = wp_ball_d / 2;
wp_by      = wp_apex - cap_c + wp_bowl_floor + wp_r + wp_bowl_clearance;   // ball centre
wp_boss_top = wp_by - 0.5;                                // just below the ball's equator
wp_tdepth  = 0.4 * wp_thread_pitch;
wp_boss_r  = wp_thread_d / 2 - wp_tdepth;                 // the thread's root
wp_cs_y    = cam_top - wp_cap_screw_down;
wp_post_top = post_top - cam_y0;                          // collar's lock pin posts, in the cradle's frame
assert(cap_y0 - cap_sink >= wp_post_top + 0.5, "the cap must stay above the collar's lock pin posts: lower cap_down");
assert(wp_cs_y - wp_cap_screw_d / 2 > cap_y0 - cap_sink + 3, "the cap's screws must be above its bottom edge");
assert(wp_cs_y + wp_cap_screw_d / 2 < y_mag - cam_bump_d / 2 - cam_clearance - 2,
       "the cap's screws must be in the solid spine, below the bump channel");
assert(det_z + wp_cap_screw_d / 2 < sp_wd / 2 - 2, "the cap's screws must be on the spine");
assert(cap_xb - wp_cap_screw_len > pin_x / 2 + 2, "the cap's screws are too long for the spine");
assert(max(abs(cap_X0 - wp_bx), cap_Z) > wp_ring_d / 2, "the ring must be over the roof");

// Ball stud, in its own frame: the ball's centre at the origin, +z toward
// the panel (up when untilted)
wp_lat_top = wp_ring_lat;
wp_open_r  = wp_r * cos(wp_lat_top);                      // ring opening
wp_ring_top = wp_r * sin(wp_lat_top);
wp_ring_l0 = wp_boss_top - wp_by + 1.5;                   // underside of the ring's lip
wp_ring_b  = wp_ring_l0 - wp_thread_l;                    // ring's bottom
wp_ball_bot = -wp_r / sqrt(2);                           // the flat under the ball, at 45 degrees
wp_cs_h    = (wp_bolt_head_d / 2 + 0.2 - wp_bolt_hole_d / 2) / tan(41);   // countersink depth
wp_head_top = wp_ball_bot + 0.3;                          // the bolt head, just inside the flat
wp_plate_top = wp_head_top + wp_bolt_len - socket_engage;
wp_flare1  = wp_plate_top - wp_plate_t;                   // the flare's top, under the plate
wp_flare0  = wp_flare1 - (wp_plate_d - wp_stem_d) / 2;
// The keel's edge, its farthest reach from the stem's axis
wp_keel_r  = norm([wp_stem_d / 2 * sqrt(2) - wp_keel, wp_keel]);
// Steepest tilt before the stem meets the ring's opening (0.5 mm clear):
// toward the keel, and the other ways
wp_max_tilt = acos((wp_keel_r + 0.5) / wp_r) - wp_lat_top;
wp_max_tilt_round = acos((wp_stem_d / 2 + 0.5) / wp_r) - wp_lat_top;
assert(wp_keel > wp_stem_d / 2 + 0.5 && wp_keel < wp_stem_d / 2 * sqrt(2) - 0.5,
       "wp_keel must cut the stem's teardrop below the round, leaving a flat on the bed");
assert(wp_plate_d / 2 < wp_open_r - 0.5, "the stem's plate must pass through the ring");
assert(wp_bolt_head_d / 2 + 0.2 + 0.3 * tan(41) < -wp_ball_bot - 2, "the bolt's head must be inside the flat under the ball");
assert(wp_pocket_floor > wp_ball_bot + wp_cs_h + 3, "the ball's pocket is too deep for the countersink");
assert(wp_flare0 > wp_ring_top + wp_r * sin(wp_max_tilt_round) + 2, "the stem's flare reaches the ring when tilted");
assert(wp_panel_tilt <= wp_max_tilt, "wp_panel_tilt is beyond the ball joint's range");

echo(str("Post mount: plate ", wp_y1 - wp_y0, " tall x ", wp_w, " wide, screw rows ",
         wp_sy1 - wp_sy0, " apart; pivot ", cam_z, " from the wood",
         "  Cap: bottom ", cap_y0 - cap_sink, " above the cradle's base, ball centre ", wp_by,
         "  Ball joint: ", wp_ball_d, " ball, tilts to ", wp_max_tilt, " deg toward the keel, ",
         wp_max_tilt_round, " the other ways, ring ", wp_ring_d,
         " across  Panel bolt: 1/4\"-20 x ", wp_bolt_len, " flat head, ",
         socket_engage, " into the socket"));

// ---------- post mount (mounted orientation; prints on its side) ----------
module wp_mount2d() {
    // plate on the wood
    translate([0, wp_y0]) square([wp_t, wp_y1 - wp_y0]);
    // arm
    translate([wp_t - eps, y_a0]) square([z_fe - wp_t + eps, y_a1 - y_a0]);
    // gussets
    polygon([[wp_t - eps, y_a1 - eps], [wp_t + wp_gusset, y_a1 - eps], [wp_t - eps, y_a1 + wp_gusset]]);
    polygon([[wp_t - eps, y_a0 + eps], [wp_t + wp_gusset, y_a0 + eps], [wp_t - eps, y_a0 - wp_gusset]]);
}

module post_mount() {
    difference() {
        extrude_x(wp_x0, wp_x1) wp_mount2d();
        // fork for the collar's tab, open toward the camera
        box([wp_x0 - 1, y_sb - joint_clearance, z_fe - tab_len - joint_clearance],
            [wp_x1 + 1, y_sb + tab_t + joint_clearance, z_fe + 1]);
        // pin hole through the fork, pointed toward +X (up when printed)
        r = joint_pin_d / 2 + joint_clearance;
        translate([cam_x, y_a0 - 1, z_jpin]) rotate([-90, 0, 0])
            linear_extrude(y_a1 - y_a0 + 2, convexity = 10) rotate(-90) pointed_circle2d(r, r * sqrt(2));
        // wood screws, pointed toward +X
        for (y = [wp_sy0, wp_sy1], s = [-1, 1])
            translate([cam_x + s * wp_screw_x, y, -1])
                linear_extrude(wp_t + 2, convexity = 10) rotate(-90)
                    pointed_circle2d(wp_screw_d / 2, wp_screw_d / 2 * sqrt(2));
    }
}

// ---------- cap with the ball joint's socket (cradle frame) ----------
// The socket's boss: the thread's root up from inside the roof, the thread
// on top. The roof's inside is cut out of it afterwards.
module wp_boss() {
    translate([wp_bx, 0, 0]) rotate([-90, 0, 0]) {
        translate([0, 0, wp_apex - wp_boss_r - 1])
            cylinder(r = wp_boss_r, h = wp_boss_top - wp_thread_l - 1.5 - (wp_apex - wp_boss_r - 1) + eps);
        translate([0, 0, wp_boss_top - wp_thread_l - 1.5])
            trapezoidal_threaded_rod(d = wp_thread_d, l = wp_thread_l + 1.5, pitch = wp_thread_pitch,
                                     thread_angle = 90, thread_depth = wp_tdepth,
                                     bevel1 = wp_tdepth, bevel2 = wp_tdepth, anchor = BOTTOM);
    }
}

module post_cap_local() {
    difference() {
        union() {
            camera_cap_local();
            difference() {
                wp_boss();
                translate([0, -cap_sink, 0]) cap_hip(cap_ye - cap_c, 200);
            }
        }
        translate([wp_bx, wp_by, 0]) {
            // the ball's socket: a bowl up to the boss's top
            sphere(r = wp_r + wp_bowl_clearance);
            // drain from the bottom of the bowl out through the back of
            // the boss, pointed at the top
            translate([0, -wp_r + 0.5, 0]) extrude_x(0, wp_boss_r + 5)
                pointed_circle2d(1.25, 1.25 * sqrt(2));
        }
        // grooves up the back wall's inside, so the spine's detents slide up
        // to their windows freely (the screws hold the cap, not the
        // detents), pointed at the top
        gw = 1.5 + 0.3;
        for (sz = [-1, 1]) extrude_x(cap_xb - capw - eps, cap_xb - capw + cap_detent + 0.3)
            translate([sz * det_z, 0])
                polygon([[-gw, cap_y0 - cap_sink - 1], [gw, cap_y0 - cap_sink - 1], [gw, det_y], [0, det_y + gw], [-gw, det_y]]);
        // M3 screws into the spine, either side of the cable slot, pointed
        // at the top
        for (sz = [-1, 1]) extrude_x(cap_xb - capw - 1, cap_xb + 1)
            translate([sz * det_z, wp_cs_y])
                pointed_circle2d(wp_cap_screw_d / 2, wp_cap_screw_d / 2 * sqrt(2));
    }
}

// ---------- ball and stem (the stud's frame: the ball's centre at the
// origin, +z toward the panel, the cable edge and the keel toward +y) ----------
// The stem's cross-section: a teardrop pointed toward the keel, cut flat
// wp_keel from the axis
module wp_keel2d(r) {
    intersection() {
        pointed_circle2d(r, r * sqrt(2));
        translate([-r - 1, -r - 1]) square([2 * r + 2, r + 1 + wp_keel]);
    }
}

module wp_ball() {
    difference() {
        // cut flat where its underside reaches 45 degrees
        rotate_extrude(convexity = 10) intersection() {
            circle(r = wp_r);
            translate([0, wp_ball_bot]) square([wp_r + 1, 2 * wp_r]);
        }
        // pocket for the stem's end, keyed by its keel
        translate([0, 0, wp_pocket_floor]) linear_extrude(wp_r, convexity = 10)
            offset(delta = wp_pocket_clearance) wp_keel2d(wp_stem_d / 2);
        // bolt hole and the countersink for its head
        translate([0, 0, wp_ball_bot - 1]) cylinder(d = wp_bolt_hole_d, h = wp_pocket_floor - wp_ball_bot + 2);
        // (it starts 0.3 mm below the head's top, which sits just inside the flat)
        translate([0, 0, wp_ball_bot - eps])
            cylinder(r1 = wp_bolt_head_d / 2 + 0.2 + 0.3 * tan(41), r2 = wp_bolt_hole_d / 2, h = wp_cs_h + 0.3 + eps);
    }
}

module wp_stem() {
    difference() {
        union() {
            translate([0, 0, wp_pocket_floor]) linear_extrude(wp_flare0 - wp_pocket_floor + eps, convexity = 10)
                wp_keel2d(wp_stem_d / 2);
            // 45 degree flare out to the plate
            hull() {
                translate([0, 0, wp_flare0]) linear_extrude(eps) wp_keel2d(wp_stem_d / 2);
                translate([0, 0, wp_flare1 - eps]) linear_extrude(eps) wp_keel2d(wp_plate_d / 2);
            }
            translate([0, 0, wp_flare1 - eps]) linear_extrude(wp_plate_t + eps, convexity = 10)
                wp_keel2d(wp_plate_d / 2);
        }
        // bolt hole, pointed away from the keel (up when printed)
        translate([0, 0, wp_pocket_floor - 1]) linear_extrude(wp_plate_top - wp_pocket_floor + 2, convexity = 10)
            rotate(180) pointed_circle2d(wp_bolt_hole_d / 2, wp_bolt_hole_d / 2 * sqrt(2));
    }
}

// Both, as bolted together
module ball_stud() { wp_ball(); wp_stem(); }

// ---------- clamp ring (the stud's frame, untilted) ----------
module ball_ring() {
    knurls = floor(PI * wp_ring_d / 7.5);
    difference() {
        translate([0, 0, wp_ring_b]) cylinder(d = wp_ring_d, h = wp_ring_top - wp_ring_b);
        // scallops round the rim, for grip
        for (i = [0 : knurls - 1])
            rotate(i * 360 / knurls) translate([wp_ring_d / 2 + 1, 0, wp_ring_b - 1])
                cylinder(h = wp_ring_top - wp_ring_b + 2, d = 5);
        // thread onto the boss
        translate([0, 0, wp_ring_b - eps])
            trapezoidal_threaded_rod(d = wp_thread_d, l = wp_ring_l0 - wp_ring_b + eps, pitch = wp_thread_pitch,
                                     thread_angle = 90, thread_depth = wp_tdepth, internal = true,
                                     bevel1 = wp_tdepth, bevel2 = false, $slop = wp_thread_slop, anchor = BOTTOM);
        // the lip grips the ball's upper half (with wp_ring_clearance to go
        // when it's modelled at rest); its opening lets the stem tilt
        sphere(r = wp_r + wp_ring_clearance);
        cylinder(r = wp_open_r, h = wp_ring_top + 1);
    }
}

// ---------- poses ----------
// The ball's centre in the cradle's frame, the stud's frame on it
module wp_ball_frame() translate([wp_bx, wp_by, 0]) rotate([-90, 0, 0]) children();

// The panel, for reference, in the stud's frame: its socket at the
// origin, its box's underside at z = 0, cable edge toward +y
module wp_panel_local() {
    rotate([90, 0, 0]) translate([-pcx, -frame_t, -u_s]) solar_panel_local();
}

// The stud and the panel on it, in model coordinates: the ball joint lets
// them turn independently of the cradle. Heading 0 puts the cable edge
// toward the wood.
module wp_panel_pose(yaw = cam_yaw, tilt = wp_panel_tilt, heading = wp_panel_heading) {
    b = [wp_bx * cos(yaw), wp_by, -wp_bx * sin(yaw)];
    translate([cam_x, cam_y0, cam_z] + b)
        rotate([0, heading, 0]) rotate([-90 + tilt, 0, 0]) children();
}

module wp_cradle_pose(yaw = cam_yaw) translate([cam_x, cam_y0, cam_z]) rotate([0, yaw, 0]) children();

// ---------- output ----------
module post_mount_print() translate([0, 0, -wp_x0]) rotate([0, -90, 0]) post_mount();
module post_cap_print() translate([0, 0, -(cap_y0 - cap_sink)]) rotate([90, 0, 0]) post_cap_local();
module wp_ball_print() translate([0, 0, -wp_ball_bot]) wp_ball();
// on its side, keel down
module wp_stem_print() translate([0, 0, wp_keel]) rotate([-90, 0, 0]) wp_stem();
module ball_ring_print() translate([0, 0, wp_ring_top]) rotate([180, 0, 0]) ball_ring();

module wp_assembly() {
    color("tan") post_mount();
    color("tan") camera_collar();
    color("orange") collar_pin_mounted();
    color("orange") cam_pin_mounted();
    wp_cradle_pose() {
        color("peru") camera_cradle_local();
        color("peru") post_cap_local();
        color("orange") wp_ball_frame() ball_ring();
        %camera_local();
        %usb_plug_local();
    }
    wp_panel_pose() {
        color("orange") ball_stud();
        %translate([0, 0, wp_plate_top]) wp_panel_local();
    }
    // the wood, for reference
    %translate([cam_x - 60, wp_y0 - 40, -20]) cube([120, wp_y1 - wp_y0 + 300, 20]);
}

if (part == "mounted") {
    wp_assembly();
} else if (part == "all") {
    // This file's parts in print orientation, side by side. The collar,
    // pins and cradle come from the variant's "all".
    post_mount_print();
    right(45) post_cap_print();
    translate([45, 55, 0]) wp_ball_print();
    translate([100, -3, 0]) wp_stem_print();
    translate([100, 75, 0]) ball_ring_print();
} else {
    if (part == "post_mount") post_mount_print();
    if (part == "post_cap") post_cap_print();
    if (part == "ball") wp_ball_print();
    if (part == "stem") wp_stem_print();
    if (part == "ball_ring") ball_ring_print();
}
