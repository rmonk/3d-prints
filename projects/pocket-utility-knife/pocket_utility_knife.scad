// Pocket utility knife: lettering removed, and a third blade stop
// -------------------------------------------------------------
// The knife is "Utility Knife F1 Gen2" on Printables (model 1104014). This
// file imports its three parts unchanged and edits only the Bottom:
//
//   - Lettering: the word engraved in the Bottom's outer face (z = 2) and
//     "F1" in its other face (z = -4) are filled flush, for simpler prints.
//     The Top and the Slide have none.
//   - A third stop, with a standard blade about 3 mm out, for box cutting.
//
// How the stops work: the Slide carries the blade in a 0.6 mm pocket on its
// top, and its two pegs pass through the blade's back notches and ride in
// the Bottom's slot. A sprung finger beside each end of the slot (on its +y
// side, freed by a slit) drops a bump next to the end peg. Those are the
// retracted stop (as modelled, tip 2.7 mm inside the nose) and the
// extended one, 23.57 mm further on (tip about 21 mm out along the edge).
//
// The new stop is set by mid_stop: by default the tip 3.0 mm past the nose
// square to its face (3.8 mm along the edge), which is 6.5 mm of slide
// travel from retracted. Every render echoes all three. Its finger is on the
// slot's -y side, because the +y side has no room between the two existing
// fingers. Its bump fills the waist between the two pegs, so it holds the
// blade both ways, at about 55 degrees of contact, at least as firmly as the
// end bumps. The travel can't be less than the pegs' spacing (6.5 mm): any
// less, and the bump would press on a peg at the retracted stop.
//
// Coordinates are the STLs' own, which share one frame: x along the knife
// (nose at -X, ring at +X), the Bottom's plate at z 0-2, the slide moving
// along -X to extend. Exports keep the STLs' print orientation.

part = "bottom"; // [all, bottom, top, slide, mounted, none]
// Mounted view: which stop the slide is at
view_stop = "mid"; // [retracted, mid, extended]

/* [Third stop] */
// Where the new stop is, in the units mid_stop_measure picks
mid_stop = 3.0;
// square: blade tip past the nose, square to its face. edge: tip past the
// nose along the cutting edge. travel: slide travel from retracted.
mid_stop_measure = "square"; // [square, edge, travel]
// How far the bump reaches into the slot (the existing bumps reach 0.8)
bump_depth = 0.8;
// Gap between the bump and the pegs at every stop
bump_clearance = 0.1;
// Rounding of the bump's tip corners
bump_round = 0.3;
// Finger slit width, as on the existing fingers
slit_w = 1.25;
// Finger length, from its root (where the slit starts) to the bump's middle
finger_len = 4.25;
// Finger material past the bump's base, before the free-end gap
finger_tip = 1.1;

/* [Hidden] */
$fn = 96;
eps = 0.01;

stl_bottom = "Bottom - 0.4 PETG or PC.stl";
stl_top = "Top - 0.4 PETG or PC.stl";
stl_slide = "Slide - 0.4 PETG or PC.stl";

// Measured from the STLs
plate_z = [0, 2];               // the Bottom's plate round the slot
peg_x = [27.5, 34.0];           // slide pegs' centres at the retracted stop
peg_pitch = peg_x[1] - peg_x[0];
peg_d = 3.5;
slot_y = [-18.35, -14.75];      // slot edges (above the 0.4 chamfer at z 0)
slot_mid = (slot_y[0] + slot_y[1]) / 2;
full_travel = 23.57;            // retracted to extended
// Existing finger slits sit 3.25-4.5 mm off the slot's +y edge; the new one
// mirrors that on the -y side.
slit_y = [slot_y[0] - (-11.5 - slot_y[1]), slot_y[0] - (-12.75 - slot_y[1])];
// Engraved lettering: [x0, x1], [y0, y1], [face z, floor z]
word_box = [[4.0, 33.9], [-8.2, 2.3], [2.0, 1.5]];
f1_box = [[53.0, 62.6], [-22.7, -16.2], [-4.0, -3.25]];
letter_margin = 0.5;
// The nose's outer edge crosses the blade's edge line (y = 0) here, and
// leans back nose_slope in x per mm of y
nose_x = -2.43;
nose_slope = 0.768;
// A standard utility blade (61 x 19 x 0.6), its edge along y = 0 and its
// ends sloped like the slide's pocket, right tip in the pocket's corner
blade_l = 61;
blade_h = 19;
blade_t = 0.6;
blade_end_slope = 0.766;
blade_tip_r = 61.3;
blade_tip_l = blade_tip_r - blade_l;

// The blade tip's distance past the nose, along the edge, after slide
// travel t, and the same square to the nose's face
function tip_out(t) = nose_x - (blade_tip_l - t);
nose_secant = sqrt(1 + nose_slope * nose_slope);
function travel_for_out(out) = out - tip_out(0);

mid_travel =
    mid_stop_measure == "travel" ? mid_stop
  : mid_stop_measure == "edge" ? travel_for_out(mid_stop)
  : mid_stop_measure == "square" ? travel_for_out(mid_stop * nose_secant)
  : undef;
assert(!is_undef(mid_travel), str("unknown mid_stop_measure: ", mid_stop_measure));

assert(mid_travel >= peg_pitch - 0.01,
       str("third stop too close to retracted: the bump would press on a peg there. ",
           "Least: ", peg_pitch, " mm travel, ", tip_out(peg_pitch), " mm along the edge, ",
           tip_out(peg_pitch) / nose_secant, " mm square"));
assert(mid_travel + peg_pitch < full_travel,
       "third stop too close to the extended stop");

// Pegs at a stop, mm toward the nose from retracted
function pegs_at(t) = [for (x = peg_x) x - t];
mid_pegs = pegs_at(mid_travel);

// The pegs' footprint in the slot: the Slide above the blade (z > 0, which
// leaves out the pocket rim's top face at z = 0). Each peg is round, with a
// small flare at its root that reaches into the slot's chamfer.
module pegs2d(t) translate([-t, 0])
    projection() intersection() {
        import(stl_slide, convexity = 10);
        translate([0, -50, plate_z[0] + eps]) cube([100, 100, 10]);
    }

// The bump: the band from the slot's -y edge bump_depth into the slot,
// between the pegs at the new stop, less every peg at every stop grown by
// bump_clearance. So it fills the waist between the two round pegs, and its
// flanks follow them; a peg meets it about 55 degrees from the slot's axis.
module mid_bump2d() {
    offset(r = bump_round) offset(delta = -bump_round)
    difference() {
        translate([mid_pegs[0], slot_y[0] - 0.5])
            square([peg_pitch, bump_depth + 0.5]);
        for (t = [0, mid_travel, full_travel])
            offset(delta = bump_clearance) pegs2d(t);
    }
}

// The finger's free end starts finger_tip past the bump's base, which is
// where the right-hand peg (grown by bump_clearance) meets the slot edge
gap_x = mid_pegs[1] - peg_d / 2 + finger_tip;
finger_root_x = (mid_pegs[0] + mid_pegs[1]) / 2 - finger_len;

// Slit beside the finger, and the gap that frees its end
module finger_cut2d() {
    hull()
        for (x = [finger_root_x + slit_w / 2, gap_x + slit_w / 2])
            translate([x, (slit_y[0] + slit_y[1]) / 2]) circle(d = slit_w);
    translate([gap_x, (slit_y[0] + slit_y[1]) / 2])
        square([slit_w, slot_y[0] + 0.3 - (slit_y[0] + slit_y[1]) / 2]);
}

assert(finger_root_x < mid_pegs[0], "finger root inside the bump");

// Fill an engraving from its face to 0.5 mm past its floor
module letter_fill(b) {
    z = b[2];
    z_end = z[1] + 0.5 * sign(z[1] - z[0]);
    translate([b[0][0] - letter_margin, b[1][0] - letter_margin, min(z[0], z_end)])
        cube([b[0][1] - b[0][0] + 2 * letter_margin,
              b[1][1] - b[1][0] + 2 * letter_margin, abs(z_end - z[0])]);
}

module bottom() {
    difference() {
        union() {
            import(stl_bottom, convexity = 10);
            letter_fill(word_box);
            letter_fill(f1_box);
        }
        translate([0, 0, plate_z[0] - eps])
            linear_extrude(plate_z[1] - plate_z[0] + 2 * eps, convexity = 10)
                finger_cut2d();
    }
    translate([0, 0, plate_z[0]])
        linear_extrude(plate_z[1] - plate_z[0], convexity = 10) mid_bump2d();
}

module slide_at(t) translate([-t, 0, 0]) import(stl_slide, convexity = 10);

module blade_at(t) translate([-t, 0, -blade_t])
    linear_extrude(blade_t, convexity = 10)
        polygon([[blade_tip_l, 0], [blade_tip_r, 0],
                 [blade_tip_r - blade_h * blade_end_slope, -blade_h],
                 [blade_tip_l + blade_h * blade_end_slope, -blade_h]]);

stops = [["retracted", 0], ["mid", mid_travel], ["extended", full_travel]];
stop = stops[search([view_stop], stops)[0]][1];

// Where the blade's tip is at the third stop (and, in the mounted view, at
// every stop): past the nose along the edge, and square to the nose's face
if (part != "none")
    for (s = part == "mounted" ? stops : [stops[1]])
        echo(str(s[0], " stop: ", s[1], " mm travel, tip ", tip_out(s[1]),
                 " mm past the nose along the edge, ", tip_out(s[1]) / nose_secant,
                 " mm square to it"));

if (part == "bottom") bottom();
else if (part == "top") import(stl_top, convexity = 10);
else if (part == "slide") import(stl_slide, convexity = 10);
else if (part == "all") {
    // Each part on the bed as it prints: the Bottom on its z = 2 face, the
    // Top and Slide on their lowest faces. The exports keep the STLs' frame.
    translate([0, 0, 2]) rotate([180, 0, 0]) bottom();
    translate([0, -20, 4]) import(stl_top, convexity = 10);
    translate([0, -55, 6]) import(stl_slide, convexity = 10);
}
else if (part == "mounted") {
    color("steelblue") bottom();
    color("orange") slide_at(stop);
    color("silver") blade_at(stop);
}
