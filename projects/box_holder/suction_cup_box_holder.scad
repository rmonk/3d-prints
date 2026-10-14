// Suction Cup Box Holder
// -------------------------------------------------------------
// Holds a light rectangular object (default 60-65 mm wide and
// 20-25 mm thick) against a window with a single suction cup.
//
// The object's back rests on a base plate. A fixed jaw grips one
// side and a sliding jaw grips the other; both have 45 degree lips
// that wrap over the object's front edges. A printed thumbscrew,
// running in a printed nut held captive in the end block, pushes the
// sliding jaw in. A ledge along the bottom edge carries the object's
// weight.
//
// Optional TPU grip pads cover both jaw faces. Each has a dovetail rib
// that slides down into a groove in the jaw from the top until it
// rests on the ledge. The jaws are spaced out and the lips lengthened
// by the pad thickness, so the grip range and lip overlap stay the
// same with pads fitted. Set pads = false to leave the grooves out and
// close the jaws up again.
//
// Mounting: the cup slot opens through the bottom edge. With the cup
// stuck to the glass, hold the holder above the knob and slide it down
// so the knob goes up into the slot; gravity keeps it seated. Centre
// the object over the cup so its weight doesn't twist the holder
// around the knob.
//
// Assembly: drop the sliding jaw's foot into the opening in the plate
// beside the object area and slide it out toward the end block. Drop
// the nut into its slot from the top edge of the end block, then
// thread the screw in from outside. Back the screw off and pull the jaw
// open to fit the object; tighten the screw to clamp it.
//
// Printing, all without supports. Every part is oriented so the
// clamping load runs along the layers, never across or between them:
//  - base: on its bottom edge (the edge the cup slot opens through).
//    The plate, fixed jaw, lip and end block are then all in each
//    layer, so the clamping force can't shear the jaw or the block off
//    along a layer line. The jaw track is a 45 degree dovetail, the cup
//    slot is a vertical channel with a pointed end, the screw hole is a
//    teardrop, and the nut slot opens upward
//  - sliding jaw: on its outer face, so its layers run up the jaw and
//    the foot and lip print without overhangs
//  - screw: standing on its head; nut: flat. Both threads are
//    vertical, which is the only way printed threads come out well.
//    The thread has 45 degree flanks (not the 60 degree ISO form) so
//    every flank is printable
//  - grip pads (print two, in TPU): grip face down, rib up; the rib's
//    dovetail flanks are 45 degrees
// Set part = "mounted" to view the assembly with an example object.
// The suction cup sizes are shared with the other mounts in
// suction_cup.scad. All dimensions in mm.
//
// Requires the BOSL2 library (https://github.com/BelfrySCAD/BOSL2) in
// OpenSCAD's library folder, for the threads.

include <../../library/BOSL2/std.scad>
include <../../library/BOSL2/threading.scad>
include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "all"; // [all, base, jaw, screw, nut, pad, mounted]

/* [Object] */
// Narrowest object width to grip
obj_w_min = 60;
// Widest object width to grip
obj_w_max = 65;
// Thickest object (the jaw lips sit just above this)
obj_t_max = 25;
// Width of object shown in the "mounted" view
demo_w = 62;
// Thickness of object shown in the "mounted" view
demo_t = 22;

/* [Holder] */
// Height of the holder on the window (along the object's sides)
holder_h = 30;
// Thickness of each jaw
jaw_t = 6;
// How far the lips reach over the object's front edges
lip = 3;
// Clearance between the lips and the thickest object
lip_clearance = 0.5;
// Height of the ledge the object rests on
ledge_h = 6;
// Thickness of the ledge
ledge_t = 3;
// Material above the cup's head pocket
roof_thickness = 2.5;
// Rounding of the plate's outer edges on the glass side
plate_corner_r = 1;

/* [Grip Pads] */
// Fit TPU grip pads to the jaws (adds grooves and spaces the jaws out)
pads = true;
// Pad thickness in front of the jaw face
pad_t = 2;
// Width of the jaw groove at the jaw face
groove_w = 6;
// Depth of the jaw groove (its sides undercut at 45 degrees)
groove_d = 1.5;
// Clearance between the pad's rib and the groove (per side)
pad_clearance = 0.15;

/* [Jaw Track] */
// Width of the dovetail track at its base
track_w = 14;
// Width of the slit the jaw stem rides in
slit_w = 7;
// Clearance between the jaw foot and the track (per side)
track_clearance = 0.25;

/* [Screw and Nut] */
// Thread major diameter
thread_d = 10;
// Thread pitch (coarse prints best)
thread_pitch = 2.5;
// Printer slop for the nut's thread (BOSL2 $slop); raise it if the nut binds
thread_slop = 0.1;
// Nut thickness (about 3 threads)
nut_h = 8;
// Nut size across the flats
nut_af = 16;
// Clearance around the nut in its slot
nut_slot_clearance = 0.3;
// Thumbscrew head diameter
knob_d = 22;
// Thumbscrew head thickness
knob_h = 8;

/* [Hidden] */
$fn = 64;

// ---------- derived values ----------
plate_t      = floor_t + pocket_h + roof_thickness;
y0           = -holder_h / 2;                 // bottom edge (cup slot opens here)
y1           =  holder_h / 2;

// Pads sit between each jaw face and the object
pad_eff      = pads ? pad_t : 0;

// Object centred on the cup at mid-range width
obj_x0       = -(obj_w_min + obj_w_max) / 4;  // object's side against the fixed jaw
x_fix        = obj_x0 - pad_eff;              // fixed jaw inner face
jaw_z0       = plate_t + 0.4;                 // sliding jaw rides just above the plate
// Lips slope out at 45 degrees from the jaw face. They start low enough
// that they cross the pad face (the object's side) just above the
// thickest object, and reach past the pad by `lip`.
lip_z        = plate_t + obj_t_max + lip_clearance;   // lip underside at the pad face
lip_wall_z   = lip_z - pad_eff;                       // lip underside at the jaw face
lip_reach    = lip + pad_eff;
jaw_top      = lip_wall_z + lip_reach + 1.5;

// Sliding jaw inner face: squeezes 1 mm past the narrowest object,
// opens far enough for the widest object to pass its lip
jaw_in_min   = obj_x0 + obj_w_min - 1 + pad_eff;
jaw_in_open  = obj_x0 + obj_w_max + lip_reach + 1;

// Pads cover the jaw face from the plate up to the lip, standing on the
// ledge; their top edge follows the lip's 45 degree underside, 0.3 below it
pad_z0       = plate_t + 0.3;
pad_z1       = lip_wall_z - 0.3;              // pad top at the jaw face
pad_z2       = pad_z1 + pad_t;                // pad top at its grip face
groove_zc    = (pad_z0 + pad_z1) / 2;
x_block      = jaw_in_open + jaw_t + 0.5;      // inner face of the end block

// Dovetail track (z from the glass side): 45 degree sides all the way
// from its floor up to the slit at the plate surface. With the base
// printed on its edge, these sides are the only ceilings, and 45 degrees
// prints cleanly; a straight-sided slit would leave an unsupported ledge.
track_z0     = plate_t - (track_w - slit_w) / 2;
entry_x1     = jaw_in_min - 0.5;              // the jaw foot drops in left of here
entry_x0     = entry_x1 - jaw_t - 0.6;
track_x1     = x_block - 0.3;

// Thread form: trapezoidal with 45 degree flanks (90 degrees between
// faces) so it prints standing up; depth 0.4 x pitch leaves small flats
thread_angle = 90;
thread_depth = 0.4 * thread_pitch;
screw_z      = plate_t + thread_d / 2 + 1.5;  // screw axis height
nut_ac       = (nut_af + 2 * nut_slot_clearance) / cos(30);
block_wall   = 2;
block_t      = 2 * block_wall + nut_h + nut_slot_clearance;
block_top    = screw_z + nut_af / 2 + 1;
x_end        = x_block + block_t;
// Screw must reach the jaw at its most-closed position
screw_len    = block_t + (x_block - jaw_in_min - jaw_t) + 1;

x_left       = x_fix - jaw_t - 4;              // plate edge (room for the root chamfer)

echo(str("Base: ", x_end - x_left, " x ", holder_h, " x ", plate_t,
         " (prints ", holder_h, " tall on its edge)",
         "  Jaw height: ", jaw_top, "  Grips ", obj_w_min, "-", obj_w_max,
         " wide, up to ", obj_t_max, " thick",
         "  Screw: ", thread_d, " x ", thread_pitch, ", ", screw_len, " long"));

// ---------- helpers ----------
// Hole along +X whose teardrop point faces +Y (up when the base is printed on its edge)
module hole_x(d, x0, x1) {
    translate([x0, 0, 0]) rotate([0, 90, 0])
        linear_extrude(x1 - x0, convexity = 10) pointed_circle2d(d / 2, d / 2 * sqrt(2));
}

// Extrude a YZ profile (2D x -> Y, 2D y -> Z) along X from x0 to x1
module extrude_x(x0, x1) {
    translate([x0, 0, 0]) rotate([90, 0, 90])
        linear_extrude(x1 - x0, convexity = 10) children();
}

// Dovetail track cross-section (YZ), from its floor up through the plate surface
module track2d() {
    polygon([[-track_w / 2, track_z0], [track_w / 2, track_z0],
             [slit_w / 2, plate_t], [slit_w / 2, plate_t + 1],
             [-slit_w / 2, plate_t + 1], [-slit_w / 2, plate_t]]);
}

// Extrude an XZ profile (2D x -> X, 2D y -> Z) along Y from y_a to y_b
module extrude_y(y_a, y_b) {
    translate([0, y_b, 0]) rotate([90, 0, 0])
        linear_extrude(y_b - y_a, convexity = 10) children();
}

// Pad groove profile (XZ) for a jaw face at x = 0 with the jaw on the +X
// side: a dovetail that widens at 45 degrees going into the jaw
module groove2d() {
    polygon([[-1, groove_zc - groove_w / 2], [0, groove_zc - groove_w / 2],
             [groove_d, groove_zc - groove_w / 2 - groove_d],
             [groove_d, groove_zc + groove_w / 2 + groove_d],
             [0, groove_zc + groove_w / 2], [-1, groove_zc + groove_w / 2]]);
}

// Groove cut along the full height of a jaw face at x = 0 (jaw on +X)
module pad_groove() {
    if (pads) extrude_y(y0 - 1, y1 + 1) groove2d();
}

// ---------- base (mounted orientation) ----------
// Plate profile (XZ); only the glass-side edges are rounded, in the
// profile plane, so nothing overhangs when the base prints on its edge
module plate_profile() {
    r = plate_corner_r;
    hull() {
        translate([x_left, r]) square([x_end - x_left, plate_t - r]);
        for (x = [x_left + r, x_end - r]) translate([x, r]) circle(r);
    }
}

module base() {
    difference() {
        union() {
            // plate
            extrude_y(y0, y1) plate_profile();
            // fixed jaw with a 45 degree lip and a 45 degree root chamfer
            extrude_y(y0, y1)
                polygon([[x_left, plate_t - eps], [x_fix, plate_t - eps],
                         [x_fix, lip_wall_z], [x_fix + lip_reach, lip_wall_z + lip_reach],
                         [x_fix + lip_reach, jaw_top], [x_fix - jaw_t, jaw_top],
                         [x_fix - jaw_t, plate_t + 4], [x_left, plate_t]]);
            // ledge the object rests on (the sliding jaw is notched to ride over it)
            translate([x_fix - eps, y0, plate_t - eps])
                cube([x_block - x_fix + 2 * eps, ledge_t, ledge_h]);
            // end block
            translate([x_block, y0, plate_t - eps])
                cube([block_t, holder_h, block_top - plate_t]);
        }
        // suction cup slot, open through the bottom edge
        cup_slot(y0);
        // groove for the fixed jaw's grip pad (mirrored: the jaw is on the -X side)
        translate([x_fix, 0, 0]) mirror([1, 0, 0]) pad_groove();
        // dovetail track for the sliding jaw, and a drop-in opening at its inner end
        extrude_x(entry_x0, track_x1) track2d();
        // (its +Y side is peaked at 45 degrees, which is its ceiling when printed)
        translate([0, 0, track_z0])
            linear_extrude(plate_t, convexity = 10)
                polygon([[entry_x0, -track_w / 2], [entry_x1, -track_w / 2],
                         [entry_x1, track_w / 2],
                         [(entry_x0 + entry_x1) / 2, track_w / 2 + (entry_x1 - entry_x0) / 2],
                         [entry_x0, track_w / 2]]);
        // screw clearance hole through the end block
        translate([0, 0, screw_z]) hole_x(thread_d + 1, x_block - 1, x_end + 1);
        // captive nut slot, open through the top edge (+Y, up when printed),
        // flats against the slot walls
        translate([x_block + block_wall, 0, screw_z])
            rotate([0, 90, 0])
                linear_extrude(nut_h + nut_slot_clearance, convexity = 10)
                    hull()
                        for (y = [0, holder_h])
                            translate([0, y]) rotate(90) circle(d = nut_ac, $fn = 6);
    }
}

// ---------- sliding jaw (mounted orientation, inner face at x = 0) ----------
module jaw() {
    c = track_clearance;
    // wall and lip, profile in XZ across the full holder height,
    // notched at the bottom so it rides over the ledge
    difference() {
        extrude_y(y0, y1)
            polygon([[0, jaw_z0], [jaw_t, jaw_z0], [jaw_t, jaw_top],
                     [-lip_reach, jaw_top], [-lip_reach, lip_wall_z + lip_reach], [0, lip_wall_z]]);
        translate([-lip_reach - 1, y0 - 1, 0])
            cube([jaw_t + lip_reach + 2, ledge_t + 1 + 0.4, plate_t + ledge_h + 0.4]);
        pad_groove();
    }
    // dovetail foot running in the track
    extrude_x(0, jaw_t)
        intersection() {
            offset(delta = -c) track2d();
            translate([-track_w, 0]) square([2 * track_w, jaw_z0 + eps]);
        }
}

// ---------- TPU grip pad (mounted orientation, on a jaw face at x = 0) ----------
// The pad sits on the -X side of the face; its rib fills the jaw's groove.
// It runs from the top of the ledge to the top of the holder.
module grip_pad() {
    extrude_y(y0 + ledge_t, y1)
        union() {
            polygon([[-pad_t, pad_z0], [0, pad_z0], [0, pad_z1], [-pad_t, pad_z2]]);
            intersection() {
                offset(delta = -pad_clearance) groove2d();
                translate([-pad_t, 0]) square([pad_t + groove_d, jaw_top]);
            }
        }
}

// ---------- thumbscrew (print orientation: head down, axis +Z) ----------
module thumbscrew() {
    // scalloped head
    linear_extrude(knob_h, convexity = 10)
        difference() {
            circle(d = knob_d);
            for (i = [0 : 11])
                rotate(i * 30) translate([knob_d / 2 + 0.8, 0]) circle(d = 3.5);
        }
    // threaded shaft, chamfered at the tip
    translate([0, 0, knob_h - eps])
        trapezoidal_threaded_rod(d = thread_d, l = screw_len + eps, pitch = thread_pitch,
                                 thread_angle = thread_angle, thread_depth = thread_depth,
                                 bevel1 = false, bevel2 = true, anchor = BOTTOM);
}

// ---------- nut (print orientation: flat, axis +Z) ----------
module thumb_nut() {
    trapezoidal_threaded_nut(nutwidth = nut_af, id = thread_d, h = nut_h, pitch = thread_pitch,
                             thread_angle = thread_angle, thread_depth = thread_depth,
                             shape = "hex", ibevel = true,   // thread lead-in at both ends
                             bevel1 = false, bevel2 = true,  // no outer chamfer on the bed side
                             $slop = thread_slop, anchor = BOTTOM);
}

// ---------- output ----------
module base_print() {
    // on its bottom edge (-Y, where the cup slot opens), so the plate,
    // fixed jaw and end block all lie in each layer
    translate([0, 0, -y0]) rotate([90, 0, 0]) base();
}

module jaw_print() {
    // lying on its outer face, lip pointing up
    translate([0, 0, jaw_t]) rotate([0, 90, 0]) jaw();
}

module pad_print() {
    // grip face down, rib up
    translate([0, 0, pad_t]) rotate([0, -90, 0]) grip_pad();
}

demo_jaw_x = obj_x0 + demo_w + pad_eff;   // sliding jaw face gripping the demo object

if (part == "mounted") {
    base();
    color("orange") translate([demo_jaw_x, 0, 0]) jaw();
    if (pads) color("dimgray") {
        translate([x_fix, 0, 0]) mirror([1, 0, 0]) grip_pad();
        translate([demo_jaw_x, 0, 0]) grip_pad();
    }
    // screw tip against the jaw's outer face
    color("orange")
        translate([demo_jaw_x + jaw_t + knob_h + screw_len, 0, screw_z])
            rotate([0, -90, 0]) thumbscrew();
    color("orange")
        translate([x_block + block_wall + nut_slot_clearance / 2, 0, screw_z])
            rotate([0, 90, 0]) thumb_nut();   // flats against the slot walls
    // example object
    %translate([obj_x0, y0 + ledge_t, plate_t]) cube([demo_w, holder_h, demo_t]);
} else {
    if ((part == "all" && pads) || part == "pad")
        // two pads for "all"
        for (i = part == "all" ? [0, 1] : [0])
            translate(part == "all" ? [x_end + 8 + pad_z2 + i * (pad_z2 - pad_z0 + 4), 0, 0]
                                    : [pad_z2, 0, 0])
                pad_print();
    if (part == "all" || part == "base") base_print();
    if (part == "all" || part == "jaw")
        translate([part == "all" ? -jaw_top - 4 : 0, part == "all" ? y1 + 20 : 0, 0]) jaw_print();
    if (part == "all" || part == "screw")
        translate(part == "all" ? [knob_d / 2 + 4, y1 + knob_d / 2 + 6, 0] : [0, 0, 0]) thumbscrew();
    if (part == "all" || part == "nut")
        translate(part == "all" ? [knob_d + nut_af / 2 + 12, y1 + knob_d / 2 + 6, 0] : [0, 0, 0]) thumb_nut();
}
