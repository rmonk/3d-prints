// Suction Cup Antenna Clamp
// -------------------------------------------------------------
// A bar that holds two mushroom-head suction cups (so the clamp
// can't rotate on the glass) with a hook-cap clamp in the middle
// for a round rod such as an antenna mast.
//
// Both suction cup heads slide into T-slots from the front face of
// the bar. A separate printed lock bar then slides lengthwise
// through a channel just in front of both heads and snaps in place,
// so the heads can't slide back out (in any direction, including
// when the bar is twisted). Squeeze the snap prongs to remove it.
//
// The rod drops into a saddle from above, so it can be fitted at a
// narrow section of an antenna whose ends are larger. To fit the
// cap: lower it straight down over the rod, offset a few mm toward
// the bolt side, then slide it across so its tongue goes into the
// slot under the post's lip. A single vertical bolt on the other
// side then locks it in place and pulls it tight into a captive nut.
//
// Designed to print with no supports:
//  - the body prints on its front face and the cap prints on its
//    side. Both are a single profile extruded along the rod, so
//    they sit flat on the bed and the layer lines run through the
//    bar/clamp joint, the post and the cap (not across them)
//  - the cup slots are vertical channels with 45 degree pointed
//    ends; bolt holes are teardrops; the lock channel ceiling is a
//    short bridge; the nut slot opens upward
//  - the lock bar prints flat, so its snap prongs flex along the
//    layers
// Set part = "mounted" to view the assembly as it sits on the glass.
// The suction cup sizes are shared with the other mounts in
// suction_cup.scad. All dimensions in mm.

include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "all"; // [all, body, cap, lock, mounted]

/* [Rod / Antenna] */
// Diameter of the round object being clamped
rod_d = 8;
// Extra clearance added to the saddle and cap
rod_clearance = 0.2;
// Minimum length of rod gripped (the bar is widened to match if needed)
clamp_length = 20;
// Material under the rod
clamp_wall = 3;
// Gap left between cap and body at the bolt, closed up when tightened
clamp_gap = 1.5;
// Thickness of the cap around the rod
cap_wall = 3;
// Thickness of the cap ear the bolt passes through
cap_ear_t = 5;
// Size of the 45 degree chamfer where the clamp meets the bar
block_fillet = 4;

/* [Hook] */
// How far the cap tongue reaches into the post
hook_depth = 3;
// Thickness of the cap tongue
hook_t = 3;
// Material above the slot (takes the tongue's upward pull)
hook_lip = 3;
// Material outside the slot
post_wall = 3;
// Side clearance between cap and post
hook_clearance = 0.4;

/* [Bolt and Nut] */
// Bolt clearance hole diameter (M3 = 3.4)
bolt_hole_d = 3.4;
// Nut size across the flats (M3 = 5.5)
nut_af = 5.5;
// Nut thickness (M3 = 2.4)
nut_thickness = 2.4;
// Bolt head diameter (M3 socket cap = 5.5)
bolt_head_d = 5.5;
// Clearance for nut slot
nut_clearance = 0.3;

/* [Suction Cups] */
// Gap between the two cups (cup sizes are in suction_cup.scad)
cup_gap = 3;

/* [Lock Bar] */
// Width of the lock bar (front to back)
lock_w = 6;
// Clearance between lock bar and its channel (per side)
lock_clearance = 0.3;
// Wall in front of the lock channel
front_wall = 2;
// Length of the stop head on the lock bar
lock_head_len = 4;
// How far each snap barb sticks out
snap_barb = 0.6;
// Length of the split snap prongs
snap_len = 14;
// Width of the slit between the snap prongs
snap_slit = 1.6;

/* [Base Bar] */
// Material above the head pocket
roof_thickness = 2.5;
// Material around the slots
bar_wall = 3;
// Rounding of the bar's top corners
bar_corner_r = 2;

/* [Hidden] */
$fn = 64;

// ---------- derived values ----------
bar_t        = floor_t + pocket_h + roof_thickness;

cup_spacing  = cup_d + cup_gap;                // centre-to-centre
bar_len      = cup_spacing + 2 * head_r + 2 * bar_wall;

// Lock channel sits directly in front of the heads, at head-pocket height
chan_w       = lock_w + 2 * lock_clearance;
chan_back    = -head_r;
chan_front   = chan_back - chan_w;
lock_t       = pocket_h - 2 * lock_clearance;

// Bar spans y_front..y_back (cup centres at y = 0)
y_front      = chan_front - front_wall;
y_back       = max(head_r + tip_extra + bar_wall, y_front + clamp_length);
bar_w        = y_back - y_front;
y_mid        = (y_front + y_back) / 2;

// Clamp (XZ profile; rod runs along Y)
rod_r        = (rod_d + rod_clearance) / 2;
bore_z       = bar_t + clamp_wall + rod_r;      // rod centre height
z_split      = bore_z - clamp_gap / 2;          // top of the body's saddle/ear
z_cap        = bore_z + clamp_gap / 2;          // underside of the cap
cap_r        = rod_r + cap_wall;                // outside of the cap arch
// The cap goes on by sliding toward -X by cap_slide; its inside is
// lengthened on the left by the same amount so it clears the rod.
cap_slide    = hook_depth + 0.5;
post_in      = cap_r + cap_slide + hook_clearance;  // post inner face is at x = -post_in
slot_x       = post_in + hook_depth + 0.5;      // slot bottom is at x = -slot_x
post_out     = slot_x + post_wall;
slot_z0      = z_cap - 0.3;
slot_z1      = z_cap + hook_t + 0.3;
post_top     = slot_z1 + hook_lip;

nut_ac       = (nut_af + 2 * nut_clearance) / cos(30);
bolt_x       = cap_r + bolt_hole_d / 2 + 1;
ear_x        = bolt_x + max(nut_ac, bolt_head_d) / 2 + 2;
cap_top      = z_cap + cap_ear_t;
nut_z        = bar_t + 0.5;                     // bottom of the nut slot

// Lock bar: body runs the full channel, barbs catch the far end face
lock_len     = bar_len + 0.3;
barb_ramp    = 3;

echo(str("Bar: ", bar_len, " x ", bar_w, " x ", bar_t,
         "  Rod centre height: ", bore_z, "  Cap top: ", bore_z + cap_r,
         "  Bolt length: ", ceil(cap_top - nut_z), "-", floor(cap_top - floor_t - 1), " mm",
         "  Lock bar: ", lock_len + lock_head_len + barb_ramp, " x ", lock_w, " x ", lock_t));

// ---------- helpers ----------
// Extrude an XZ profile (2D x -> X, 2D y -> Z) from y0 to y1
module extrude_y(y0, y1) {
    translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0, convexity = 10) children();
}

// Vertical (Z) hole whose teardrop point faces +Y (up when printed)
module hole_z(d, z0, z1) {
    translate([0, 0, z0])
        linear_extrude(z1 - z0, convexity = 10) pointed_circle2d(d / 2, d / 2 * sqrt(2));
}

// ---------- profiles (XZ) ----------
module bar2d() {
    // rounded top corners, small rounding on the glass side
    hull()
        for (s = [-1, 1]) {
            translate([s * (bar_len / 2 - bar_corner_r), bar_t - bar_corner_r])
                circle(bar_corner_r);
            translate([s * (bar_len / 2 - 1), 1]) circle(1);
        }
}

// Saddle, hook post (-X) and bolt ear (+X) on top of the bar
module clamp_body2d() {
    difference() {
        union() {
            // saddle block and bolt ear
            translate([-post_out, bar_t - eps])
                square([post_out + ear_x, z_split - bar_t + eps]);
            // hook post with rounded top
            hull() {
                translate([-post_out, bar_t - eps]) square([post_out - post_in, 1]);
                translate([-post_out + 1.5, post_top - 1.5]) circle(1.5);
                translate([-post_in - 1.5, post_top - 1.5]) circle(1.5);
            }
            // 45 degree chamfers into the bar
            polygon([[-post_out - block_fillet, bar_t - eps],
                     [ ear_x + block_fillet, bar_t - eps],
                     [ ear_x, bar_t + block_fillet],
                     [-post_out, bar_t + block_fillet]]);
        }
        // rod saddle
        translate([0, bore_z]) circle(rod_r);
        // slot for the cap tongue, open toward the rod
        translate([-slot_x, slot_z0]) square([slot_x - post_in + 1, slot_z1 - slot_z0]);
    }
}

// Cap: arch over the rod, tongue into the post, ear for the bolt.
// The arch and its cavity are stretched toward -X by cap_slide so the
// cap can be lowered offset toward +X and then slid home.
module cap2d() {
    difference() {
        union() {
            // arch
            intersection() {
                hull()
                    for (x = [0, -cap_slide])
                        translate([x, bore_z]) circle(cap_r);
                translate([-cap_r - cap_slide, z_cap])
                    square([2 * cap_r + cap_slide, cap_r]);
            }
            // bolt ear with rounded outer corner
            hull() {
                translate([0, z_cap]) square([ear_x - 1.5, cap_ear_t]);
                translate([ear_x - 1.5, z_cap + 1.5]) circle(1.5);
                translate([ear_x - 1.5, cap_top - 1.5]) circle(1.5);
            }
            // tongue with a rounded tip
            hull() {
                translate([-cap_r - cap_slide + 1.5, z_cap]) square([eps, hook_t]);
                translate([-(post_in + hook_depth) + hook_t / 2, z_cap + hook_t / 2])
                    circle(d = hook_t);
            }
        }
        // rod cavity
        hull()
            for (x = [0, -cap_slide])
                translate([x, bore_z]) circle(rod_r);
    }
}

// ---------- body (mounted orientation) ----------
module body() {
    difference() {
        union() {
            extrude_y(y_front, y_back) bar2d();
            extrude_y(y_front, y_back) clamp_body2d();
        }
        // cup slots, both open to the front
        for (s = [-1, 1])
            translate([s * cup_spacing / 2, 0, 0]) cup_slot(y_front);
        // lock bar channel, full length, at head-pocket height
        translate([-bar_len / 2 - 1, chan_front, floor_t])
            cube([bar_len + 2, chan_w, pocket_h]);
        // bolt hole, down into the bar (stops above the floor)
        translate([bolt_x, y_mid, 0]) hole_z(bolt_hole_d, floor_t + 1, z_split + 1);
        // captive nut slot, open through the back face (top when printed)
        translate([bolt_x, y_mid, nut_z])
            linear_extrude(nut_thickness + nut_clearance, convexity = 10)
                hull()
                    for (y = [0, 2 * bar_w])
                        translate([0, y]) rotate(90) circle(d = nut_ac, $fn = 6);
    }
}

// ---------- cap (mounted orientation) ----------
module cap() {
    difference() {
        extrude_y(y_front, y_back) cap2d();
        translate([bolt_x, y_mid, 0]) hole_z(bolt_hole_d, z_cap - 1, cap_top + 1);
    }
}

// ---------- lock bar (print orientation, flat) ----------
// x = 0 is the inner face of the stop head; it sits against the -X end of the bar
module lock_bar2d() {
    w = lock_w;
    difference() {
        union() {
            // stop head
            translate([-lock_head_len, -w / 2 - 2]) square([lock_head_len, w + 4]);
            // body
            translate([0, -w / 2]) square([lock_len, w]);
            // snap prongs with barbs; catch faces sit just past the far end of the bar
            for (s = [-1, 1])
                polygon([[lock_len, s * (w / 2 + snap_barb)],
                         [lock_len + barb_ramp, s * w / 2],
                         [lock_len + barb_ramp, 0],
                         [lock_len, 0]]);
        }
        // slit that lets the prongs flex inward, with a round relief at its root
        translate([lock_len + barb_ramp - snap_len, -snap_slit / 2])
            square([snap_len + 1, snap_slit]);
        translate([lock_len + barb_ramp - snap_len, 0]) circle(d = snap_slit);
    }
}

module lock_bar() {
    linear_extrude(lock_t, convexity = 10) lock_bar2d();
}

// ---------- output ----------
// Body on its front face, cap on its side, lock bar flat
module body_print() { translate([0, 0, -y_front]) rotate([90, 0, 0]) body(); }
module cap_print()  { translate([0, 0, -y_front]) rotate([90, 0, 0]) cap(); }

if (part == "mounted") {
    body();
    color("orange") cap();
} else {
    if (part == "all" || part == "body")
        body_print();
    if (part == "all" || part == "cap")
        // laid on its side next to the body
        translate([0, bore_z + cap_r + (part == "all" ? 8 : 0), 0]) cap_print();
    if (part == "all" || part == "lock")
        translate([-(lock_len - lock_head_len + barb_ramp) / 2,
                   part == "all" ? 8 + cap_r + cap_ear_t + 8 + lock_w / 2 : 0, 0])
            lock_bar();
}
