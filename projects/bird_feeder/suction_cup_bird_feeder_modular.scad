// Modular Suction Cup Bird Feeder
// -------------------------------------------------------------
// A tray for in-shell sunflower seeds that hangs on the outside of a
// window, in four printed parts:
//
//  - mount: a bar that holds two suction cups and stays on the glass.
//    It has a T-slot for each cup on its glass side and a second
//    T-slot for the tray on its front.
//  - tray: the seed tray. Two printed knobs on its back corner posts
//    (the same shape as the cup knobs) drop into the mount's front
//    slots, so the tray lifts off for filling and cleaning while the
//    cups stay on the glass. The floor is perforated so rain drains
//    straight through, and the front wall is lower than the back for
//    the birds.
//  - panel: the tray's back wall, printed in clear filament. It slides
//    down into grooves in the corner posts and a channel in the floor,
//    so the whole width of the tray shows the seed level from indoors.
//  - lock (print one of each hand): two keys that lock the panel in.
//    Each slides in from the outside of the tray, through a corner post,
//    and through a notch in the panel's edge near the top, so the panel
//    can't lift out. A barb on a flexible arm snaps into a pocket in the
//    slot. To remove a key, press the end of the arm in with a small
//    screwdriver and pull the key out.
//  - perch: a rail across the front that slides down onto two
//    dovetails on the front wall.
//  - roof (optional, with two roof brackets, one of each hand): a
//    single-slope roof that sheds rain off the front, past the perch.
//    The brackets slide down into sockets in end blocks on the mount,
//    which the mount always has, so the roof can be added later. The
//    roof stays on the window when the tray is lifted out from under
//    it, and its back edge covers the gap behind the tray. The roof
//    slides up the slope onto rails along the brackets' top edges until
//    its rail channels stop against the rails' front ends; a barb on a
//    flexible arm near the back of each bracket then snaps up into a
//    pocket in the channel. To remove it, press both arms
//    down from below and slide the roof forward. Fit the panel lock
//    keys before the brackets.
//
// Keeping seeds out from behind the tray: seeds used to get stuck
// between the glass and the feeder. The tray hangs about 23 mm off the
// glass, wider than an in-shell seed is long, and nothing in that gap
// has a flat top for a seed to rest on: the mount's top slopes at 45
// degrees down toward the tray, and the two feet that brace the bottom
// of the tray against the glass have peaked tops. Anything that falls
// in drops straight through. The tall clear back wall also stops seeds
// being flicked back into the gap.
//
// Mounting: push each cup knob up into the mount's slots from below,
// then press both cups onto the glass together. Hang the tray by
// lowering its knobs into the slots on the front of the mount. To
// remove it, lift it about 20 mm and pull it away.
//
// Designed to print with no supports:
//  - mount: on its bottom edge. The cup slots are vertical channels
//    with 45 degree pointed tops; the tray slots open upward
//  - tray: upright. The knobs on its corner posts have 45 degree
//    pointed undersides, the drain holes are vertical, and the panel
//    grooves and perch sockets are vertical and open at the top
//  - panel: flat
//  - lock keys: on their flat bottom, with the pointed top up. The latch
//    arms flex sideways, along the layers
//  - perch: upright, as mounted. The rail has a 45 degree chamfer
//    underneath and a rounded top
//  - roof brackets: flat, on their outer faces, so all the bending load
//    runs along the layers. The tongue and rail are half-dovetails, flat
//    on the bed side and 45 degrees on top; the latch arm flexes in the
//    plate, along the layers
//  - roof: upside down, its smooth top on the bed. The ribs, rail
//    channels and drip lip under it rise from the bed with 45 degree faces
// Set part = "mounted" to view the assembly as it sits on the glass.
// The suction cup sizes are shared with the other mounts in
// suction_cup.scad. All dimensions in mm.

include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "all"; // [all, mount, tray, panel, lock, perch, roof, roof_bracket, mounted]

/* [Tray] */
// Overall width
tray_w = 186;
// Overall depth, front to back
tray_d = 76;
// Height at the back (the clear panel)
back_h = 50;
// Height at the front, lower so the birds can reach in
front_h = 35;
// Wall thickness
wall = 2.4;
// Floor thickness
floor_th = 3;
// Width of the corner posts that carry the knobs (side to side)
post_w = 20;
// Depth of the corner posts (front to back)
post_d = 12;

/* [Drainage] */
// Drain hole diameter (smaller than a sunflower seed is thick)
drain_d = 3.5;
// Spacing of the drain holes (hexagonal grid)
drain_pitch = 6.5;

/* [Window Panel] */
// Thickness of the clear panel
panel_t = 2;
// Clearance around the panel in its grooves (per side)
panel_clearance = 0.3;
// How far the panel's edges go into the corner posts
panel_groove = 4;
// Wall on the glass side of the panel grooves
panel_lip = 3;
// Depth of the channel in the floor that holds the panel's bottom
panel_seat = 1.5;
// How far the panel sticks up above the back of the tray, to grip it by
panel_grip = 3;

/* [Panel Lock] */
// Height of the lock keys' straight sides (their tops are pointed)
lock_h = 4;
// Distance from the top of the tray's back down to the keys
lock_drop = 12;
// How far the notches go into the panel's edges
lock_engage = 3.5;
// Clearance around the keys in their slots
lock_clearance = 0.2;
// How far the latch barb sticks out (how firmly the keys snap in)
lock_barb = 0.8;

/* [Roof] */
// Show the roof in the mounted view
show_roof = true;
// Slope of the roof, down toward the front
roof_pitch = 15;
// Height of the roof's front edge (underneath) above the top of the perch
roof_headroom = 150;
// How far the roof reaches past the front of the perch
roof_overhang = 32;
// How far the roof reaches past each bracket
roof_side_overhang = 12;
// Roof thickness
roof_t = 3;
// Gap between the back of the roof and the glass
roof_back_gap = 3;
// Thickness of the roof brackets
bracket_t = 6;
// Gap between the tray's sides and the brackets
bracket_gap = 6;
// Clearance for the bracket tongues and roof rails (per side)
roof_clearance = 0.25;
// How far the roof latch barbs stick up (how firmly the roof snaps on)
roof_barb = 0.8;

/* [Mount] */
// Distance from the glass to the top of a cup, where the knob starts
cup_standoff = 7;
// Material above the cup slots and below the tray slots
roof_thickness = 2.5;
// Wall between the cup pockets and the tray pockets
mid_wall = 3.2;
// Material beyond the outer slots
bar_wall = 3;
// Height of the end blocks that hold the roof bracket sockets
roof_block_top = 40;

/* [Feet] */
// Thickness of the feet that brace the tray against the glass
foot_t = 4;
// Height of the feet
foot_h = 6;

/* [Perch] */
// Distance of each perch arm from the centre
perch_x = 60;
// Distance from the front of the dovetail sockets to the rail centre
perch_reach = 22;
// Size of the perch rail (square, rounded on top)
perch_d = 10;
// How far the top of the rail is below the front of the tray
perch_drop = 8;
// Width of the perch arms
arm_w = 8;
// Clearance in the dovetail sockets (per side)
perch_clearance = 0.25;

/* [Hidden] */
$fn = 64;
// Render the parts below. A file that includes this one sets it to false
// after the include and renders its own.
modular_output = true;

// ---------- derived values ----------
// Model coordinates (mounted orientation): x along the feeder, y up
// with the cup centres at 0, z away from the glass with the top of the
// cups (where the knob neck starts) at 0. The glass is at glass_z.
glass_z    = -cup_standoff;
slot_end   = head_r + tip_extra;                 // centre to pointed end of a cup slot
knob_apex  = head_d / 2 * sqrt(2);               // centre to the point under a tray knob
tray_slot_end = knob_apex + slot_clearance * sqrt(2);

// Mount: cup slots on the glass side, tray slots on the front
bar_t      = 2 * (floor_t + pocket_h) + mid_wall;
bar_bot    = -(max(slot_end, tray_slot_end) + roof_thickness);
bar_front_top = slot_end + roof_thickness;
bar_flat   = 3;                                  // flat top over the tray slot entrances
cup_x      = tray_w / 2 - post_w / 2;            // cups and tray knobs at x = +-cup_x
cup_spacing = 2 * cup_x;
bar_len    = 2 * (cup_x + head_r + bar_wall);

// Tray, hanging with its corner posts against the front of the mount
z0         = bar_t;                              // back of the tray
z1         = bar_t + tray_d;                     // front of the tray
y_rim      = bar_bot - 1;                        // top of the back, just below the mount
y_bot      = y_rim - back_h;
y_front    = y_bot + front_h;
y_floor    = y_bot + floor_th;
ear_top    = head_d / 2 + 2.5;                   // the posts rise to carry the knobs

// Panel grooves
pg_z0      = z0 + panel_lip;
pg_z1      = pg_z0 + panel_t + 2 * panel_clearance;
pg_x       = tray_w / 2 - post_w + panel_groove;
pg_y0      = y_floor - panel_seat;
panel_w    = 2 * (pg_x - panel_clearance);
panel_h    = y_rim + panel_grip - pg_y0;

// Panel lock keys (right-hand key; the left one is its mirror image).
// The key crosses the panel groove and is held in the post on both sides.
kz0        = pg_z0 - 1;
kz1        = pg_z1 + 2.5;
kw         = kz1 - kz0;
ky0        = y_rim - lock_drop;                  // bottom of the keys
key_top    = ky0 + lock_h + kw / 2;              // point of the key's top
kx0        = tray_w / 2 - post_w + 0.7;          // key tip, just inside the post
panel_edge = pg_x - panel_clearance;
arm_t      = 1.6;                                // latch arm
arm_slit   = 1;
arm_len    = 10;
barb_x0    = tray_w / 2 - 5.5;                   // barb ramp starts here
barb_x1    = tray_w / 2 - 2;                     // barb catch face

// Perch dovetails: sockets in bosses on the front wall
boss_w     = 20;
boss_d     = 9;
tongue_dt  = 3;                                  // dovetail depth
tongue_bw  = arm_w + 2 * tongue_dt;              // 45 degree flanks
zf         = z1 + boss_d;                        // front of the bosses
perch_y    = y_front - perch_drop - perch_d;     // bottom of the perch
rail_z     = zf + perch_reach;
rail_len   = 2 * perch_x + 30;

// Roof brackets (right-hand; the left is the mirror image) and sockets
xb0        = tray_w / 2 + bracket_gap;           // bracket inner face
xb1        = xb0 + bracket_t;                    // bracket outer face (on the bed)
hd         = 3;                                  // half-dovetail depth, 45 degrees
blk_x0     = bar_len / 2;                        // mount end blocks
blk_x1     = xb1 + 5;
sock_y0    = bar_bot + 3;                        // socket floor
br_z0      = bar_t;                              // back edge of the brackets
br_tip     = rail_z + perch_d / 2;               // front of the brackets

// Roof: a frame with u down the slope from the back edge and v normal
// to the roof (v = 0 is the top surface)
perch_top  = y_front - perch_drop;
roof_fz    = rail_z + perch_d / 2 + roof_overhang;   // front edge, underneath
roof_fy    = perch_top + roof_headroom;
roof_back_z = glass_z + roof_back_gap;
roof_t0y   = roof_fy + roof_t * cos(roof_pitch);
roof_t0z   = roof_fz + roof_t * sin(roof_pitch);
roof_oy    = roof_t0y - (roof_back_z - roof_t0z) * tan(roof_pitch);
roof_L     = (roof_t0z - roof_back_z) / cos(roof_pitch);
roof_W     = 2 * (xb1 + roof_side_overhang);
barb_h     = hd + roof_clearance + roof_barb;    // latch barb, up into the channel ceiling
rib_h      = hd + 2 * roof_clearance + roof_barb + 0.5;  // ribs under the roof hold the rail channels
rib_wall   = 2.5;
v_edge     = -roof_t - rib_h;                    // the brackets' top edges, in the roof frame
e0y        = roof_oy + v_edge * cos(roof_pitch);
e0z        = roof_back_z + v_edge * sin(roof_pitch);
function edge_y(z) = e0y - (z - e0z) * tan(roof_pitch);
function edge_u(z) = (z - e0z) / cos(roof_pitch);
u_back     = edge_u(br_z0);
u_tip      = edge_u(br_tip);
roof_arm   = 14;                                 // latch arm along each bracket's top
roof_arm_t = 2;
roof_slit  = 1.2;
u_af       = u_back + 2 + roof_arm;              // free end of the arm
u_c        = u_af - barb_h - 1;                  // barb catch face
u_rail0    = u_af + 3;                           // back end of the rail

// Mounted pose: the knobs settle 0.3 mm (clearance) down the 45 degree slot ends
tray_drop  = slot_clearance * sqrt(2);

// ---------- helpers ----------
// Box from corner to corner
module box(p0, p1) { translate(p0) cube(p1 - p0); }

// 2D [z, y] profile extruded along X
module extrude_x(x0, x1) {
    translate([x0, 0, 0]) rotate([90, 0, 90])
        linear_extrude(x1 - x0, convexity = 10) mirror([1, -1]) children();
}

// 2D [x, z] profile extruded along Y
module extrude_y(y0, y1) {
    translate([0, y1, 0]) rotate([90, 0, 0])
        linear_extrude(y1 - y0, convexity = 10) children();
}

// 2D [x, y] profile extruded along Z
module extrude_z(z0, z1) {
    translate([0, 0, z0]) linear_extrude(z1 - z0, convexity = 10) children();
}

// Tray knob outlines. The head is a circle with a 45 degree point
// downward. The neck runs straight down and comes to a point at the same
// depth, so every layer of the knob is joined to the post and sits on
// the one below at no more than 45 degrees.
module knob_head2d() { rotate(180) pointed_circle2d(head_d / 2, knob_apex); }
module knob_neck2d() {
    rn = neck_d / 2;
    circle(rn);
    polygon([[-rn, 0], [rn, 0], [rn, rn - knob_apex], [0, -knob_apex], [-rn, rn - knob_apex]]);
}

// The roof frame: local x across, y = v (normal to the roof), z = u (down
// the slope from the back edge)
module roof_frame() translate([0, roof_oy, roof_back_z]) rotate([roof_pitch, 0, 0]) children();

// The same frame with y measured up from the brackets' top edges
module edge_frame() roof_frame() translate([0, v_edge, 0]) children();

// Half-dovetail on the right-hand bracket, as (x, height): flat on the
// outer face, 45 degrees inward on top
module half_dove2d() {
    polygon([[xb0, -0.5], [xb1, -0.5], [xb1, hd], [xb0 - hd, hd], [xb0, 0]]);
}

// ---------- mount (mounted orientation) ----------
module bar2d() {
    // the top slopes down toward the tray at 45 degrees
    polygon([[0, bar_bot], [bar_t, bar_bot], [bar_t, bar_front_top],
             [bar_t - bar_flat, bar_front_top], [0, bar_front_top + bar_t - bar_flat]]);
}

// T-slot for a tray knob in the front face, open upward: the knob
// outlines grown by the clearance and run up through the top
module tray_slot(x) {
    translate([x, 0, bar_t - floor_t - eps])
        linear_extrude(floor_t + 2 * eps, convexity = 10)
            offset(delta = slot_clearance) {
                knob_neck2d();
                translate([-neck_d / 2, 0]) square([neck_d, 50]);
            }
    translate([x, 0, bar_t - floor_t - pocket_h])
        linear_extrude(pocket_h, convexity = 10)
            offset(delta = slot_clearance) {
                knob_head2d();
                translate([-head_d / 2, 0]) square([head_d, 50]);
            }
}

// Bracket tongue, seen from above (x, z): a half-dovetail along the
// bracket's back edge
module roof_tongue2d() {
    polygon([[xb0, br_z0 + 0.5], [xb1, br_z0 + 0.5], [xb1, br_z0 - hd],
             [xb0 - hd, br_z0 - hd], [xb0, br_z0]]);
}

module mount() {
    difference() {
        union() {
            extrude_x(-bar_len / 2, bar_len / 2) bar2d();
            // end blocks for the roof bracket sockets (same 2D bottom edge
            // as the bar, so the two are flush on the bed)
            for (s = [0, 1]) mirror([s, 0, 0])
                extrude_x(blk_x0 - 0.5, blk_x1)
                    polygon([[0, bar_bot], [bar_t, bar_bot], [bar_t, roof_block_top], [0, roof_block_top]]);
        }
        for (s = [-1, 1]) {
            translate([s * cup_x, 0, 0]) cup_slot(bar_bot);
            tray_slot(s * cup_x);
        }
        // roof bracket sockets, open at the top
        for (s = [0, 1]) mirror([s, 0, 0])
            extrude_y(sock_y0, roof_block_top + 1)
                offset(delta = roof_clearance) {
                    roof_tongue2d();
                    translate([xb0, br_z0 - 0.01]) square([bracket_t, 2]);
                }
    }
}

// ---------- tray (mounted orientation, knobs centred at y = 0) ----------
module tray_side2d() {
    polygon([[z0, y_bot], [z1, y_bot], [z1, y_front], [z0 + post_d, y_rim], [z0, y_rim]]);
}

module floor2d() {
    hx  = tray_w / 2 - wall - drain_d / 2 - 1.5;
    hz0 = pg_z1 + drain_d / 2 + 1.5;
    hz1 = z1 - wall - drain_d / 2 - 1.5;
    dz  = drain_pitch * sqrt(3) / 2;
    difference() {
        translate([-tray_w / 2, z0]) square([tray_w, tray_d]);
        // hexagonal grid over the floor
        for (i = [0 : floor((hz1 - hz0) / dz)]) {
            z = hz0 + i * dz;
            for (x = [-hx + (i % 2) * drain_pitch / 2 : drain_pitch : hx])
                if (!(abs(x) > tray_w / 2 - post_w - drain_d / 2 - 1
                      && z < z0 + post_d + drain_d / 2 + 1))
                    translate([x, z]) circle(d = drain_d, $fn = 12);
        }
        // a row along the panel channel, so water can't collect there
        for (x = [-pg_x + 6 : 10 : pg_x - 6])
            translate([x, (pg_z0 + pg_z1) / 2]) circle(d = drain_d, $fn = 12);
    }
}

// Dovetail tongue on a perch arm, seen from above
module tongue2d(x) {
    polygon([[x - arm_w / 2, zf], [x + arm_w / 2, zf],
             [x + tongue_bw / 2, zf - tongue_dt], [x - tongue_bw / 2, zf - tongue_dt]]);
}

// Foot with a peaked top, reaching from the tray back to the glass.
// Built in 3D (a 2D outline would be rounded slightly off the bed).
module foot(x) {
    hull() {
        box([x - foot_t / 2, y_bot, glass_z], [x + foot_t / 2, y_bot + foot_h - foot_t / 2, z0 + 1]);
        box([x - 0.01, y_bot, glass_z], [x + 0.01, y_bot + foot_h, z0 + 1]);
    }
}

module tray() {
    difference() {
        union() {
            extrude_y(y_bot, y_floor) floor2d();
            for (s = [-1, 1]) {
                // side wall
                extrude_x(s > 0 ? tray_w / 2 - wall : -tray_w / 2,
                          s > 0 ? tray_w / 2 : -tray_w / 2 + wall) tray_side2d();
                // corner post, rising above the back to carry the knob
                box([s > 0 ? tray_w / 2 - post_w : -tray_w / 2, y_bot, z0],
                    [s > 0 ? tray_w / 2 : -tray_w / 2 + post_w, ear_top, z0 + post_d]);
                // knob: neck through the mount's front wall, head in its pocket
                translate([s * cup_x, 0, bar_t - neck_height])
                    linear_extrude(neck_height + 0.5, convexity = 10) knob_neck2d();
                translate([s * cup_x, 0, bar_t - knob_height])
                    linear_extrude(head_height, convexity = 10) knob_head2d();
                // foot against the glass
                foot(s * cup_x);
                // perch socket boss
                box([s * perch_x - boss_w / 2, y_bot, z1 - 0.5],
                    [s * perch_x + boss_w / 2, y_front, zf]);
            }
            // front wall
            box([-tray_w / 2, y_bot, z1 - wall], [tray_w / 2, y_front, z1]);
        }
        // panel grooves in the posts, open at the top, and the channel in the floor
        box([-pg_x, pg_y0, pg_z0], [pg_x, ear_top + 1, pg_z1]);
        // panel lock key slots
        for (s = [0, 1]) mirror([s, 0, 0]) lock_slot();
        // perch dovetail sockets, open at the top
        for (s = [-1, 1])
            extrude_y(perch_y, y_front + 1)
                offset(delta = perch_clearance) {
                    tongue2d(s * perch_x);
                    translate([s * perch_x - arm_w / 2, zf - 0.01]) square([arm_w, 2]);
                }
    }
}

// ---------- panel (print orientation, flat) ----------
// Notches in both edges for the lock keys
module panel() {
    difference() {
        translate([-panel_w / 2, 0, 0]) cube([panel_w, panel_h, panel_t]);
        for (s = [-1, 1])
            translate([s * (panel_edge - lock_engage / 2 + 0.5) - (lock_engage + 1) / 2,
                       ky0 - lock_clearance - pg_y0, -1])
                cube([lock_engage + 1, key_top - ky0 + 2 * lock_clearance, panel_t + 2]);
    }
}

// ---------- panel lock (mounted orientation, right-hand key) ----------
// Key outline across the slot: flat bottom, 45 degree pointed top.
// Drawn with its bottom at y = 0 and moved up by ky0, so the 2D outline
// lands exactly on the bed when the key is printed.
module key2d() {
    polygon([[kz0, 0], [kz1, 0], [kz1, lock_h], [(kz0 + kz1) / 2, key_top - ky0],
             [kz0, lock_h]]);
}

module lock_key_local() {
    difference() {
        union() {
            extrude_x(kx0, tray_w / 2) key2d();
            // barb on the latch arm: a ramp toward the tip, a square catch face outward
            extrude_y(0, lock_h)
                polygon([[barb_x0, kz1 - 0.01], [barb_x1, kz1 - 0.01], [barb_x1, kz1 + lock_barb]]);
        }
        // slit that frees the latch arm, open at the outer end
        box([tray_w / 2 - arm_len, -1, kz1 - arm_t - arm_slit],
            [tray_w / 2 + 1, key_top - ky0 + 1, kz1 - arm_t]);
    }
}

module lock_key() { translate([0, ky0, 0]) lock_key_local(); }

// Slot through the side wall and post for the right-hand key, with a
// pocket that the barb snaps into. It stops short of the post's inner
// face, so the key's outer parts bottom out there.
module lock_slot() translate([0, ky0, 0]) {
    extrude_x(kx0 - lock_clearance, tray_w / 2 + 1)
        offset(delta = lock_clearance) key2d();
    extrude_x(barb_x0 - 0.3, barb_x1 + lock_clearance)
        offset(delta = lock_clearance)
            hull() {
                key2d();
                translate([lock_barb + lock_clearance, 0]) key2d();
            }
}

module lock_keys() {
    lock_key();
    mirror([1, 0, 0]) lock_key();
}

// ---------- perch (mounted orientation, bottom at y = 0) ----------
module rail2d() {
    r = 3;      // rounding on top
    c = 1.5;    // 45 degree chamfer underneath
    zl = rail_z - perch_d / 2;
    zr = rail_z + perch_d / 2;
    yt = perch_d;
    polygon(concat(
        [[zl + c, 0], [zr - c, 0], [zr, c]],
        [for (a = [0 : 15 : 90]) [zr - r + r * cos(a), yt - r + r * sin(a)]],
        [for (a = [90 : 15 : 180]) [zl + r + r * cos(a), yt - r + r * sin(a)]],
        [[zl, c]]));
}

// Built with its bottom at y = 0, so the 2D rail outline lands exactly
// on the bed, then moved into place
module perch_local() {
    extrude_x(-rail_len / 2, rail_len / 2) rail2d();
    for (s = [-1, 1]) {
        extrude_y(0, y_front - perch_y) tongue2d(s * perch_x);
        box([s * perch_x - arm_w / 2, 0, zf - 0.5], [s * perch_x + arm_w / 2, perch_d, rail_z]);
    }
}

module perch() { translate([0, perch_y, 0]) perch_local(); }

// ---------- roof bracket (mounted orientation, right-hand) ----------
module roof_bracket() {
    difference() {
        union() {
            // side plate, its top edge on the roof line
            intersection() {
                extrude_x(xb0, xb1)
                    polygon([[br_z0, sock_y0], [br_tip, edge_y(br_tip) - 12],
                             [br_tip, edge_y(br_tip) + 50], [br_z0, edge_y(br_z0) + 50]]);
                edge_frame() translate([-500, -500, -500]) cube([1000, 500, 1000]);
            }
            // tongue that slides down into the mount socket
            extrude_y(sock_y0, roof_block_top) roof_tongue2d();
            edge_frame() {
                // rail the roof slides onto
                translate([0, 0, u_rail0])
                    linear_extrude(u_tip - 1 - u_rail0, convexity = 10) half_dove2d();
                // latch barb on the arm: square catch face toward the back,
                // 45 degree ramp toward the front
                extrude_x(xb0, xb1)
                    polygon([[u_c, -0.01], [u_c + barb_h, -0.01], [u_c, barb_h]]);
            }
        }
        // free the latch arm: a slit under it and a slot at its front end
        edge_frame() {
            box([xb0 - 1, -roof_arm_t - roof_slit, u_back + 2], [xb1 + 1, -roof_arm_t, u_af]);
            box([xb0 - 1, -roof_arm_t - roof_slit, u_af], [xb1 + 1, 1, u_af + roof_slit]);
        }
    }
}

module roof_brackets() {
    roof_bracket();
    mirror([1, 0, 0]) roof_bracket();
}

// ---------- roof (in the roof frame) ----------
module roof_local() {
    difference() {
        union() {
            box([-roof_W / 2, -roof_t, 0], [roof_W / 2, 0, roof_L]);
            // drip lip along the front edge
            extrude_x(-roof_W / 2, roof_W / 2)
                polygon([[roof_L - 6.5, -roof_t + 0.5], [roof_L, -roof_t + 0.5], [roof_L, -roof_t - 6]]);
            // ribs over the brackets
            for (s = [0, 1]) mirror([s, 0, 0])
                box([xb0 - hd - roof_clearance - rib_wall, v_edge, u_back - 2],
                    [xb1 + roof_clearance + rib_wall, -roof_t + 0.5, u_tip + 2]);
        }
        for (s = [0, 1]) mirror([s, 0, 0]) translate([0, v_edge, 0]) {
            // rail channel, open at the back and underneath. Its closed
            // front end stops the rail when the roof is slid fully back
            translate([0, 0, u_back - 3])
                linear_extrude(u_tip - 1 + roof_clearance - (u_back - 3), convexity = 10)
                    offset(delta = roof_clearance) {
                        half_dove2d();
                        translate([xb0, -2]) square([bracket_t, 2.5]);
                    }
            // pocket in the channel ceiling that the latch barb snaps into
            box([xb0 - roof_clearance, hd, u_c - roof_clearance],
                [xb1 + roof_clearance, hd + 2 * roof_clearance + roof_barb, u_c + barb_h + roof_clearance]);
        }
    }
}

module roof() { roof_frame() roof_local(); }

// ---------- output ----------
// Mount on its bottom edge; tray and perch upright, as mounted
module mount_print() { translate([0, 0, -bar_bot]) rotate([90, 0, 0]) mount(); }
module tray_print()  { translate([0, 0, -y_bot]) rotate([90, 0, 0]) tray(); }
module perch_print() { rotate([90, 0, 0]) perch_local(); }
// Roof upside down; brackets flat on their outer faces, one of each hand
module roof_print() { rotate([-90, 0, 0]) roof_local(); }
module roof_bracket_print() {
    translate([0, 0, xb1]) rotate([0, 90, 0]) roof_bracket();
    // the left-hand one end to end with it, tongues 5 mm apart, so the
    // pair fits a 250 mm bed
    translate([2 * (br_z0 - hd) - 5, 0, xb1]) rotate([0, -90, 0]) mirror([1, 0, 0]) roof_bracket();
}
// Keys on their flat bottoms, side by side
module lock_print() {
    for (s = [0, 1])
        translate([0, s * 12, 0]) rotate([90, 0, 0])
            translate([0, 0, -kz0]) mirror([s, 0, 0]) translate([-(kx0 + tray_w / 2) / 2, 0, 0]) lock_key_local();
}

if (modular_output) {
    if (part == "mounted") {
        color("silver") mount();
        translate([0, -tray_drop, 0]) {
            tray();
            color("lightblue", 0.6)
                translate([0, pg_y0, pg_z0 + panel_clearance]) panel();
            color("orange") lock_keys();
            color("peru") perch();
        }
        if (show_roof) {
            color("tan") roof_brackets();
            color("sienna", 0.8) roof();
        }
        // suction cups, for reference
        for (s = [-1, 1])
            %translate([s * cup_x, 0, glass_z]) cylinder(d1 = cup_d, d2 = 20, h = cup_standoff);
    } else {
        if (part == "all" || part == "mount")
            translate([0, part == "all" ? 30 : 0, 0]) mount_print();
        if (part == "all" || part == "tray")
            tray_print();
        if (part == "all" || part == "perch")
            translate([0, part == "all" ? -20 : 0, 0]) perch_print();
        if (part == "all" || part == "lock")
            translate([part == "all" ? tray_w / 2 + 20 : 0, part == "all" ? -40 : 0, 0]) lock_print();
        if (part == "all" || part == "roof")
            translate([0, part == "all" ? 150 : 0, 0]) roof_print();
        if (part == "all" || part == "roof_bracket")
            translate([part == "all" ? -tray_w / 2 - 160 : 0, 0, 0]) roof_bracket_print();
        if (part == "all" || part == "panel")
            translate([0, part == "all" ? -(rail_z + perch_d + 40) - panel_h : 0, 0]) panel();
    }
}
