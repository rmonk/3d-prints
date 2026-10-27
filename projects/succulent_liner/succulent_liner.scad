// Succulent Liner
// -------------------------------------------------------------
// A planting insert for La Fermiere's terracotta yogurt pots, which
// have no drainage hole. A liner pot with a perforated floor hangs
// inside the cup from a collar on the rim, liner_h (54 mm) tall, so its
// floor stands well above the cup's bottom. Water that runs through the soil
// collects in the gap underneath instead of soaking the roots. Lift the
// liner out to tip the water away.
//
// The collar is a flat lip on the cup's rim with a skirt down the
// outside of the cup, which centres it. A vine is debossed round the
// skirt. The liner drops through the collar's bore and hangs on a 45
// degree countersink by a flare round its top, flush with the collar.
//
// Two parts, because the skirt hangs down from the lip, so the collar
// can only print upside down, and the liner's floor would then be a
// bridge across the top of the print.
//
// Printing, all without supports:
//  - liner: upright, on its floor. The walls are vertical, the drain
//    holes are vertical and the flare's underside is 45 degrees.
//  - collar: upside down, its top face on the bed. The lip and skirt
//    are vertical, the countersink and chamfers are 45 degrees, and the
//    vine's grooves have 45 degree faces.
//
// Wall thicknesses lie in the layer plane and are set as a whole number
// of extrusion lines (see [Printing]).
//
// Model coordinates: z = 0 is the top of the cup's rim, and +Z is up.
// Set part = "mounted" to view the assembly with the cup as a ghost.
// All dimensions in mm.

/* [Output] */
// Which part(s) to render
part = "all"; // [all, liner, collar, mounted]

/* [Cup (measured)] */
// Inside diameter of the cup
cup_id = 56;
// Outside diameter of the cup at the rim
cup_od = 68;
// Inside depth, rim to floor
cup_depth = 69;
// Height of the inward curve at the bottom of the inside wall
cup_curve = 3;

/* [Printing] */
// Extrusion line width set in the slicer
line_w = 0.45;
// Layer height set in the slicer
layer_h = 0.28;

/* [Liner] */
// Gap from the liner to the cup's inside wall, each side
clearance = 1;
// Liner height overall, from its floor's underside to its top (flush with the collar's top)
liner_h = 54;
// Least water gap under the liner's floor (an assert checks it)
spacer = 8;
// Liner wall thickness, in lines
wall_lines = 4;
// Liner floor thickness, in layers
floor_layers = 5;
// Drain hole diameter
drain_d = 3;
// Spacing of the drain holes (hexagonal grid)
drain_pitch = 6.5;
// How far the flare round the liner's top reaches out
flare = 1.5;

/* [Collar] */
// Thickness of the lip that rests on the rim
lip_t = 3;
// How far the skirt reaches down the outside of the cup
skirt_h = 10;
// Gap from the skirt to the cup's outside
skirt_clearance = 0.75;
// Skirt thickness, in lines
skirt_lines = 5;
// Gap between the liner and the collar's bore
bore_clearance = 0.3;
// Chamfer on the lip's outer top edge
edge_chamfer = 1;
// Chamfer on the skirt's bottom edges and the bore's bottom edge
small_chamfer = 0.5;

/* [Vine] */
// Depth of the debossed vine
vine_depth = 0.6;
// Number of waves the stem makes round the skirt
vine_waves = 6;
// Height of the stem's waves (half the peak-to-peak)
vine_amp = 1.6;
// Leaf length
leaf_len = 5.5;
// Leaf width
leaf_w = 3.2;
// Leaf angle from the stem's direction
leaf_angle = 35;

/* [Hidden] */
$fn = 240;
eps = 0.01;

// Width of n lines, as the slicer lays them (they overlap)
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));

wall = lines(wall_lines);
floor_t = floor_layers * layer_h;
skirt_t = lines(skirt_lines);

r_l  = cup_id / 2 - clearance;      // liner outside
r_b  = r_l + bore_clearance;        // collar bore
r_si = cup_od / 2 + skirt_clearance;
r_so = r_si + skirt_t;
z_f  = lip_t - flare;               // where the liner's flare starts
z_lb = lip_t - liner_h;             // liner bottom

// Vine band on the skirt's outside
band_z0 = -skirt_h + small_chamfer + 1;
band_z1 = lip_t - edge_chamfer - 1;
vine_zc = (band_z0 + band_z1) / 2;

assert(r_b < cup_id / 2, "the collar's bore must be inside the cup's rim");
assert(r_l + flare > r_b + 0.5, "the flare must overlap the countersink");
assert(flare < lip_t - small_chamfer, "the countersink must fit in the lip");
assert(vine_depth < skirt_t - 1, "the vine must leave at least 1 mm of skirt");

assert(z_lb >= -cup_depth + spacer, "the liner is too tall for the cup; lower liner_h");

echo(str("liner ", 2 * r_l, " mm across, ", lip_t - z_lb, " mm tall; gap under it ",
         z_lb + cup_depth, " mm; soil ",
         lip_t - z_lb - floor_t, " mm deep; collar ", 2 * r_so, " mm across"));

// ---------------------------------------------------------------- liner

module liner_profile() {
    c = small_chamfer;
    polygon([
        [0, z_lb],
        [r_l - c, z_lb],
        [r_l, z_lb + c],
        [r_l, z_f],
        [r_l + flare, lip_t],
        [r_l + flare - wall, lip_t],
        [r_l - wall, z_f],
        [r_l - wall, z_lb + floor_t],
        [0, z_lb + floor_t],
    ]);
}

module drain_holes() {
    hr = r_l - wall - drain_d / 2 - 1.5;
    dy = drain_pitch * sqrt(3) / 2;
    n = ceil(hr / dy);
    for (j = [-n : n], i = [-n - 1 : n + 1]) {
        x = (i + (j % 2) / 2) * drain_pitch;
        y = j * dy;
        if (norm([x, y]) <= hr)
            translate([x, y, z_lb - 1])
                cylinder(d = drain_d, h = floor_t + 2, $fn = 12);
    }
}

module liner() {
    difference() {
        rotate_extrude(convexity = 10) liner_profile();
        drain_holes();
    }
}

// --------------------------------------------------------------- collar

module collar_profile() {
    c = small_chamfer;
    e = edge_chamfer;
    polygon([
        [r_b + c, 0],
        [r_si, 0],
        [r_si, -skirt_h + c],
        [r_si + c, -skirt_h],
        [r_so - c, -skirt_h],
        [r_so, -skirt_h + c],
        [r_so, lip_t - e],
        [r_so - e, lip_t],
        [r_l + flare, lip_t],
        [r_b, z_f + bore_clearance],
        [r_b, c],
    ]);
}

// One slice of a groove cutter at angle a (degrees) round the skirt and
// height z: a V (or, wider than twice the depth, a flat-bottomed
// trapezoid) with 45 degree faces, w wide at the surface.
module groove_slice(a, z, w) {
    d = min(vine_depth, w / 2);
    rotate([0, 0, a]) translate([0, 0, z]) rotate([90, 0, 0])
        linear_extrude(eps, center = true, convexity = 10)
            polygon([
                [r_so + 0.5, -w / 2 - 0.5],
                [r_so + 0.5, w / 2 + 0.5],
                [r_so - d, w / 2 - d],
                [r_so - d, -(w / 2 - d)],
            ]);
}

// Stem height at angle a
function stem_z(a) = vine_zc + vine_amp * sin(vine_waves * a);
// Stem slope (dz per mm round the skirt) at angle a
function stem_slope(a) = vine_amp * vine_waves * cos(vine_waves * a) / r_so;

stem_w = 2 * vine_depth;
stem_steps = 360;

module stem() {
    for (i = [0 : stem_steps - 1]) {
        a0 = i * 360 / stem_steps;
        a1 = (i + 1) * 360 / stem_steps;
        hull() {
            groove_slice(a0, stem_z(a0), stem_w);
            groove_slice(a1, stem_z(a1), stem_w);
        }
    }
}

// A lens-shaped leaf from the stem at angle a, turned up (side = 1) or
// down (side = -1) from the stem's direction.
module leaf(a, side) {
    steps = 16;
    dir = atan(stem_slope(a)) + side * leaf_angle;
    function pt(t) = [a + t * leaf_len * cos(dir) / r_so * 180 / PI,
                      stem_z(a) + t * leaf_len * sin(dir)];
    function wd(t) = max(stem_w, leaf_w * sin(180 * t)) / max(cos(dir), 0.5);
    tip_z = stem_z(a) + leaf_len * sin(dir);
    assert(tip_z + stem_w < band_z1 && tip_z - stem_w > band_z0,
           "a leaf runs off the vine's band; shorten leaf_len or lower leaf_angle");
    for (k = [0 : steps - 1]) {
        p0 = pt(k / steps);
        p1 = pt((k + 1) / steps);
        hull() {
            groove_slice(p0[0], p0[1], k == 0 ? stem_w : wd(k / steps));
            groove_slice(p1[0], p1[1], k == steps - 1 ? 0.2 : wd((k + 1) / steps));
        }
    }
}

module vine() {
    stem();
    // A leaf rising from each trough and one hanging from each crest, so
    // they alternate along the stem and fill the space beside it.
    for (k = [0 : vine_waves - 1]) {
        a = k * 360 / vine_waves;
        leaf(a + 360 / vine_waves * 0.25, -1);
        leaf(a + 360 / vine_waves * 0.75, 1);
    }
}

module collar() {
    difference() {
        rotate_extrude(convexity = 10) collar_profile();
        vine();
    }
}

// ---------------------------------------------------------------- cup

module cup() {
    rc = cup_curve;
    rotate_extrude(convexity = 10)
        difference() {
            translate([0, -cup_depth - 5]) square([cup_od / 2, cup_depth + 5]);
            hull() {
                translate([cup_id / 2 - rc, -cup_depth + rc]) circle(r = rc);
                translate([0, -cup_depth]) square([eps, cup_depth + 1]);
                translate([0, -cup_depth + rc]) square([cup_id / 2, cup_depth]);
            }
        }
}

// ---------------------------------------------------- print orientation

module liner_print() {
    translate([0, 0, -z_lb]) liner();
}

module collar_print() {
    translate([0, 0, lip_t]) mirror([0, 0, 1]) collar();
}

// ---------------------------------------------------------------- output

if (part == "mounted") {
    color("sienna", 0.35) %cup();
    color("olivedrab") collar();
    color("tan") liner();
} else if (part == "all") {
    liner_print();
    translate([r_l + flare + r_so + 10, 0, 0]) collar_print();
} else if (part == "liner") {
    liner_print();
} else if (part == "collar") {
    collar_print();
}
