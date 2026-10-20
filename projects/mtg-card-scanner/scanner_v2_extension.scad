// MTG card scanner V2.3: the body 50 mm taller, and a slide with taller
// side walls
// -------------------------------------------------------------
// The scanner is ScannerV2.3_profile.3mf (not ours, and not committed).
// scanner_v2_3mf.py extracts its parts into original_v2/ in their own
// coordinates, which are the assembled orientation: +Y up, the base plate
// at y = -65 and the phone platform, a 2 mm plate, at y = 63..65.
//
// Body (part="body"): the scanner with its phone platform `raise` (50 mm)
// higher, so the phone is further from the cards, for better focus.
//
//   - Unchanged below stretch_y0 (22): the base plate, the box pocket and
//     the slot in the dividing wall that the slide's leg goes into (y 4.8
//     to 15.2, its surround up to y 19).
//   - Stretched: the frame between stretch_y0 and the platform's
//     underside is scaled up the Y axis to fill the extra height. A
//     stretch keeps every strut straight, so the frame stays braced the
//     same way, and the diagonals grow thicker as they get steeper.
//   - Moved: the platform, unchanged, `raise` higher.
//   - Print: as the original, on its lattice face (+Z on the bed).
//
// Slide (part="slide"): the card ramp, with its edge rails raised from
// 2 mm to `slide_wall_h` above the ramp, so cards stay on it.
//
//   - Print: on its edge (-X on the bed), like the original, so the layer
//     lines run down the ramp and the cards slide along them.
//   - -X wall: square to the ramp, solid down to the bed.
//   - +X wall: it's at the top of the print, so a square wall would be a
//     ceiling. It leans out at 45 degrees from the old rail's top corner
//     instead, which prints and still keeps the cards in.
//   - Lane: unchanged at the ramp.

part = "body"; // [mounted, body, slide, none]

/* [Body] */
// How much higher the phone sits
raise = 50;
// The frame is stretched from here up to the platform. Keep it above the
// slide slot's surround (y 19).
stretch_y0 = 22;

/* [Slide] */
// Height of the side walls above the ramp surface (the old rails were 2)
slide_wall_h = 10;

/* [Lines] */
// Slicer line width and layer height (the user prints this at 0.2 mm)
line_w = 0.45;
layer_h = 0.2;
// The slide's +X wall
slide_wall_lines = 4;

/* [Hidden] */
// Orca's width for n lines, which overlap
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));

// The original scanner
plat_bot = 63;          // the phone platform's underside
lattice_z = 55.2265;    // the lattice face, on the bed in print
scan_x = [-89, 89];     // bounds, a little oversize
scan_y = [-66, 66];
scan_z = [-56, 56];
stretch_k = (plat_bot + raise - stretch_y0) / (plat_bot - stretch_y0);
assert(stretch_y0 > 19, "stretch_y0 must stay above the slide slot");

module scanner() import("original_v2/v2_scanner.stl", convexity = 10);

// The scanner, cut to y0..y1
module scanner_band(y0, y1)
  intersection() {
    scanner();
    translate([scan_x[0], y0, scan_z[0]])
      cube([scan_x[1] - scan_x[0], y1 - y0, scan_z[1] - scan_z[0]]);
  }

module body() {
  scanner_band(scan_y[0], stretch_y0);
  translate([0, stretch_y0, 0]) scale([1, stretch_k, 1]) translate([0, -stretch_y0, 0])
    scanner_band(stretch_y0, plat_bot);
  translate([0, raise, 0]) scanner_band(plat_bot, scan_y[1]);
}

// --- Slide ---
// The ramp is at 30 degrees. Ramp coordinates [X, H, U]: X across, H
// square to the ramp (up), U up the slope.
ramp_a = 30;
ramp_s0 = -1.1772;      // H of the ramp surface
ramp_u0 = -24.690;      // lower end
ramp_u1 = 45.310;       // upper end
rail_u0 = -23.962;      // lower end of the old rails' tops
// The old rails are 2 mm high ridges with 2:1 sloped inner faces. These
// are their top inner corners; the lane is 92 mm at the ramp, 94 at
// their tops.
lane_x0 = -44.5;
lane_x1 = 49.5;
rail_top = ramp_s0 + 2;
slide_x0 = -50.5;       // the bed side in print
slide_x1 = 50.5;

module ramp_frame()
  multmatrix([[1, 0, 0, 0],
              [0, cos(ramp_a), sin(ramp_a), 0],
              [0, -sin(ramp_a), cos(ramp_a), 0]]) children();

module slide_walls() {
  w = lines(slide_wall_lines) * sqrt(2);
  top = ramp_s0 + slide_wall_h;
  lean = top - rail_top;
  // -X: square to the ramp from the rail's top corner, solid down to the
  // bed
  ramp_frame() translate([0, 0, ramp_u0]) linear_extrude(ramp_u1 - ramp_u0, convexity = 10)
    translate([slide_x0, ramp_s0 - 1]) square([lane_x0 - slide_x0, slide_wall_h + 1]);
  // +X: leaning out at 45 degrees from the rail's top corner. The rail's
  // own sloped face below it is the original's. It starts where the rail
  // does, so its corner doesn't hang past the rail's end.
  ramp_frame() translate([0, 0, rail_u0]) linear_extrude(ramp_u1 - rail_u0, convexity = 10)
    polygon([[lane_x1, ramp_s0 - 1], [lane_x1, rail_top],
             [lane_x1 + lean, top], [lane_x1 + lean + w, top],
             [slide_x1, rail_top + slide_x1 - lane_x1 - w], [slide_x1, ramp_s0 - 1]]);
}

module slide() {
  import("original_v2/v2_slide.stl", convexity = 10);
  slide_walls();
}

if (part == "mounted") {
  color("lightgray") body();
} else if (part == "body") {
  // As the original prints: +Z (the lattice face) down
  translate([0, 0, lattice_z]) rotate([180, 0, 0]) body();
} else if (part == "slide") {
  // On its edge, -X down
  translate([0, 0, -slide_x0]) rotate([0, -90, 0]) slide();
}
