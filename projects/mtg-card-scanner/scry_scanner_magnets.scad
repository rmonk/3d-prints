// ScryScanner MTG card scanner: magnet pockets resized for other magnets
// -------------------------------------------------------------
// The scanner is "ScryScanner - MTG Card Scanner / TCG Scanner" by
// BrownBearDesign (MakerWorld, Standard Digital File License). This file
// imports its parts, extracted from ScryScanner.3mf by scry_3mf.py into
// original/, and changes only the magnet pockets:
//
//   - Lid and body top: 15 x 2 mm discs -> 18 x 2 mm discs. The new
//     pockets are wider than the old ones and cover them.
//   - Tray insert and the body's tray cavity: 20 x 5 x 2 mm bars -> 10 x 3
//     mm discs, one per bar, about the same volume of magnet. There's a
//     slot in each end of the insert and in each end wall of the cavity.
//     The old slots are filled and a round pocket is cut in their place.
//
// lighten_body and lighten_lid hollow the body and lid, which are mostly
// solid, leaving every outside face, hole, socket and pocket as it was:
//
//   - Body, card ramp block: ramp_channels voids run down the ramp, each
//     with a 45 degree gable roof that follows the ramp's 15 degree slope
//     skin_t under it, with ribs between them.
//   - Body, column end block: a void each side of the central square holes,
//     joined by a tunnel under the end-face hole, all with 45 degree roofs.
//   - With open_bottom, the body's voids open through its underside.
//   - Lid: pockets in its underside, between ribs. The lid prints upside
//     down, so they open upward in print; the phone face is the first
//     layers on the bed.
//
// Hollowing only saves filament where it removes more infill than the
// perimeters and skins it adds. At 2 perimeters and 10% infill (0.45 mm
// lines, 0.2 mm layers), a rough estimate gives, for the body: one open
// void ~145 g, two open ~148 g, one closed ~156 g, as printed ~164 g, four
// closed ~172 g. The lid's pockets add ~4 g, so lighten_lid is off.
//
// The load is small: a phone on the lid, carried by the two columns into
// the end block. The column sockets keep wall_lines of wall all round.
//
// Coordinates are each part's own, as stored in the 3MF; scry_3mf.py puts
// the edited meshes back with the original plate placement. The body and
// insert print with +Z up, the lid upside down.

// column and column_2 are the lid's support dowels, unchanged
part = "body"; // [body, lid, insert, column, column_2, none]
// Hollow the body (see above) and the lid
lighten_body = true;
lighten_lid = false;

/* [Lid magnets] */
lid_mag_d = 18;
lid_mag_t = 2;
// Pocket centres, x = +-lid_mag_x (the old pockets were at y 83.5)
lid_mag_x = 20;
lid_mag_y = 83.75;

/* [Tray insert magnets] */
tray_mag_d = 10;
tray_mag_t = 3;

/* [Fit] */
// Added to the magnet diameter (the original pockets were 0.22 over)
mag_clearance = 0.25;
// Added to the magnet thickness (the original pockets were 0.125 deeper)
mag_depth_clearance = 0.15;

/* [Lightening] */
// Slicer line width and layer height, for whole-line wall thicknesses
line_w = 0.45;
layer_h = 0.2;
// Walls between a void and any outside face, hole or socket
wall_lines = 8;
// Ribs between the ramp channels and in the lid
rib_lines = 4;
// Rim round the lid's edges, window, holes and key post
lid_rim_lines = 10;
// Material over a void's roof
skin_t = 3;
// Open the body's voids through its underside, or close them with floor_t
open_bottom = true;
floor_t = 1.4;
// The lid's phone face over its pockets
lid_skin_t = 2;
// Ramp voids across the block, and the lid's rib spacing
ramp_channels = 1;
lid_rib_pitch = 30;

/* [Hidden] */
include <../../library/shapes.scad>

$fn = 96;
eps = 0.01;

// Orca's overlapping lines: n lines are this thick
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));
wall = lines(wall_lines);
rib = lines(rib_lines);
lid_rim = lines(lid_rim_lines);

// Original faces and slots, read from the meshes
body_top = 37.5;            // body top, where the lid magnets' pockets open
lid_face = 2.45;            // lid underside, where its pockets open
lid_old_r = 7.62;           // old disc pockets, centred at (+-20, 83.5)
lid_old_y = 83.5;
// Old bar slots: [x0, x1], [z0, z1], the same at both ends of a part
body_slot = [[39.0196, 44.0196], [4.875, 24.125]];
insert_slot = [[30.3946, 35.3946], [4.555, 23.805]];
// Faces they open through: [y, direction the slot runs into the part]
body_slot_faces = [[72.25, 1], [-21.25, -1]];     // the tray cavity's end walls
insert_slot_faces = [[-46.375, 1], [46.375, -1]]; // the insert's end faces
slot_depth = 2.125;
// Body (for the voids)
body_bottom = -37.5;
body_x = 48.5;                  // the long sides, at their innermost (upper) face
body_end_y = 95.75;             // the two end faces, y = +-body_end_y
cavity_y = [-21.25, 72.25];     // the tray cavity's end walls
// The ramp top across its middle: z = ramp_z0 - ramp_slope * (y + 30),
// from y -92 to -26. It curves up to the sides, so this is its lowest.
ramp_z0 = 19.849;
ramp_slope = 0.26843;
storage_x = 33.6;               // inner edge of the column storage tubes in the ramp block
// End block features: the square socket from the top and the hole in the
// end face are both x +-7.5. The end-face hole's floor is at z 5.5. The
// column sockets are 14 mm round (x 33 to 47) above z -2.4.
square_x = 7.5;
end_hole_z = 5.5;
socket_x = 33;
// Lid (for its pockets)
lid_top = 12.45;                // the phone face
lid_mid = 7.45;                 // a plane through the plate, for its outline
post = [[-7.45, 7.45], [75.55, 90.45]];  // the key post under the lid

lid_pocket_r = (lid_mag_d + mag_clearance) / 2;
lid_pocket_h = lid_mag_t + mag_depth_clearance;
tray_pocket_r = (tray_mag_d + mag_clearance) / 2;
tray_pocket_h = tray_mag_t + mag_depth_clearance;

assert(norm([lid_mag_x - 20, lid_mag_y - lid_old_y]) + lid_old_r < lid_pocket_r,
       "the new lid magnet pockets must cover the old ones");
assert(lid_pocket_h >= slot_depth, "the lid magnet pockets must be at least as deep as the old ones");

module disc_pockets(face, dir) {
    // dir = -1 cuts down from a top face, +1 up from an underside
    for (sx = [-1, 1])
        translate([sx * lid_mag_x, lid_mag_y, face + dir * lid_pocket_h / 2 - dir * eps])
            cylinder(r = lid_pocket_r, h = lid_pocket_h + 2 * eps, center = true);
}

// Bar slots filled in, and a disc pocket cut at each one's centre. faces
// lists [y, dir]: the slot opens through the face at y and runs dir * y
// into the part. The pockets lie sideways in print, so they're pointed at
// the top.
module reslot(slot, faces) {
    cx = (slot[0][0] + slot[0][1]) / 2;
    cz = (slot[1][0] + slot[1][1]) / 2;
    difference() {
        union() {
            children();
            // Flush with the face, and 0.5 mm into the material round the slot
            for (f = faces)
                translate([slot[0][0] - 0.5, f[0] + min(0, f[1] * (slot_depth + 0.5)), slot[1][0] - 0.5])
                    cube([slot[0][1] - slot[0][0] + 1, slot_depth + 0.5, slot[1][1] - slot[1][0] + 1]);
        }
        // Extruded toward -y, from the floor (dir 1) or from 1 mm outside
        // the face (dir -1), so the point stays up either way
        for (f = faces)
            translate([cx, f[0] + (f[1] > 0 ? tray_pocket_h : 1), cz])
                rotate([90, 0, 0])
                    linear_extrude(tray_pocket_h + 1, convexity = 10)
                        pointed_circle2d(tray_pocket_r, 2 * tray_pocket_r);
    }
}

// A void with a 45 degree gable roof along y: x0..x1 across, from z = zb
// up to a ridge at r0 (y = y0) and r1 (y = y1). With a sloping ridge, the
// roof faces are steeper than 45 degrees.
module gable_y(x0, x1, y0, y1, zb, r0, r1) {
    h = (x1 - x0) / 2;
    hull()
        for (p = [[y0, r0], [y1, r1]])
            translate([0, p[0], 0])
                rotate([-90, 0, 0])
                    linear_extrude(eps, convexity = 10)
                        // in the extrusion's 2D frame, y is -z
                        polygon([[x0, -zb], [x1, -zb], [x1, -(p[1] - h)], [(x0 + x1) / 2, -p[1]],
                                 [x0, -(p[1] - h)]]);
}

// The same with the ridge along x, y0..y1 across
module gable_x(x0, x1, y0, y1, zb, ridge) {
    h = (y1 - y0) / 2;
    translate([x0, 0, 0])
        rotate([90, 0, 90])
            linear_extrude(x1 - x0, convexity = 10)
                polygon([[y0, zb], [y1, zb], [y1, ridge - h], [(y0 + y1) / 2, ridge], [y0, ridge - h]]);
}

function ramp_top(y) = ramp_z0 - ramp_slope * (y + 30);

module body_voids() {
    zb = open_bottom ? body_bottom - 1 : body_bottom + floor_t;
    // Card ramp block: channels down the slope
    x0 = -body_x + wall;
    x1 = storage_x - wall;
    y0 = -body_end_y + wall;
    y1 = cavity_y[0] - wall;
    w = (x1 - x0 - (ramp_channels - 1) * rib) / ramp_channels;
    assert(ramp_top(y1) - skin_t - w / 2 > zb + 10, "the ramp channels are too wide for the block");
    for (i = [0 : ramp_channels - 1])
        gable_y(x0 + i * (w + rib), x0 + i * (w + rib) + w, y0, y1, zb,
                ramp_top(y0) - skin_t, ramp_top(y1) - skin_t);
    // Column end block: a void each side, under the lid magnets' pockets...
    ey0 = cavity_y[1] + wall;
    ey1 = body_end_y - wall;
    for (s = [-1, 1])
        mirror([s < 0 ? 1 : 0, 0, 0])
            gable_y(square_x + wall, socket_x - wall, ey0, ey1, zb,
                    body_top - lid_pocket_h - skin_t, body_top - lid_pocket_h - skin_t);
    // ...joined by a tunnel under the end-face hole. It's inset from the side
    // voids' walls and floor (1 mm at the ends, 0.3 mm elsewhere), because
    // faces flush with theirs leave zero-area slivers in the mesh.
    gable_x(-(socket_x - wall - 1), socket_x - wall - 1, ey0 + 0.3, ey1 - 0.3, zb + 0.3,
            end_hole_z - skin_t);
}

module body() {
    difference() {
        reslot(body_slot, body_slot_faces) import("original/scry_body.stl", convexity = 10);
        disc_pockets(body_top, -1);
        if (lighten_body) body_voids();
    }
}

// The lid's underside pockets, in plan: the plate's outline shrunk by the
// rim (which keeps it off the edges, window and column holes), less the
// magnet pockets and key post with a rim round them, less the ribs.
module lid_pockets2d() {
    difference() {
        offset(r = -lid_rim)
            projection(cut = true)
                translate([0, 0, -lid_mid]) import("original/scry_lid.stl", convexity = 10);
        for (sx = [-1, 1])
            translate([sx * lid_mag_x, lid_mag_y]) circle(lid_pocket_r + lid_rim);
        translate([post[0][0] - lid_rim, post[1][0] - lid_rim])
            square([post[0][1] - post[0][0] + 2 * lid_rim, post[1][1] - post[1][0] + 2 * lid_rim]);
        for (i = [-3 : 3])
            translate([i * lid_rib_pitch - rib / 2, -200]) square([rib, 400]);
        for (j = [-6 : 6])
            translate([-200, j * lid_rib_pitch - rib / 2]) square([400, rib]);
    }
}

module lid() {
    difference() {
        import("original/scry_lid.stl", convexity = 10);
        disc_pockets(lid_face, 1);
        if (lighten_lid)
            translate([0, 0, lid_face - 1])
                linear_extrude(lid_top - lid_skin_t - lid_face + 1, convexity = 10)
                    lid_pockets2d();
    }
}

module insert() {
    reslot(insert_slot, insert_slot_faces) import("original/scry_insert.stl", convexity = 10);
}

if (part == "body") body();
else if (part == "lid") lid();
else if (part == "insert") insert();
// The lid's support dowels have no magnets; they're included as they are
else if (part == "column") import("original/scry_column.stl", convexity = 10);
else if (part == "column_2") import("original/scry_column_2.stl", convexity = 10);
