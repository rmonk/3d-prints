// Suction Cup Bird Feeder
// -------------------------------------------------------------
// The user's Mk2 bird feeder (suction_cup_bird_feeder_original.stl),
// reworked in two ways:
//
//  - The keyholes in the two cup towers are replaced by the shared
//    T-slot from suction_cup.scad. Each slot opens through the bottom
//    of its tower, so the feeder hangs on the knobs and gravity keeps
//    it seated. Fit the cups first: push each knob up into its slot
//    from below, then press both cups onto the glass together.
//  - A window is cut in the back wall (the side facing the glass), and
//    a separate panel, printed in clear filament, slides down into
//    rails on the outside of it, so the seed level can be seen from
//    indoors. The panel rests on a ledge at the bottom; lips on the
//    rails and a strip along the bottom hold it against the seed.
//    Lift it out from the top to clean it.
//
// The centre spacer ridge that rested on the glass sat where the panel
// goes, so it is replaced by two identical ridges either side of it.
//
// Designed to print with no supports, standing upright as the original
// does:
//  - the cup slots are vertical channels with 45 degree pointed tops
//  - the rails and channel are vertical, open at the top
//  - the window has 45 degree top corners and only a short bridge
//    across its top, under the original 45 degree fin
//  - the panel prints flat
// Set part = "mounted" to view the feeder with the panel fitted.
// The suction cup sizes are shared with the other mounts in
// suction_cup.scad. All dimensions in mm.

include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "all"; // [all, feeder, panel, mounted]

/* [Suction Cups] */
// Height of the cup centre (where the knob rests) above the bottom
cup_z = 38.5;
// Material behind the head pocket
roof_thickness = 2.5;

/* [Window] */
// Width of the window at the bottom
win_w = 60;
// Width of the flat bridge across the top (the corners are 45 degrees)
win_bridge = 10;
// Height of the window's bottom edge above the bottom (floor top is 3)
win_bottom = 4;
// Height of the window's top (the fin inside starts at 40.4)
win_top = 38.4;

/* [Panel] */
// Thickness of the clear panel
panel_t = 2;
// Clearance around the panel in its channel (per side)
panel_clearance = 0.3;
// How far the panel extends past each side of the window
panel_cover = 5;
// How far the rail lips overlap the panel's edges
panel_lip = 3;
// Thickness of the rail lips
lip_t = 2;
// Rail wall beyond the panel's edges
rail_wall = 2.5;
// Height of the ledge the panel stands on
ledge_h = 2;
// How far the panel sticks up above the rails, to grip it by
panel_grip = 3;

/* [Spacers] */
// Distance of each spacer ridge from the centre
spacer_x = 53;
// Width of each spacer ridge at its base (its sides are 45 degrees)
spacer_w = 20;

/* [Hidden] */
$fn = 64;

// ---------- measured from the original STL ----------
// The STL is in print orientation: X along the feeder, -Y toward the
// glass, Z up. Values that new faces must be flush with are the exact
// float32 values from the file.
stl_file     = "suction_cup_bird_feeder_original.stl";
stl_x0       = -85;                   // left end
stl_x1       = 101.30000305175781;    // right end
stl_bed      = 4.307665250842313e-15; // the bottom face, not quite 0
stl_face_y   = -87.4;                 // front of the cup towers
stl_wall_y   = -69.4;                 // outside of the back wall
stl_wall_in  = -67.4;                 // inside of the back wall
stl_glass_y  = -94.4;                 // tip of the spacer ridge
old_ridge_w  = 20;                    // the centre spacer ridge (10 high)
tower_w      = 25;
tower_h      = 50;
tower_wall   = 3;
tower_back_y = -70.4;                 // back of the hollow in each tower
rail_top     = 50;                    // rails stop below the wall top (50.4)

// ---------- derived values ----------
// Model coordinates (mounted orientation): x along the feeder with the
// centre at 0, y up with the cup centres at 0, z away from the glass
// with the tower fronts at 0.
xc         = (stl_x0 + stl_x1) / 2;
cup_x      = (stl_x1 - stl_x0) / 2 - tower_w / 2;   // cup centres at x = +-cup_x
cup_spacing = 2 * cup_x;
y_bed      = stl_bed - cup_z;   // computed as the import's bottom is, so they're flush
wall_z     = stl_wall_y - stl_face_y;
wall_in_z  = stl_wall_in - stl_face_y;
glass_z    = stl_glass_y - stl_face_y;
tower_t    = floor_t + pocket_h + roof_thickness;   // solid part around the slot
tower_back = tower_back_y - stl_face_y;
tower_cut  = wall_z - 0.6;    // the old towers are cut off here, inside the wall
tower_end  = wall_z - 0.1;    // the new towers reach into the wall up to here

// Panel channel, just outside the back wall
panel_w    = win_w + 2 * panel_cover;
ch_back    = wall_z - 0.1;
ch_front   = ch_back - panel_t - 2 * panel_clearance;
ch_half    = panel_w / 2 + panel_clearance;
rail_half  = ch_half + rail_wall;
rail_front = ch_front - lip_t;
panel_h    = rail_top + panel_grip - ledge_h;

// ---------- helpers ----------
// The original, in model coordinates
module original() {
    rotate([90, 0, 180])
        translate([-xc, -stl_face_y, -cup_z])
            import(stl_file, convexity = 10);
}

// Box in model coordinates from corner to corner
module box(p0, p1) { translate(p0) cube(p1 - p0); }

module window2d() {
    y0 = win_bottom + y_bed;
    y1 = win_top + y_bed;
    polygon([[-win_w / 2, y0], [win_w / 2, y0],
             [win_w / 2, y1 - (win_w - win_bridge) / 2], [win_bridge / 2, y1],
             [-win_bridge / 2, y1], [-win_w / 2, y1 - (win_w - win_bridge) / 2]]);
}

// Panel outline, with its bottom at y = 0
module panel2d() {
    c = 1;   // chamfer on the bottom corners, to start it in the rails
    polygon([[-panel_w / 2 + c, 0], [panel_w / 2 - c, 0], [panel_w / 2, c],
             [panel_w / 2, panel_h], [-panel_w / 2, panel_h], [-panel_w / 2, c]]);
}

// ---------- feeder (mounted orientation) ----------
module tower(x) {
    difference() {
        box([x - tower_w / 2, y_bed, 0], [x + tower_w / 2, y_bed + tower_h, tower_end]);
        // hollow behind the slot, open top and bottom like the original
        box([x - tower_w / 2 + tower_wall, y_bed - 1, tower_t],
            [x + tower_w / 2 - tower_wall, y_bed + tower_h + 1, tower_back]);
    }
}

// A 45 degree ridge from the glass into the back wall. Built from a
// square on its corner, cut off at the bottom, so its base is exactly
// flush with the original's (a 2D polygon would be rounded slightly).
module spacer(x) {
    intersection() {
        box([x - spacer_w / 2, y_bed, glass_z], [x + spacer_w / 2, y_bed + spacer_w, wall_z + 1]);
        translate([x, y_bed, glass_z]) rotate(45)
            translate([-spacer_w / 2 / sqrt(2), -spacer_w / 2 / sqrt(2), 0])
                cube([spacer_w / sqrt(2), spacer_w / sqrt(2), wall_z + 1 - glass_z]);
    }
}

module feeder() {
    difference() {
        union() {
            difference() {
                original();
                // the old towers with their keyholes
                for (s = [-1, 1])
                    box([s * cup_x - tower_w / 2 - 1, y_bed - 1, -10],
                        [s * cup_x + tower_w / 2 + 1, y_bed + tower_h + 1, tower_cut]);
                // the old centre spacer ridge (the rail block fills in behind)
                box([-old_ridge_w / 2 - 1, y_bed - 1, glass_z - 1],
                    [old_ridge_w / 2 + 1, y_bed + old_ridge_w / 2 + 0.5, wall_z - 0.05]);
            }
            for (s = [-1, 1]) {
                tower(s * cup_x);
                spacer(s * spacer_x);
            }
            // rails and ledge, reaching 1 mm into the back wall
            box([-rail_half, y_bed, rail_front], [rail_half, rail_top + y_bed, wall_z + 1]);
        }
        for (s = [-1, 1])
            translate([s * cup_x, 0, 0]) cup_slot(y_bed);
        // panel channel, open at the top
        box([-ch_half, y_bed + ledge_h, ch_front], [ch_half, rail_top + y_bed + 1, ch_back]);
        // opening in front of the panel, between the lips and above the bottom strip
        box([-panel_w / 2 + panel_lip, y_bed + win_bottom, rail_front - 1],
            [panel_w / 2 - panel_lip, rail_top + y_bed + 1, ch_front + 0.01]);
        // the window through the back wall
        translate([0, 0, ch_back - 0.5])
            linear_extrude(wall_in_z + 1 - ch_back, convexity = 10) window2d();
    }
}

// ---------- panel (print orientation, flat) ----------
module panel() {
    linear_extrude(panel_t, convexity = 10) panel2d();
}

// ---------- output ----------
// Feeder upright, as the original prints
module feeder_print() { translate([0, 0, cup_z]) rotate([-90, 0, 0]) rotate([0, 0, 180]) feeder(); }

if (part == "mounted") {
    feeder();
    color("lightblue", 0.6)
        translate([0, y_bed + ledge_h, ch_front + panel_clearance])
            panel();
} else {
    if (part == "all" || part == "feeder")
        feeder_print();
    if (part == "all" || part == "panel")
        translate([0, part == "all" ? glass_z - 10 - panel_h : 0, 0]) panel();
}
