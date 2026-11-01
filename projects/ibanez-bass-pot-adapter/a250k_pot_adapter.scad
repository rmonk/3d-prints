// A250K Pot Adapter
// -------------------------------------------------------------
// An adapter that holds an A250K potentiometer in a 9.7 mm hole in a
// guitar body, modelled on "Ibanez short pot adapter.stl". A boss sits
// in the body's hole, the pot's bushing (M8 x 0.75, measured 7.77 mm)
// screws into it from below, and a square flange bears on the top of
// the body.
//
// The same shape as the original: a 15 mm square flange 2 mm thick, its
// corners rounded to 17 mm across, and a 5 mm boss. The boss is wider,
// to fit the 9.7 mm hole (the original's is 9 mm).
//
// No printed thread: the bore is plain, a little over the bushing's
// root, and the pot's metal thread forms its own in the PETG as it's
// screwed in. A 0.75 mm pitch is too fine to print well at 0.28 mm
// layers anyway, and the plain bore leaves a thicker wall. A 45 degree
// lead-in at the boss's end starts the bushing straight.
//
// Printing: flat, flange on the bed and the boss up, as the original
// prints. The bore is vertical; the chamfers are 45 degrees.
//
// Model coordinates: print orientation, the flange's top face (on the
// body in use) on the bed at z = 0. All dimensions in mm.

/* [Output] */
// Which part(s) to render
part = "all"; // [all, adapter, mounted]

/* [Body hole] */
// Diameter of the hole in the guitar body
hole_d = 9.7;
// Gap between the boss and the hole, each side
hole_clearance = 0.1;

/* [Pot bushing] */
// Bushing thread's outside diameter (measured)
bushing_d = 7.77;
// Bore the bushing cuts its thread into; raise it if the pot is too hard to screw in, lower it if it's loose
bore_d = 7.4;
// Lead-in chamfer at the end the pot goes in
lead_in = 0.6;
// Chamfer at the flange end of the bore
top_chamfer = 0.3;

/* [Adapter] */
// Length of the boss below the flange
boss_l = 5;
// Flange size (square)
flange_w = 15;
// Flange thickness
flange_t = 2;
// Diameter the flange's corners are rounded to
flange_corner_d = 17;

/* [Hidden] */
$fn = 96;
eps = 0.01;

boss_d = hole_d - 2 * hole_clearance;
total_l = flange_t + boss_l;

assert(bore_d < bushing_d - 0.2, "the bore must be well under the bushing for its thread to bite");
assert(boss_d - bushing_d >= 1, "the boss wall outside the bushing's thread must be at least 0.5 mm");

echo(str("boss ", boss_d, " mm across; wall ", (boss_d - bore_d) / 2,
         " mm at the bore, ", (boss_d - bushing_d) / 2, " mm outside the cut thread"));

module adapter() {
    difference() {
        union() {
            intersection() {
                translate([-flange_w / 2, -flange_w / 2, 0])
                    cube([flange_w, flange_w, flange_t]);
                cylinder(d = flange_corner_d, h = flange_t);
            }
            cylinder(d = boss_d, h = total_l);
        }
        translate([0, 0, -1]) cylinder(d = bore_d, h = total_l + 2);
        // Chamfer at the flange end (on the bed in print)
        translate([0, 0, -eps])
            cylinder(d1 = bore_d + 2 * top_chamfer + 2 * eps, d2 = bore_d - eps,
                     h = top_chamfer + eps);
        // Lead-in at the boss's end, where the pot goes in
        translate([0, 0, total_l - lead_in])
            cylinder(d1 = bore_d - eps, d2 = bore_d + 2 * lead_in + 2 * eps,
                     h = lead_in + eps);
    }
}

if (part == "mounted") {
    // Flange on the body's top, boss down into the hole
    translate([0, 0, flange_t]) mirror([0, 0, 1]) adapter();
    color("burlywood", 0.3) %difference() {
        translate([-15, -15, -boss_l - 3]) cube([30, 30, boss_l + 3]);
        translate([0, 0, -boss_l - 4]) cylinder(d = hole_d, h = boss_l + 5);
    }
} else if (part == "all" || part == "adapter") {
    adapter();
}
