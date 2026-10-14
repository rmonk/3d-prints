// Hat Stretcher
// -------------------------------------------------------------
// An adjustable oval form for stretching the band of a soft cap (made
// for a 57 cm flat cap). It's a head-shaped oval split across the
// middle into two identical halves, front and back, pushed apart by a
// printed turnbuckle. Closed it measures 55.5 cm round, so it drops
// easily into a 57 cm cap; fully open it's about 61 cm.
//
// Each half is a half-oval wall closed by a cross wall set back from the
// split. The turnbuckle rod runs along the middle, front to back: a
// right-hand thread at one end, a left-hand one at the other, and a
// knurled wheel in the middle. Each end screws into a printed nut held
// captive behind a cross wall, so turning the wheel moves both halves
// apart (or together) by twice the pitch per turn. The wheel sits in the
// gap between the cross walls; reach it from below through the open
// bottom of the form.
//
// Two guide fins on each half reach across the gap into slots in the
// other half, so the halves stay in line as they spread. The halves are
// identical: the second one is the first turned upside down, so its fins
// sit above the first one's at the same place and its nut slot opens
// downward (the rod keeps the nut in).
//
// As the halves spread, the band runs straight across the gap at each
// side: both halves meet the gap parallel to the split, so the form
// becomes a longer oval with straight sides, and the band isn't creased.
//
// The rod pushes the halves apart through the nut blocks in the middle of
// the cross walls, and the band pushes back on the oval walls, so a cross
// wall on its own bends: it's thin, and the load is in its middle. A brace
// in each half (a separate part, dropped in from above) takes the thrust
// straight from the back of the nut block to the back of the oval wall. It's
// a triangle: two legs from a collar round the nut block to a curved pad
// that bears on the wall through feet between the vent windows.
//
// Use: dampen the band (warm water or a little steam, but see the note on
// heat below), fit the cap over the closed form, and turn the wheel until
// the band is snug. Then a turn or so more each day as it dries, until
// it reaches the size you want. Vent windows in the walls let the inside
// of the band dry.
//
// Printing, all without supports:
//  - halves (print two, the same STL): upright, as modelled. Every wall
//    is vertical. The fins stand on the bed, the slots and nut slot open
//    upward and the rod holes are teardrops. The half turned over for use
//    prints the same way up as the first.
//  - rod: standing on its right-hand end. The wheel's underside is a 45
//    degree cone.
//  - nuts: flat, one right-hand and one left-hand (marked R and L).
//  - braces (print two, the same STL): flat. Every face is vertical, and
//    the load runs along the layers.
// Hot water or steam on the form itself softens PETG (and PLA much
// sooner), so steam the cap before fitting it, not on the form; or print
// in ASA if you want to steam it in place.
//
// Wall thicknesses lie in the layer plane and are set as a whole number
// of extrusion lines (see [Printing]).
//
// Set part = "mounted" to view the assembly opened to show_spread, with
// the hat band shown as a ghost. Uses BOSL2 from library/ for the
// threads. All dimensions in mm.

include <../../library/BOSL2/std.scad>
include <../../library/BOSL2/threading.scad>
include <../../library/shapes.scad>

/* [Output] */
// Which part(s) to render
part = "all"; // [all, half, rod, nuts, brace, mounted]
// How far apart the halves are in the mounted view
show_spread = 20;

/* [Size] */
// Circumference of the form when closed (fits inside the hat)
closed_circ = 555;
// How far the halves can spread apart; adds twice this to the circumference
stretch = 28;
// Width / length of the oval (a typical head is about 0.8)
width_ratio = 0.8;
// Height of the form (a cap's band is narrower than this)
form_h = 25;

/* [Printing] */
// Extrusion line width set in the slicer
line_w = 0.45;
// Layer height set in the slicer
layer_h = 0.28;

/* [Walls] */
// Oval wall thickness, in lines
wall_lines = 5;
// Cross wall, nut block and slot wall thickness, in lines
cross_lines = 6;
// Guide fin thickness, in lines
fin_lines = 10;
// Chamfer on the outer top and bottom edges
edge_chamfer = 1;
// Cut diamond vent windows in the oval walls so the band dries
vents = true;
// Size of the vent diamonds
vent_w = 12;

/* [Guides] */
// How far each guide fin still reaches into its slot at full stretch
fin_engage = 12;
// Distance of the guide fins from the centre line
fin_y = 45;
// Clearance around the fins in their slots
guide_clearance = 0.3;
// Gap between the halves when closed
split_gap = 0.5;

/* [Turnbuckle] */
// Thread major diameter
thread_d = 10;
// Thread pitch (coarse prints best)
thread_pitch = 2.5;
// Printer slop for the nuts' threads (BOSL2 $slop); raise it if they bind
thread_slop = 0.15;
// Nut thickness (4 threads)
nut_h = 10;
// Nut size across the flats
nut_af = 16;
// Clearance around a nut in its slot
nut_slot_clearance = 0.3;
// Wheel diameter; keep it under form_h so the form stands on the table
wheel_d = 23;
// Height of the wheel's straight rim
wheel_rim = 7;

/* [Brace] */
// Gap between the brace's feet and the oval wall
brace_clearance = 0.2;
// Gap each side between the brace's collar and the nut block (snug, so the brace stays in)
brace_side_clearance = 0.15;
// Leg thickness, in lines
brace_leg_lines = 10;
// Pad, spine and collar thickness, in lines
brace_lines = 8;
// Where the feet bear on the oval wall (ellipse angles from the back; vents are at 0, 20, 40 and 60)
brace_feet = [10, 30];
// Width of each foot along the wall
brace_foot_w = 8;
// Air gap between the pad and the wall, so the vents behind it still breathe
brace_pad_gap = 3;
// Brace height; it stands on the table, a little below the form's top
brace_h = 24;

/* [Hidden] */
$fn = 64;
eps = 0.01;

// ---------- derived values ----------
// Thickness of n extrusion lines side by side. Slicers in the PrusaSlicer
// family (also Orca and Bambu Studio) overlap neighbouring lines, spacing
// them line_w - layer_h * (1 - pi / 4) apart.
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));
wall_t   = lines(wall_lines);
cross_t  = lines(cross_lines);
fin_t    = lines(fin_lines);

// Ellipse semi-axes from the closed circumference (Ramanujan's
// approximation, scaled from a unit ellipse with semi-axes 1 and k)
function ellipse_perimeter(a, b) =
    let(h = pow((a - b) / (a + b), 2))
    PI * (a + b) * (1 + 3 * h / (10 + sqrt(4 - 3 * h)));
semi_a   = closed_circ / ellipse_perimeter(1, width_ratio);  // along X, front to back
semi_b   = width_ratio * semi_a;                             // along Y, side to side
max_circ = closed_circ + 2 * stretch;

thread_angle = 90;                       // 45 degree flanks, printable standing up
thread_depth = 0.4 * thread_pitch;
wheel_cone = (wheel_d - thread_d) / 2;   // 45 degree underside, in print
wheel_t  = wheel_cone + wheel_rim;
knurls   = floor(PI * wheel_d / 7.5);    // scallops about 7.5 mm apart round the rim
rod_z    = form_h / 2;                   // rod axis height
assert(wheel_d <= form_h - 2, "wheel_d must be under form_h, or the wheel sticks out of the form");
assert(rod_z - (nut_af + 0.6) / cos(30) / 2 >= 2, "nut_af too big for form_h: the nut slot breaks through the bottom");
setback  = wheel_t / 2 + 2;              // cross wall's front face, back from the split
cross_x  = setback + cross_t;            // cross wall's back face
nut_ac   = (nut_af + 2 * nut_slot_clearance) / cos(30);
nut_x1   = cross_x + nut_h + nut_slot_clearance;  // back of the nut slot
block_x  = nut_x1 + cross_t;                      // back of the nut block
block_hw = nut_af / 2 + nut_slot_clearance + cross_t;
// Each thread reaches through its nut with the halves fully spread
thread_l = stretch / 2 + nut_x1 + 1 - wheel_t / 2;
rod_l    = 2 * thread_l + wheel_t;
slot_len = setback + stretch + fin_engage;        // fin length past the split
slot_hw  = fin_t / 2 + guide_clearance;
fin_top  = form_h / 2 - guide_clearance;

// Brace
leg_t    = lines(brace_leg_lines);
brace_t  = lines(brace_lines);
collar_t = lines(cross_lines);
rod_end  = thread_l + wheel_t / 2;               // rod end, back from the split, with the halves closed
rod_slot_hw = thread_d / 2 + 1;                  // slot in the brace the rod end runs in
apex_x0  = rod_end + 2;                          // back of the rod slot
apex_x1  = apex_x0 + brace_t;                    // back of the brace's collar block
apex_hw  = block_hw + brace_side_clearance + collar_t;
pad_in   = brace_clearance + brace_pad_gap;     // pad's outer face, in from the wall's inside
pad_phi  = max(brace_feet);
assert(brace_h <= form_h, "brace_h must not be more than form_h");

echo(str("Hat stretcher: ", 2 * semi_a, " x ", 2 * semi_b, " x ", form_h,
         " closed, circumference ", closed_circ, " to ", max_circ,
         "  Rod: ", rod_l, " long, wheel ", wheel_d));

// ---------- helpers ----------
// Extrude a 2D outline drawn as [y, z] along X from x0 to x1
module along_x(x0, x1) {
    translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(x1 - x0, convexity = 10) children();
}

module ellipse2d(a = semi_a, b = semi_b) { scale([a, b]) circle(1, $fn = 240); }

// The closed form's outline with chamfered top and bottom edges
module envelope() {
    c = edge_chamfer;
    hull() {
        linear_extrude(form_h, convexity = 10) offset(-c) ellipse2d();
        translate([0, 0, c]) linear_extrude(form_h - 2 * c, convexity = 10) ellipse2d();
    }
}

// Diamond (45 degree sides), w wide and tall, centred on [y, z]
module diamond2d(y, z, w) {
    translate([y, z]) rotate(45) square(w / sqrt(2), center = true);
}

// ---------- half (mounted and print orientation: the back half, x < 0) ----------
// The front half is this one turned upside down (rotated 180 degrees about
// the Y axis through the rod).

// Vent windows through the oval wall, cut along the wall's normal
module vent_cuts() {
    for (phi = [-60 : 20 : 60]) {
        p = [-semi_a * cos(phi), semi_b * sin(phi)];
        normal = atan2(sin(phi) / semi_b, -cos(phi) / semi_a);
        translate(p) rotate(normal) along_x(-wall_t - 3, 3) diamond2d(0, form_h / 2, vent_w);
    }
}

module half() {
    difference() {
        intersection() {
            union() {
                // oval wall, from the back to the split
                linear_extrude(form_h, convexity = 10)
                    intersection() {
                        difference() {
                            ellipse2d();
                            offset(-wall_t) ellipse2d();
                        }
                        translate([-2 * semi_a, -2 * semi_b])
                            square([2 * semi_a - split_gap / 2, 4 * semi_b]);
                    }
                // cross wall, set back from the split to leave room for the wheel
                translate([-cross_x, -semi_b, 0]) cube([cross_t, 2 * semi_b, form_h]);
                // nut block behind the cross wall
                translate([-block_x, -block_hw, 0]) cube([block_x - cross_x + eps, 2 * block_hw, form_h]);
                for (s = [-1, 1]) {
                    // guide fin in the lower half, reaching across into the other half
                    translate([-cross_x + eps, s * fin_y - fin_t / 2, 0])
                        cube([cross_x + slot_len, fin_t, fin_top]);
                    // walls of the slot for the other half's fin, full height
                    for (side = [-1, 1])
                        translate([-(slot_len + 2), s * fin_y + side * (slot_hw + cross_t / 2) - cross_t / 2, 0])
                            cube([slot_len + 2 - cross_x + eps, cross_t, form_h]);
                }
            }
            envelope();
        }
        // openings in the cross wall's upper half for the other half's fins
        for (s = [-1, 1])
            translate([-cross_x - 1, s * fin_y - slot_hw, form_h / 2])
                cube([cross_t + 2, 2 * slot_hw, form_h]);
        // rod hole through the cross wall and the nut block, a teardrop
        along_x(-block_x - 1, -setback + 1)
            translate([0, rod_z]) pointed_circle2d((thread_d + 1) / 2, (thread_d + 1) / 2 * sqrt(2));
        // captive nut slot, open upward, flats against the slot walls
        along_x(-nut_x1, -cross_x)
            hull()
                for (z = [rod_z, form_h + nut_ac])
                    translate([0, z]) rotate(90) circle(d = nut_ac, $fn = 6);
        if (vents) vent_cuts();
    }
}

// ---------- brace (mounted orientation, in the back half; prints as it is) ----------
// Point on the oval's outside at ellipse angle phi from the back, moved in
// along the wall's normal by d
function oval_point(phi, d = 0) =
    let(n = [-cos(phi) / semi_a, sin(phi) / semi_b])
    [-semi_a * cos(phi), semi_b * sin(phi)] - d * n / norm(n);
// Length along the oval per degree of ellipse angle, at phi
function oval_rate(phi) = norm([semi_a * sin(phi), semi_b * cos(phi)]) * PI / 180;

// Area inside the oval wall, inset by d
module inside2d(d) { offset(-(wall_t + d)) ellipse2d(); }
// Band between insets d0 and d1 (d1 > d0) from the wall's inside, from ellipse angle p0 to p1
module oval_band2d(d0, d1, p0, p1) {
    intersection() {
        difference() { inside2d(d0); inside2d(d1); }
        polygon(concat([[0, 0]], [for (p = [p0 : (p1 - p0) / 24 : p1 + eps]) 2 * oval_point(p)]));
    }
}

module brace2d() {
    // collar round the nut block, bearing on its back face either side of
    // the rod slot
    difference() {
        translate([-apex_x1, -apex_hw]) square([apex_x1 - cross_x - 0.5, 2 * apex_hw]);
        translate([-block_x, -(block_hw + brace_side_clearance)])
            square([block_x, 2 * (block_hw + brace_side_clearance)]);
        translate([-apex_x0, -rod_slot_hw]) square([apex_x0, 2 * rod_slot_hw]);
    }
    // pad, standing off the wall, and the feet that bear on it
    pad_dp = (brace_foot_w / 2) / oval_rate(pad_phi);
    oval_band2d(pad_in, pad_in + brace_t, -pad_phi - pad_dp, pad_phi + pad_dp);
    for (s = [-1, 1], p = brace_feet) {
        dp = (brace_foot_w / 2) / oval_rate(p);
        oval_band2d(brace_clearance, pad_in + eps,
                    s * p - dp, s * p + dp);
    }
    for (s = [-1, 1]) {
        // leg from the collar's back corner to the pad over the outer feet
        hull() {
            translate([-apex_x1 + leg_t / 2, s * (apex_hw - leg_t / 2)]) circle(d = leg_t, $fn = 24);
            translate(oval_point(s * pad_phi, wall_t + pad_in + brace_t / 2)) circle(d = leg_t, $fn = 24);
        }
    }
    // spine from the collar straight back to the pad
    translate([oval_point(0, wall_t + pad_in + brace_t / 2).x, -brace_t / 2])
        square([-apex_x0 - oval_point(0, wall_t + pad_in + brace_t / 2).x, brace_t]);
}

module brace() { linear_extrude(brace_h, convexity = 10) brace2d(); }

// ---------- turnbuckle rod (print orientation: right-hand end down, axis +Z) ----------
module rod() {
    trapezoidal_threaded_rod(d = thread_d, l = thread_l + eps, pitch = thread_pitch,
                             thread_angle = thread_angle, thread_depth = thread_depth,
                             bevel1 = true, bevel2 = false, anchor = BOTTOM);
    // knurled wheel with a 45 degree cone underneath
    translate([0, 0, thread_l])
        difference() {
            union() {
                // starts at the thread root, so it covers the thread's
                // top end instead of overhanging its groove
                translate([0, 0, -thread_depth])
                    cylinder(h = wheel_cone + thread_depth, d1 = thread_d - 2 * thread_depth,
                             d2 = wheel_d);
                translate([0, 0, wheel_cone]) cylinder(h = wheel_rim, d = wheel_d);
            }
            for (i = [0 : knurls - 1])
                rotate(i * 360 / knurls) translate([wheel_d / 2 + 1, 0, -1])
                    cylinder(h = wheel_t + 2, d = 5);
        }
    translate([0, 0, thread_l + wheel_t - eps])
        trapezoidal_threaded_rod(d = thread_d, l = thread_l + eps, pitch = thread_pitch,
                                 thread_angle = thread_angle, thread_depth = thread_depth,
                                 left_handed = true, bevel1 = false, bevel2 = true,
                                 anchor = BOTTOM);
}

// ---------- nuts (print orientation: flat, axis +Z) ----------
module nut(left_handed) {
    difference() {
        trapezoidal_threaded_nut(nutwidth = nut_af, id = thread_d, h = nut_h, pitch = thread_pitch,
                                 thread_angle = thread_angle, thread_depth = thread_depth,
                                 left_handed = left_handed, shape = "hex", ibevel = true,
                                 bevel1 = false, bevel2 = true,  // no outer chamfer on the bed side
                                 $slop = thread_slop, anchor = BOTTOM);
        // hand marked on the top face, beside the hole
        translate([0, -(thread_d / 2 + nut_af / 2) / 2 - 0.3, nut_h - 0.6])
            linear_extrude(1, convexity = 10)
                text(left_handed ? "L" : "R", size = 3.2, halign = "center", valign = "center");
    }
}

module nuts() {
    translate([-(nut_af / 2 + 3), 0, 0]) nut(false);
    translate([nut_af / 2 + 3, 0, 0]) nut(true);
}

// ---------- assembly ----------
// Back half at -spread/2, the front half (turned over) at +spread/2
module back_half(spread) { translate([-spread / 2, 0, 0]) half(); }
module front_half(spread) {
    translate([spread / 2, 0, form_h]) rotate([0, 180, 0]) half();
}
// Rod with its wheel centred on the split; the right-hand end goes in the back half
module rod_mounted() {
    translate([-(thread_l + wheel_t / 2), 0, rod_z]) rotate([0, 90, 0]) rod();
}
// Nuts in their slots: right-hand in the back half, left-hand in the front
module nuts_mounted(spread) {
    translate([-spread / 2 - cross_x, 0, rod_z]) rotate([0, -90, 0]) nut(false);
    translate([spread / 2 + cross_x, 0, rod_z]) rotate([0, 90, 0]) nut(true);
}

// Braces standing on the table in each half
module braces_mounted(spread) {
    translate([-spread / 2, 0, 0]) brace();
    translate([spread / 2, 0, 0]) mirror([1, 0, 0]) brace();
}

// Hat band around the spread form: the oval with straight sides
module band(spread) {
    linear_extrude(form_h - 10, convexity = 10)
        difference() {
            offset(1.5) hull() for (s = [-1, 1]) translate([s * spread / 2, 0]) ellipse2d();
            hull() for (s = [-1, 1]) translate([s * spread / 2, 0]) ellipse2d();
        }
}

// ---------- output ----------
if (part == "mounted") {
    back_half(show_spread);
    color("lightsteelblue") front_half(show_spread);
    color("orange") rod_mounted();
    color("dimgray") nuts_mounted(show_spread);
    color("seagreen") braces_mounted(show_spread);
    %translate([0, 0, 5]) band(show_spread);
} else if (part == "all") {
    half();
    translate([semi_a + 15, 0, 0]) rod();
    translate([semi_a + 15, 2 * nut_af, 0]) nuts();
    translate([0, -(semi_b + 60), 0]) brace();
} else if (part == "half") {
    half();
} else if (part == "rod") {
    rod();
} else if (part == "nuts") {
    nuts();
} else if (part == "brace") {
    brace();
}
