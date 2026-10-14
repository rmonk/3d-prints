// Shared suction cup library
// -------------------------------------------------------------
// Dimensions of the mushroom-head suction cups and the T-slot that
// holds one, shared by every mount in this folder. Include it with
//   include <../../library/suction_cup.scad>
// and override any value after the include, or with -D on the
// command line. (OpenSCAD's Customizer only lists parameters from
// the main file, so change the cup sizes here.)
// All dimensions in mm.

include <shapes.scad>

/* [Suction Cups] */
// Overall diameter of a suction cup
cup_d = 61;
// Total height of the cup's attachment knob (neck + head)
knob_height = 6.3;
// Height of the large head of the knob
head_height = 3.5;
// Diameter of the large head of the knob
head_d = 14.5;
// Diameter of the narrow neck below the head
neck_d = 8.5;
// Clearance around the head / neck in the slots
slot_clearance = 0.3;

/* [Hidden] */
eps = 0.01;

// ---------- derived values ----------
neck_height  = knob_height - head_height;
// Floor is slightly thinner than the neck so the cup pulls up snug
floor_t      = neck_height - 0.2;
pocket_h     = head_height + slot_clearance;
head_r       = head_d / 2 + slot_clearance;
neck_r       = neck_d / 2 + slot_clearance;
// Pointed slot ends are cut flat this far past the circle (short bridge)
tip_extra    = 1;
// Material needed above the head pocket is added by each mount (roof)

// ---------- cup slot ----------
// 2D slot outline: closed pointed end toward +Y, open toward -Y
module slot2d(r, len = 200) {
    pointed_circle2d(r, r + tip_extra);
    translate([-r, -len]) square([2 * r, len]);
}

// T-slot for one suction cup knob, centred on the origin with the glass
// at z = 0. It opens toward -Y through the edge at y = open_y (< 0),
// where the neck slot gets a 45 degree lead-in.
module cup_slot(open_y) {
    // neck slot through the floor
    translate([0, 0, -eps])
        linear_extrude(floor_t + 2 * eps, convexity = 10) slot2d(neck_r);
    // head pocket
    translate([0, 0, floor_t])
        linear_extrude(pocket_h, convexity = 10) slot2d(head_r);
    // 45 degree lead-in on the neck slot entrance
    translate([0, open_y, -eps])
        linear_extrude(floor_t + 2 * eps, convexity = 10)
            polygon([[-neck_r - 1, -eps], [neck_r + 1, -eps],
                     [neck_r, 1], [-neck_r, 1]]);
}
