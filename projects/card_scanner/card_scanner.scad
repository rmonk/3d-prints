// MTG card scanner: a phone shelf over a removable card box
// -------------------------------------------------------------
// Lay each card face up on the stack in the box. The phone's camera looks
// straight down at it from `cam_h` above the top of a full stack. The
// tower telescopes, so cam_h can be set anywhere from `cam_lo` (130 mm) to
// `cam_hi` (205 mm) and clamped there. Take the box out and push the stack
// up through the hole in its floor.
//
// Parts:
//   - box: open top, a push-out hole in the floor. Sits on the table
//     inside the base frame and lifts out. Vents round the bottom of its
//     walls let air out from under a dropping card, which the table
//     would otherwise trap.
//   - base: a low frame round the box (two rails and three crossbars) and
//     a socket for the sleeve, centred behind the box. The rails run back
//     under the whole phone, so pressing either end of it can't tip the
//     scanner.
//   - sleeve: a U-channel standing in the base socket, open at the back
//     (-X). 45 degree lips at its mouth hold the mast in. A crossbar at its
//     bottom is the mast's lowest stop. An M3 bolt in a captive nut, turned
//     by the knob, clamps the mast against the far wall.
//   - mast: a truss column that slides in the sleeve. Its top is a solid
//     tenon, `tenon_w` wide, flush with the column's -Y face. A scale on
//     its back reads cam_h at the sleeve's top edge.
//   - knob: a thumb wheel pressed onto the M3 bolt's socket head.
//   - shelf: no platform, just three rails the phone lies on, screen up,
//     `shelf_len` (120 mm) of it, its bottom end against a back stop and
//     between lips on the outer rails. The rest of the phone, with the
//     lenses, hangs off the front over the box, so any phone with its
//     lenses at the top works.
//     - Mounting: a block across the rails' undersides has three pockets,
//       left, centre and right, each walled on all four sides. The
//       tenon presses into one, so the shelf can sit where the lens comes
//       over the box (`shelf_pos`).
//   - Joints: the sleeve's foot in its socket and the tenon in a pocket
//     are press fits on all four sides, drawn size for size, with a 45
//     degree lead-in at each mouth.
//
// Coordinates (mounted): the table at z = 0, the lens over x = y = 0,
// +X toward the user, +Y to the user's right. The phone's top end points
// to +X, so the right of its face is toward -Y. The box is centred
// `box_dx` in front of the lens, the thickness the sleeve's floor adds.
//
// Print orientation:
//   - mast: on its side, -Y down, so the column bends along the layers.
//     Every part of it is a 2D side profile extruded up from the bed; the
//     tenon is flush with the bed side, so it needs no overhang.
//   - sleeve: on its floor (+X down), mouth up, so its bending also runs
//     along the layers. The lips lean in at 45 degrees.
//   - shelf: right side up, standing on its rails and the pocket block.
//     Each pocket's ceiling bridges across it.
//   - base, box and knob: flat, as mounted (the knob's head pocket up).

include <../../library/shapes.scad>

part = "mounted"; // [mounted, mast, sleeve, knob, shelf, base, box, none]
// Shelf position on the tower: -1 left, 0 centre, 1 right (seen from the
// front). Right suits lenses at the top right of the phone's face.
shelf_pos = 1;

/* [Phone] */
// iPhone 16 Pro in its case, as for the phone holder
phone_l = 153;
phone_w = 72;
phone_t = 11;
// Main camera lens centre from the case's top and side edges. Estimates:
// check them against the phone.
lens_from_top = 16.5;
lens_from_side = 16.5;
// How far the lens sits below the case's back (0: a case whose camera
// ring is flush, so the phone lies flat)
bump_proud = 0;
// Length of phone the shelf carries; the rest hangs off the front
shelf_len = 120;
// Gap round the phone at the stops
phone_clearance = 0.5;

/* [Height] */
// Distance from the top card (a full box) to the camera: the range the
// tower telescopes over, and the setting the mounted view shows
cam_lo = 130;
cam_hi = 205;
cam_h = 205;

/* [Cards and box] */
// Largest card the box takes: a double-sleeved card
card_w = 67;
card_l = 93;
// Smallest card the floor must hold: an unsleeved card
card_min_w = 63;
card_min_l = 88;
// Gap round the largest card
card_clearance = 1.5;
// Inside depth of the box
box_depth = 50;
box_floor = 1.4;
// How far each card edge must rest on the floor, at worst
floor_overlap = 3;
// Gap between the box and the base frame
box_clearance = 0.5;
// Vents through the walls just above the floor, so the air under a
// dropping card can get out (the table closes the push-out hole). Height
// to their pointed tops, width, and the solid between them.
vent_h = 20;
vent_w = 4;
vent_gap = 6;

/* [Tower and shelf] */
// Column depth (front to back) and width across (Y)
col_d = 30;
tower_w = 24;
// Height of the back stop and side lips above the shelf
stop_h = 4;
// Shelf rails: depth (the pockets are as deep, less their ceilings)
rail_d = 14;
// The pockets' ceilings
ceil_t = 3.5;
// Width of the tenon across (Y). Narrower than the column, so the three
// pockets, shelf_off apart, have walls between them.
tenon_w = 16;
// Press fits: gap round the tenon in its pocket and the foot in its
// socket, on all four sides. 0 is size for size; raise it if they're too
// tight to push home, lower it (negative) if they're loose.
pocket_clearance = 0;
socket_clearance = 0;
// 45 degree lead-in at the mouths of the pockets and the socket
lead_in = 1;
// Depth of the socket, and the height its 45 degree ledge carries the
// sleeve's foot at
socket_depth = 25;
ledge_z = 12;
ledge_w = 3;

/* [Sleeve and clamp] */
// Gap round the mast in the sleeve, on each face
sleeve_clearance = 0.2;
// 45 degree chamfers on the mast's back corners, which the sleeve's lips
// cover
mast_chamfer = 3.5;
// Width (X) of the mast's back chord, where the clamp bolt bears and the
// scale is
clamp_chord = 10;
// The sleeve's bottom stop, and how far below its top the clamp bolt is
stop_t = 4;
clamp_down = 10;
// M3 bolt (socket head) and nut
bolt_d = 3.4;          // hole
bolt_len = 12;         // 12-20 works; the fit checks use this
head_d = 5.5;
head_h = 3;
nut_af = 5.5;
nut_t = 2.4;
nut_clearance = 0.2;
// Knob
knob_d = 14;
knob_h = 5;
knob_floor = 2;
head_press = 0.1;      // the head pocket is this much under head_d
// Scale on the mast's back: a tick every scale_step, numbered every 25
scale_step = 5;
scale_depth = 0.5;

/* [Base] */
rail_h = 10;

/* [Lines] */
line_w = 0.45;
layer_h = 0.28;
chord_lines = 6;
web_lines = 4;
lip_lines = 4;
rail_lines = 4;
box_wall_lines = 3;
base_lines = 6;
sleeve_wall_lines = 6;
boss_lines = 4;

/* [Hidden] */
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));
cw = lines(chord_lines);
ww = lines(web_lines);
lw = lines(lip_lines);
rw = lines(rail_lines);
bwall = lines(box_wall_lines);
bw = lines(base_lines);
sw = lines(sleeve_wall_lines);
kw = lines(boss_lines);
eps = 0.01;

// Box
box_in = [card_l + 2 * card_clearance, card_w + 2 * card_clearance];
box_out = box_in + 2 * [bwall, bwall];
box_h = box_floor + box_depth;
// Push-out hole: an unsleeved card anywhere in the box still rests
// floor_overlap on the floor each side
hole = [card_min_l - (box_in[0] - card_min_l) - 2 * floor_overlap,
        card_min_w - (box_in[1] - card_min_w) - 2 * floor_overlap];
hole_r = 10;

// Phone and shelf (the lens is over x = y = 0)
function shelf_z_at(c) = box_h + c + bump_proud;
shelf_z = shelf_z_at(cam_h);               // the shelf's top face
phone_x1 = lens_from_top;                  // the case's top edge
phone_x0 = phone_x1 - phone_l;             // its bottom edge
shelf_x0 = phone_x0 - phone_clearance - cw; // back stop's outer face
shelf_x1 = phone_x0 + shelf_len;           // front edge
shelf_w = phone_w + 2 * phone_clearance + 2 * lw;
// Shelf offsets across the tower: the lens over the box's centre with the
// lenses at the right of the face (+1), centred (0) or at the left (-1)
shelf_off = phone_w / 2 - lens_from_side;
shelf_y = shelf_pos * shelf_off;
shelf_bot = shelf_z - rail_d;              // rail and pocket block bottoms

// Column: its front face clears the box by the sleeve's floor and the
// socket wall. The box moves forward by the floor, so the column and the
// shelf stay where they were on the fixed tower.
box_dx = sw + sleeve_clearance;
col_x1 = -box_out[0] / 2 - box_clearance - bw - socket_clearance;
col_x0 = col_x1 - col_d;
col_top = shelf_z - ceil_t;                // the tenon's top
socket_top = ledge_z + socket_depth;
tower_y0 = -tower_w / 2;
tower_y1 = tower_w / 2;
// The tenon, and the pockets under the shelf (y in the shelf's own
// frame, one per position)
tenon_y0 = tower_y0;
tenon_yc = tenon_y0 + tenon_w / 2;
pocket = [col_d + 2 * pocket_clearance, tenon_w + 2 * pocket_clearance];
pocket_ys = [for (p = [-1, 0, 1]) tenon_yc - p * shelf_off];
pocket_x0 = col_x0 - pocket_clearance;
block_x = [pocket_x0 - cw, pocket_x0 + pocket[0] + cw];
block_y = [min(pocket_ys) - pocket[1] / 2 - cw, max(pocket_ys) + pocket[1] / 2 + cw];

// Sleeve and mast. The mast is modelled at cam_lo, resting on the
// sleeve's bottom stop, and lifted by mast_lift for cam_h.
shelf_bot_lo = shelf_z_at(cam_lo) - rail_d;
sleeve_bot = ledge_z;
sleeve_top = shelf_bot_lo - 2;             // 2 mm under the shelf at cam_lo
mast_bot = sleeve_bot + stop_t;
mast_lift = cam_h - cam_lo;
sl_x = [col_x0 - sleeve_clearance, col_x1 + sleeve_clearance + sw];
sl_y = tower_w / 2 + sleeve_clearance + sw;
// Clamp: bolt axis on the flat of the back chord, near the sleeve's top
bolt_x = col_x0 + (mast_chamfer + clamp_chord) / 2;
bolt_z = sleeve_top - clamp_down;
nut_ac = nut_af / cos(30);
nut_slot = [nut_af + 2 * nut_clearance, nut_t + 2 * nut_clearance];
nut_bot_x = bolt_x + nut_ac / 2 + nut_clearance; // the slot's floor
boss_y = sl_y + nut_slot[1] + kw;          // the boss's outer face
boss_x = nut_bot_x + kw;
boss_hz = nut_slot[0] / 2 + kw;
knob_y = tower_w / 2 + bolt_len - knob_floor; // knob's face, bolt tip on the mast

assert(hole[0] > 30 && hole[1] > 30, "push-out hole too small");
assert(cam_lo <= cam_h && cam_h <= cam_hi, "cam_h must be in the range");
assert(shelf_x0 < block_x[0] && shelf_x1 > block_x[1], "the shelf must cover the tower");
assert(block_y[0] >= -shelf_w / 2 && block_y[1] <= shelf_w / 2, "the pockets must fit the shelf");
assert(tenon_w <= tower_w, "the tenon can't be wider than the column");
assert(shelf_off - pocket[1] >= 2 * lead_in + 1, "the pockets need walls between them");
assert(lead_in < bw - 0.5, "the lead-in must leave the socket wall");
assert(sleeve_top - (mast_bot + cam_hi - cam_lo) >= 55, "too little mast left in the sleeve at cam_hi");
assert(bolt_z + boss_hz <= sleeve_top, "the clamp boss must fit under the sleeve's top");
assert(bolt_z + knob_d / 2 < shelf_bot_lo - 1, "the knob must clear the shelf at cam_lo");
assert(bolt_z < shelf_bot_lo - cw && bolt_z > mast_bot + cam_hi - cam_lo,
       "the bolt must bear on the mast over the whole range");
assert(bolt_x - bolt_d / 2 > col_x0 + mast_chamfer && bolt_x + bolt_d / 2 < col_x0 + clamp_chord,
       "the bolt must bear on the flat of the back chord");
assert(knob_y > boss_y + 0.5, "bolt_len too short to reach the mast");
assert(col_top - mast_bot < 250 && sleeve_top - sleeve_bot < 250, "the mast and sleeve must fit the bed");

// 2D [x, z] profiles, extruded across Y from y0 to y1
module xz_prism(y0, y1)
  translate([0, y1, 0]) rotate([90, 0, 0])
    linear_extrude(y1 - y0, convexity = 10) children();

// A straight member of width w from p to q
module bar(p, q, w) {
  d = q - p;
  n = [-d[1], d[0]] / norm(d) * w / 2;
  polygon([p + n, q + n, q - n, p - n]);
}

// Mast truss, in [x, z], at cam_lo. The back chord is clamp_chord wide.
module column2d() {
  xa = col_x0 + clamp_chord - cw / 2;      // the web's ends
  xb = col_x1 - cw / 2;
  // Chords, from the foot to the shelf's underside
  translate([col_x0, mast_bot]) square([clamp_chord, shelf_bot_lo - mast_bot]);
  translate([col_x1 - cw, mast_bot]) square([cw, shelf_bot_lo - mast_bot]);
  // Bottom bar, and the top bar under the tenon
  translate([col_x0, mast_bot]) square([col_d, cw]);
  tz = shelf_bot_lo - cw;
  translate([col_x0, tz]) square([col_d, cw]);
  // Web: diagonals zig-zagging up from the bottom bar to the top bar
  n = max(1, round((tz - mast_bot) / 45));
  ph = (tz - mast_bot - cw / 2) / n;
  for (i = [0 : n - 1]) {
    z0 = mast_bot + cw / 2 + i * ph;
    bar([i % 2 == 0 ? xa : xb, z0], [i % 2 == 0 ? xb : xa, z0 + ph], ww);
  }
}

// The mast's cross-section in [x, y], grown by d: a rectangle with its
// back corners chamfered at 45 degrees
module mast_section(d = 0) {
  h = tower_w / 2;
  offset(delta = d)
    polygon([[col_x0, -h + mast_chamfer], [col_x0 + mast_chamfer, -h], [col_x1, -h],
             [col_x1, h], [col_x0 + mast_chamfer, h], [col_x0, h - mast_chamfer]]);
}

// Height on the mast (at cam_lo) that lines up with the sleeve's top when
// the camera is c above the stack
function scale_z(c) = sleeve_top - (c - cam_lo);

// Scale, engraved in the mast's back face: ticks at the viewer's left
// (+Y), numbers to their right, reading from behind
module scale_marks() {
  h = tower_w / 2 - mast_chamfer;
  for (c = [cam_lo : scale_step : cam_hi]) {
    long = c % 10 == 0;
    translate([col_x0 - 1, h - (long ? 7 : 4), scale_z(c) - 0.3])
      cube([1 + scale_depth, (long ? 7 : 4) + 1, 0.6]);
    if (c % 25 == 0 || c == cam_lo)
      // text x runs to -Y, its up to +Z, extruded to -X out of the face
      multmatrix([[0, 0, -1, col_x0 + scale_depth], [-1, 0, 0, h - 8], [0, 1, 0, scale_z(c)]])
        linear_extrude(scale_depth + 1, convexity = 10)
          text(str(c), size = 3.5, font = "Liberation Sans:style=Bold", valign = "center");
  }
}

module mast() {
  difference() {
    intersection() {
      xz_prism(tower_y0, tower_y1) column2d();
      translate([0, 0, mast_bot - 1]) linear_extrude(shelf_bot_lo - mast_bot + 2, convexity = 10)
        mast_section();
    }
    scale_marks();
  }
  // Tenon, solid, flush with the -Y face (the bed side in print)
  translate([col_x0, tenon_y0, shelf_bot_lo - eps])
    cube([col_d, tenon_w, rail_d - ceil_t + eps]);
}

// The sleeve's cross-section in [x, y]: a U round the mast, open at the
// back, with 45 degree lips over the mast's chamfers
module sleeve2d()
  difference() {
    translate([sl_x[0], -sl_y]) square([sl_x[1] - sl_x[0], 2 * sl_y]);
    mast_section(sleeve_clearance);
    translate([sl_x[0] - 1, -(tower_w / 2 - mast_chamfer)])
      square([1.5, tower_w - 2 * mast_chamfer]);
  }

module sleeve() {
  difference() {
    union() {
      translate([0, 0, sleeve_bot]) linear_extrude(sleeve_top - sleeve_bot, convexity = 10) sleeve2d();
      // Bottom stop, across the whole U
      translate([sl_x[0], -sl_y, sleeve_bot]) cube([sl_x[1] - sl_x[0], 2 * sl_y, stop_t]);
      // Clamp boss on the +Y wall, its lower end (in print) cut back at 45
      // degrees to the wall
      translate([0, 0, bolt_z - boss_hz]) linear_extrude(2 * boss_hz, convexity = 10)
        polygon([[sl_x[0], sl_y - eps], [sl_x[0], boss_y], [boss_x, boss_y],
                 [boss_x + boss_y - sl_y, sl_y - eps]]);
    }
    // Bolt hole, pointed toward the mouth (up in print)
    translate([bolt_x, tower_w / 2, bolt_z]) rotate([-90, 0, 0])
      linear_extrude(boss_y - tower_w / 2 + 1, convexity = 10)
        rotate(90) pointed_circle2d(bolt_d / 2, bolt_d / 2 * sqrt(2), $fn = 24);
    // Nut slot, open at the mouth, its walls on the nut's flats
    translate([sl_x[0] - 1, sl_y, bolt_z - nut_slot[0] / 2])
      cube([nut_bot_x - sl_x[0] + 1, nut_slot[1], nut_slot[0]]);
  }
}

// Knob, axis along +Z from its face on the boss
module knob() {
  n = floor(PI * knob_d / 5);
  difference() {
    cylinder(d = knob_d, h = knob_h, $fn = 64);
    for (i = [0 : n - 1])
      rotate(i * 360 / n) translate([knob_d / 2 + 0.4, 0, -1]) cylinder(r = 1.2, h = knob_h + 2, $fn = 24);
    translate([0, 0, -1]) cylinder(d = bolt_d, h = knob_h + 2, $fn = 32);
    translate([0, 0, knob_floor]) cylinder(d = head_d - head_press, h = knob_h, $fn = 32);
  }
}

// The bolt, tip on the mast, and the knob on its head, mounted
module bolt()
  translate([bolt_x, tower_w / 2, bolt_z]) rotate([-90, 0, 0]) {
    cylinder(d = 3, h = bolt_len, $fn = 24);
    translate([0, 0, bolt_len]) cylinder(d = head_d, h = head_h, $fn = 32);
  }
module knob_mounted()
  translate([bolt_x, knob_y, bolt_z]) rotate([-90, 0, 0]) knob();

// Shelf, mounted at shelf_y across: rails, back stop, lips and the pocket
// block, and no platform
module shelf() {
  ys = [-shelf_w / 2, shelf_w / 2];
  translate([0, shelf_y, 0]) difference() {
    union() {
      // Rails along X: one under each lip and one down the middle
      for (y = [ys[0], -rw / 2, ys[1] - lw])
        translate([shelf_x0, y, shelf_bot]) cube([shelf_x1 - shelf_x0, y == -rw / 2 ? rw : lw, rail_d]);
      // Lips on the outer rails
      for (y = [ys[0], ys[1] - lw])
        translate([shelf_x0, y, shelf_z - eps]) cube([shelf_x1 - shelf_x0, lw, stop_h + eps]);
      // Back stop, down to the bed so it ties the rails' back ends, and a
      // crossbar tying their front ends, flush with the rails' tops
      translate([shelf_x0, ys[0], shelf_bot]) cube([cw, shelf_w, rail_d + stop_h]);
      translate([shelf_x1 - cw, ys[0], shelf_bot]) cube([cw, shelf_w, rail_d]);
      // Pockets' walls and ceilings: a shell round each, and their front
      // and back walls carried across the full width to the outer rails
      for (y = pocket_ys)
        translate([block_x[0], y - pocket[1] / 2 - cw, shelf_bot])
          cube([block_x[1] - block_x[0], pocket[1] + 2 * cw, rail_d]);
      for (x = [block_x[0], block_x[1] - cw])
        translate([x, ys[0], shelf_bot]) cube([cw, shelf_w, rail_d]);
    }
    // Pockets, walled on all four sides, each with a 45 degree lead-in
    for (y = pocket_ys) translate([pocket_x0, y - pocket[1] / 2, 0]) {
      translate([0, 0, shelf_bot - 1]) cube([pocket[0], pocket[1], col_top - shelf_bot + 1]);
      hull() {
        translate([0, 0, shelf_bot + lead_in]) cube([pocket[0], pocket[1], eps]);
        translate([-lead_in - 1, -lead_in - 1, shelf_bot - 1])
          cube([pocket[0] + 2 * lead_in + 2, pocket[1] + 2 * lead_in + 2, eps]);
      }
    }
  }
}

// --- Base ---
sock = [sl_x[1] - sl_x[0] + 2 * socket_clearance, 2 * sl_y + 2 * socket_clearance];
sock_c = [(sl_x[0] + sl_x[1]) / 2, 0];
boss = sock + 2 * [bw, bw];
frame_in = [box_out[0] / 2 + box_clearance, box_out[1] / 2 + box_clearance];
rail_x0 = shelf_x0;                        // under the phone's bottom end

module base() {
  difference() {
    union() {
      // Socket boss
      translate([sock_c[0] - boss[0] / 2, sock_c[1] - boss[1] / 2, 0])
        cube([boss[0], boss[1], socket_top]);
      // Rails, from under the phone's bottom end to the front crossbar
      for (s = [-1, 1])
        translate([rail_x0, s > 0 ? frame_in[1] : -frame_in[1] - bw, 0])
          cube([box_dx + frame_in[0] + bw - rail_x0, bw, rail_h]);
      // Crossbars at the rails' back ends, behind the box and in front of it
      for (x = [rail_x0, box_dx - frame_in[0] - bw, box_dx + frame_in[0]])
        translate([x, -frame_in[1] - bw, 0]) cube([bw, 2 * (frame_in[1] + bw), rail_h]);
    }
    // Socket, with a 45 degree lead-in at its mouth, narrowing at 45
    // degrees to a ledge the foot stands on
    translate([sock_c[0], sock_c[1], 0]) {
      translate([-sock[0] / 2, -sock[1] / 2, ledge_z]) cube([sock[0], sock[1], socket_depth + 1]);
      hull() {
        translate([-sock[0] / 2, -sock[1] / 2, socket_top - lead_in]) cube([sock[0], sock[1], eps]);
        translate([-sock[0] / 2 - lead_in - 1, -sock[1] / 2 - lead_in - 1, socket_top + 1])
          cube([sock[0] + 2 * lead_in + 2, sock[1] + 2 * lead_in + 2, eps]);
      }
      hull() {
        translate([-sock[0] / 2, -sock[1] / 2, ledge_z]) cube([sock[0], sock[1], eps]);
        translate([-sock[0] / 2 + ledge_w, -sock[1] / 2 + ledge_w, ledge_z - ledge_w])
          cube([sock[0] - 2 * ledge_w, sock[1] - 2 * ledge_w, eps]);
      }
      translate([-sock[0] / 2 + ledge_w, -sock[1] / 2 + ledge_w, -1])
        cube([sock[0] - 2 * ledge_w, sock[1] - 2 * ledge_w, ledge_z - ledge_w + 1 + eps]);
    }
  }
}

// --- Box ---
module rrect(size, r)
  offset(r) square(size - 2 * [r, r], center = true);

// A vent's outline in [along the wall, z]: from the floor, pointed at the
// top so it prints upright
module vent2d()
  polygon([[-vent_w / 2, box_floor], [vent_w / 2, box_floor],
            [vent_w / 2, box_floor + vent_h - vent_w / 2],
            [0, box_floor + vent_h], [-vent_w / 2, box_floor + vent_h - vent_w / 2]]);

// Vents along a wall of inside length len, centred, keeping clear of the
// corners
module vent_row(len) {
  pitch = vent_w + vent_gap;
  n = floor((len - 2 * vent_gap) / pitch);
  for (i = [0 : n - 1])
    translate([(i - (n - 1) / 2) * pitch, 0]) vent2d();
}

module box() {
  difference() {
    translate([-box_out[0] / 2, -box_out[1] / 2, 0]) cube([box_out[0], box_out[1], box_h]);
    translate([-box_in[0] / 2, -box_in[1] / 2, box_floor]) cube([box_in[0], box_in[1], box_h]);
    translate([0, 0, -1]) linear_extrude(box_floor + 2, convexity = 10) rrect(hole, hole_r);
    // Long walls (along X), then short walls (along Y)
    translate([0, box_out[1] / 2 + 1, 0]) rotate([90, 0, 0])
      linear_extrude(box_out[1] + 2, convexity = 10) vent_row(box_in[0]);
    translate([box_out[0] / 2 + 1, 0, 0]) rotate([90, 0, -90])
      linear_extrude(box_out[0] + 2, convexity = 10) vent_row(box_in[1]);
  }
}

// --- For fit checks and the mounted view ---
lens = [0, 0, shelf_z - bump_proud];

// The phone, on the shelf at shelf_y
module phone()
  translate([phone_x0, shelf_y - phone_w / 2, shelf_z]) cube([phone_l, phone_w, phone_t]);

// What the camera must see: the largest card at the bottom of the box
module view_cone()
  hull() {
    translate(lens - [0, 0, 0.2]) cube(0.1, center = true);
    translate([box_dx - card_l / 2, -card_w / 2, box_floor + eps]) cube([card_l, card_w, eps]);
  }

if (part == "mounted") {
  color("lightgray") base();
  color("slategray") sleeve();
  color("steelblue") translate([0, 0, mast_lift]) mast();
  color("lightsteelblue") shelf();
  color("dimgray") { knob_mounted(); bolt(); }
  color("wheat") translate([box_dx, 0, 0]) box();
  %phone();
} else if (part == "mast") {
  // On its side, -Y down
  translate([0, 0, -tower_y0]) rotate([90, 0, 0]) mast();
} else if (part == "sleeve") {
  // On its floor, +X down, mouth up
  translate([0, 0, sl_x[1]]) rotate([0, 90, 0]) sleeve();
} else if (part == "knob") {
  // Flat, head pocket up
  knob();
} else if (part == "shelf") {
  // Right side up, on its ribs
  translate([0, -shelf_y, -shelf_bot]) shelf();
} else if (part == "base") {
  base();
} else if (part == "box") {
  box();
}

echo(str("shelf top ", shelf_z, ", lens to full stack ", lens[2] - box_h,
         " (range ", cam_lo, "-", cam_hi, "), mast ", col_top - shelf_z + shelf_z_at(cam_lo) - mast_bot,
         " long, sleeve ", sleeve_top - sleeve_bot, ", overlap at cam_hi ",
         sleeve_top - (mast_bot + cam_hi - cam_lo), ", push-out hole ", hole[0], " x ", hole[1],
         ", shelf offsets +-", shelf_off));
