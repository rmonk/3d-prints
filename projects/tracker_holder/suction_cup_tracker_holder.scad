// Suction Cup Tracker Holder
// -------------------------------------------------------------
// Holds a Heltec Wireless Tracker in the "Heltec Tracker LoRa Meshtastic
// Enclosure V3" from Printables (model 1204874, 50.8 x 82.55 x 27.94 mm)
// upright on a window, on one suction cup, with the LoRa antenna pointing
// up and the display facing into the room.
//
// Mounting: the cup's T-slot opens through the bottom edge, so the holder
// hangs on the knob and its weight keeps the knob at the closed end of the
// slot. Slide the cup in from below and push the knob right up. Then
// slide the lock bar in sideways through the channel across the slot, just
// under the knob's head, until its barbs snap past the far side, and press
// the cup onto the glass. With the bar in, a knock from below can't lift
// the holder off the knob. Squeeze the barbed prongs together to pull the
// bar out. Two feet at the bottom corners reach almost to the glass, so
// pressing the buttons or a knock can't rock the holder on its cup. The
// cup (61 mm) is wider than the holder, so the feet sit on outriggers just
// past its rim, clear of it as it slides in from below.
//
// Case: the holder is a channel that hugs the case's rounded long edges,
// with lips wrapping over the front edges. Stand the case on its USB end,
// antenna end up, and slide it down into the channel from the top until it
// rests on the two ledges at the bottom. The middle of the bottom is open
// for the USB-C plug. The antenna, power switch and the top of the case
// stick out above the holder; lift the case by its top to take it out.
// The lips stop short of the buttons and the display.
//
// Shim (part = "shim", printed in TPU): a thin sheet with four leaning fins
// that lines the back of the channel and presses the case forward against
// the lips, so it doesn't rattle in a car. The fins bend rather than
// squash, so the grip is gentle. The channel is shim_space deeper
// than the case needs to make room for it, so don't use the holder without
// it. Slide the shim down into the channel, fins facing out, until it
// stands on the ledges; two diamond studs on the back of the channel ride
// up their 45 degree ramps and snap into the holes near its bottom, and it
// is a little wider than the gap between the lips, so it stays put when
// the case is lifted out. To remove it, lift its bottom edge off the studs
// through the gap at the bottom and slide it up.
//
// Printing: on its bottom edge, without supports. The whole cross-section
// (back, walls and lips) then lies in each layer, so the case pushing on
// the lips and the cup pulling on the slot load the layers along their
// length. Walls are a whole number of extrusion lines (see [Printing]).
// The lock bar prints flat, so its prongs flex along the layers. The shim
// prints flat, its plain back on the bed.
//
// Set part = "mounted" to view it on the glass with the case in place. The
// suction cup sizes are shared with the other mounts in suction_cup.scad.
// Uses BOSL2 from library/. All dimensions in mm.

include <../../library/BOSL2/std.scad>
include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "holder"; // [holder, lock, shim, mounted]

/* [Case] */
// Width of the case (its short side)
case_w = 50.8;
// Length of the case, from the USB end to the antenna end
case_h = 82.55;
// Thickness of the case, back to display
case_t = 27.94;
// Radius of the rounded edges along the front and back
case_edge_r = 6.35;
// Corner radius seen from the front
case_corner_r = 3.2;
// Antenna socket, across from the case centre (+ is right, seen from the room)
antenna_x = 12.07;

/* [Printing] */
// Extrusion line width set in the slicer
line_w = 0.45;
// Layer height set in the slicer
layer_h = 0.28;

/* [Holder] */
// Clearance all round the case
clearance = 0.5;
// Thickness of the back, walls and lips, in lines
wall_lines = 4;
// How far the lips reach in from the sides of the case, over its front
lip = 7.5;
// Height of the ledges under the case
ledge_t = 3;
// Width of the open middle of the bottom, for the USB-C plug
usb_gap = 24;
// How much of the case sticks out above the holder
top_open = 15;
// Wall each side of the cup head pocket, in lines
block_lines = 6;
// Lead-in round the top of the channel
lead_in = 1.5;

/* [Feet] */
// Distance from the glass to the top of a stuck-down cup
cup_standoff = 7;
// Gap between the feet and the glass, so the cup can be pressed flat
foot_gap = 0.5;
// Gap between the feet and the cup's rim
foot_clearance = 1;
// Width of each foot's pad on the glass
foot_w = 4;
// Height of the feet, up from the holder's bottom edge
foot_len = 10;

/* [Shim] */
// Extra depth behind the case for the TPU shim
shim_space = 2.5;
// How far the case presses the shim's fins down (sets how firmly it's held)
shim_preload = 0.5;
// Thickness of the shim's sheet
shim_base = 1;
// Where the fins join the sheet, out from the centre (mirrored); they lean
// outward at 45 degrees
shim_fins = [4, 13];
// Fin thickness, measured across the fin
fin_t = 0.9;
// Length of the slope at the top end of each fin, a lead-in for the case
fin_lead = 4;
// Clearance between the shim's edges and the channel's rounded corners
shim_side_clearance = 0.5;
// Studs that hold the shim: across from the centre
stud_x = 7;
// Stud size (corner to corner of the diamond)
stud_w = 5;
// How far the studs stand off the back of the channel
stud_h = 1;
// Stud centres, up from the case's bottom
stud_up = 10;
// Clearance round the studs in the shim's holes
stud_clearance = 0.2;

/* [Lock Bar] */
// Clearance between the lock bar and its channel, per side
lock_clearance = 0.3;
// Width of each snap prong, in lines
prong_lines = 6;
// Width of the slit between the snap prongs
snap_slit = 1.6;
// Length of the slit, from the prong tips
snap_len = 12;
// How far each barb sticks out
snap_barb = 0.6;
// Length of the stop head on the lock bar
lock_head_len = 4;

/* [Hidden] */
$fn = 64;

// ---------- derived values ----------
// Thickness of n extrusion lines side by side. Slicers in the PrusaSlicer
// family (also Orca and Bambu Studio) overlap neighbouring lines, spacing
// them line_w - layer_h * (1 - pi / 4) apart.
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));
wall_t    = lines(wall_lines);
spine_wall = lines(block_lines);
plate_t   = floor_t + pocket_h + wall_t;          // the back is the pocket roof
sheet_z0  = plate_t - wall_t;                     // back face of the back
spine_hw  = head_r + spine_wall;                  // narrow cup block, round the slot
cav_hw    = case_w / 2 + clearance;               // channel, a uniform offset of the case
cav_t     = case_t + 2 * clearance + shim_space;  // deeper at the back, for the shim
cav_r     = case_edge_r + clearance;
cav_zc    = plate_t + cav_t / 2;
case_zc   = plate_t + cav_t - case_t / 2;         // case centre, pressed against the lips
out_hw    = cav_hw + wall_t;
lip_x0    = case_w / 2 - lip;                     // inner edge of the lips
case_y0   = -case_h / 2;                          // case's bottom; its centre is over the cup
yb        = case_y0 - ledge_t;                    // bottom edge (the slot opens here)
yt        = case_y0 + case_h - top_open;          // top edge
block_end = head_r + tip_extra + spine_wall;      // cup block, past the cup centre
block_hw  = cav_hw - cav_r;                       // cup block spans the flat of the back
// Lock bar: crosses the slot just under the seated head, at head-pocket height
lock_w    = 2 * lines(prong_lines) + snap_slit;
chan_w    = lock_w + 2 * lock_clearance;
chan_y1   = -head_r;                              // channel top, under the head
chan_y0   = chan_y1 - chan_w;
lock_t    = pocket_h - 2 * lock_clearance;
lock_len  = 2 * block_hw + 0.3;                   // body; the barbs catch the far face
barb_ramp = 3;
band_y0   = chan_y0 - spine_wall;                 // full-width band round the channel
band_y1   = chan_y1 + spine_wall;
glass_z   = -cup_standoff;
foot_z    = glass_z + foot_gap;
foot_x0   = cup_d / 2 + foot_clearance;           // feet, outside the cup's rim
foot_x1   = foot_x0 + foot_w;
foot_root = block_hw - 3;                         // where the foot meets the back
// Shim: fills the gap behind the case, plus the preload
shim_t    = cav_t - case_t + shim_preload;        // overall, fins uncompressed
shim_hw   = block_hw - shim_side_clearance;       // on the flat of the back
shim_y0   = case_y0;                              // stands on the ledges
shim_y1   = yt - lead_in - 1;
stud_y    = case_y0 + stud_up;
fin_y0    = stud_y + stud_w / 2 + 2;              // fins stop above the studs
fin_rise  = shim_t - shim_base;

assert(lip_x0 < cav_hw - cav_r, "lip must reach past the case's rounded edge");
assert(lock_len + barb_ramp - snap_len > block_hw + head_r + 1,
       "snap prongs would reach over the slot; shorten snap_len");
assert(yb + foot_len < chan_y0 - lock_w / 2 - 2, "feet would reach the lock bar");
assert(shim_hw > lip_x0, "shim must be wider than the gap between the lips");
assert(stud_h < shim_t - shim_preload, "studs would reach the case");
assert(max(shim_fins) + fin_rise + fin_t * sqrt(2) < shim_hw, "outer fin overhangs the shim's edge");
assert(stud_w / 2 > stud_h, "stud too small for its ramp");
assert(usb_gap / 2 < case_w / 2 - case_corner_r - 3, "usb_gap leaves no ledge");

// ---------- helpers ----------
// Extrude a 2D XZ profile along Y from y0 to y1
module extrude_y(y0, y1) {
    back(y1) xrot(90) linear_extrude(y1 - y0, convexity = 10) children();
}

// Extrude a 2D outline drawn as [-z, y] along X from x0 to x1
module extrude_x(x0, x1) {
    right(x0) yrot(90) linear_extrude(x1 - x0, convexity = 10) children();
}

// Diamond (45 degree sides), w corner to corner, centred on the origin
module diamond2d(w) {
    rotate(45) square(w / sqrt(2), center = true);
}

// ---------- holder ----------
// Channel cross-section (XZ): the case's outline offset by the clearance
module cavity2d(grow = 0) {
    translate([0, cav_zc]) rect([2 * (cav_hw + grow), cav_t + 2 * grow], rounding = cav_r + grow);
}

// Back, walls and lips (XZ): a shell wall_t thick round the channel, open
// across the front between the lips, which have rounded ends
module body2d() {
    lip_zc = cav_zc + cav_t / 2 + wall_t / 2;
    end_x  = lip_x0 + wall_t / 2;
    difference() {
        cavity2d(wall_t);
        cavity2d();
        translate([-end_x, cav_zc]) square([2 * end_x, cav_t]);
    }
    xflip_copy() translate([end_x, lip_zc]) circle(d = wall_t);
}

// Ledges under the case (XZ), either side of the USB gap. They reach into
// the walls, so they don't share the walls' inner faces, but stop at the
// front of the channel.
module ledge2d() {
    intersection() {
        cavity2d(wall_t / 2);
        xflip_copy() {
            translate([usb_gap / 2, 0]) square([out_hw, cav_zc + cav_t / 2]);
            translate([lip_x0 + wall_t, 0]) square([out_hw, cav_zc + cav_t]);
        }
    }
}

// Foot (XZ, right side): a strut from the back and the side wall out past
// the cup's rim and down to foot_gap short of the glass. Its inner edge
// stays outside the cup's outline, so the cup slides in under it.
module foot2d() {
    difference() {
        polygon([[foot_root, sheet_z0], [foot_x0, foot_z], [foot_x1, foot_z],
                 [out_hw - wall_t / 2, cav_zc - cav_t / 2 + cav_r],
                 [foot_root, cav_zc]]);
        cavity2d();
    }
}

// Cup block behind the back, from the bottom edge to past the cup, round
// the slot. Round the lock bar channel it widens to the flat of the back,
// so the bar's prongs are clear of the slot; below the channel it widens
// at 45 degrees, so in print it grows out of the narrow block.
module cup_block() {
    block_h = sheet_z0 + 0.5;
    extrude_x(-spine_hw, spine_hw)
        polygon([[0, yb], [0, block_end], [-block_h, block_end], [-block_h, yb]]);
    taper = block_hw - spine_hw;
    linear_extrude(block_h, convexity = 10)
        polygon([[-spine_hw, band_y0 - taper], [spine_hw, band_y0 - taper],
                 [block_hw, band_y0], [block_hw, band_y1],
                 [-block_hw, band_y1], [-block_hw, band_y0]]);
}

// Studs on the back of the channel that hold the shim. Diamonds, so they
// print sideways; the top half is cut back at 45 degrees from the back, a
// ramp the shim's bottom edge rides up as it slides down.
module studs() {
    y_top = stud_y + stud_w / 2;
    xflip_copy() intersection() {
        translate([stud_x, stud_y, plate_t - 0.5])
            linear_extrude(stud_h + 0.5, convexity = 10) diamond2d(stud_w);
        extrude_x(stud_x - stud_w, stud_x + stud_w)
            polygon([[-(plate_t - 0.5), stud_y - stud_w], [-(plate_t + stud_h), stud_y - stud_w],
                     [-(plate_t + stud_h), y_top - stud_h], [-(plate_t - 0.5), y_top + 0.5]]);
    }
}

// 45 degree lead-in round the inside of the channel's top
module top_lead_in() {
    hull() {
        extrude_y(yt - lead_in - eps, yt - lead_in) cavity2d();
        extrude_y(yt, yt + eps) cavity2d(lead_in);
    }
}

module holder() {
    difference() {
        union() {
            extrude_y(yb, yt) body2d();
            extrude_y(yb, case_y0) ledge2d();
            cup_block();
            // feet at the bottom corners; they stand on the bed in print
            extrude_y(yb, yb + foot_len) xflip_copy() foot2d();
            studs();
        }
        cup_slot(yb);
        // lock bar channel across the block, at head-pocket height
        translate([-block_hw - 1, chan_y0, floor_t])
            cube([2 * block_hw + 2, chan_w, pocket_h]);
        top_lead_in();
    }
}

// Print orientation: bottom edge on the bed
module holder_print() { translate([0, 0, -yb]) rotate([90, 0, 0]) holder(); }

// ---------- lock bar (print orientation, flat) ----------
// x = 0 is the inner face of the stop head, which sits against the -X side
// of the cup block
module lock_bar2d() {
    w = lock_w;
    difference() {
        union() {
            // stop head
            translate([-lock_head_len, -w / 2 - 2]) square([lock_head_len, w + 4]);
            // body
            translate([0, -w / 2]) square([lock_len, w]);
            // snap prongs with barbs; catch faces sit just past the far side
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

// Lock bar in place in the holder
module lock_bar_mounted() {
    translate([-block_hw, (chan_y0 + chan_y1) / 2, floor_t + lock_clearance]) lock_bar();
}

// ---------- shim (mounted orientation) ----------
// One fin (right side), joining the sheet at x and leaning outward at 45
// degrees, so the case bends it down rather than squashing it. It starts
// above the studs. In print its underside is a 45 degree overhang. Its top
// end slopes down, so the case rides onto it.
module shim_fin(x) {
    z0 = plate_t + shim_base;
    z1 = plate_t + shim_t;
    w  = fin_t * sqrt(2);                         // horizontal width
    intersection() {
        extrude_y(fin_y0, shim_y1)
            polygon([[x, z0 - 0.01], [x + w, z0 - 0.01], [x + w + fin_rise, z1], [x + fin_rise, z1]]);
        extrude_x(x - 1, x + w + fin_rise + 1)
            polygon([[-plate_t, fin_y0], [-z1, fin_y0], [-z1, shim_y1 - fin_lead],
                     [-z0, shim_y1], [-plate_t, shim_y1]]);
    }
}

module shim() {
    difference() {
        union() {
            translate([-shim_hw, shim_y0, plate_t]) cube([2 * shim_hw, shim_y1 - shim_y0, shim_base]);
            xflip_copy() for (x = shim_fins) shim_fin(x);
        }
        // holes for the studs
        xflip_copy() translate([stud_x, stud_y, plate_t - 1])
            linear_extrude(shim_base + 2, convexity = 10) diamond2d(stud_w + 2 * stud_clearance);
    }
}

// Print orientation: flat, its back on the bed
module shim_print() { down(plate_t) shim(); }

// ---------- display models ----------
module cup_model() {
    up(glass_z) cyl(h = 1.5, d = cup_d, anchor = BOTTOM);  // rim
    up(glass_z + 1.5) cyl(h = -glass_z - 1.5, d1 = cup_d - 4, d2 = 18, anchor = BOTTOM);
    down(1) cyl(h = floor_t + 1, d = neck_d, anchor = BOTTOM);
    up(floor_t) cyl(h = head_height, d = head_d, anchor = BOTTOM);
}

// Case outline, centred on the origin, long side along Y, display toward +Z
module case_model() {
    intersection() {
        cuboid([case_w, case_h, case_t], rounding = case_corner_r, edges = "Z");
        xrot(90) linear_extrude(case_h, center = true, convexity = 10)
            rect([case_w, case_t], rounding = case_edge_r);
        yrot(90) linear_extrude(case_w, center = true, convexity = 10)
            rect([case_t, case_h], rounding = case_edge_r);
    }
}

// SMA antenna on the case's top end
module antenna_model() {
    translate([antenna_x, case_h / 2, 0]) {
        ycyl(h = 12, d = 8, anchor = FRONT);
        back(12) ycyl(h = 100, d = 10, anchor = FRONT);
    }
}

// ---------- output ----------
if (part == "mounted") {
    holder();
    color("orange") lock_bar_mounted();
    color("tomato") shim();
    color("lightgray") cup_model();
    color("dimgray", 0.6) translate([0, case_y0 + case_h / 2, case_zc]) {
        case_model();
        antenna_model();
    }
    %translate([-60, -70, glass_z - 3]) cube([120, 200, 3]);
} else if (part == "holder") {
    holder_print();
} else if (part == "lock") {
    lock_bar();
} else if (part == "shim") {
    shim_print();
}
