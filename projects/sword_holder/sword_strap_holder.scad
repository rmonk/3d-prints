// Sword Strap Holder
// -------------------------------------------------------------
// Holds a Nerf foam sword on a back strap. It doesn't sheath the
// blade: a short sleeve fits loosely round the blade (55 x 20 mm at
// most, its faces bevelled toward the edges) below a wider section (72 mm across, 64 mm below the hilt).
// The sword drops through the sleeve tip first, and the wider section
// rests on a flange round the sleeve's top. The sword hangs from it
// and draws straight up over the shoulder.
//
// The strap (44.5 x 2.2 mm) runs along the blade, through a closed
// channel down the back of the sleeve. The channel is deep enough for
// the strap's folded end to pass easily. Once the strap is through,
// the lock bar pushes down the channel between the strap and the
// sleeve, squeezing the strap against the back wall, until its barbed
// prongs snap past the sleeve's bottom. Its head stops on the top.
// To loosen it, squeeze the prongs together and pull the bar out by
// its head.
//
// The sleeve is one 2D cross-section (bore, shell, back plate and strap
// channel) extruded along the blade, so every wall is vertical in
// print.
//
// Printing, without supports:
//  - holder: upside down, the flange on the bed. Only the chamfers
//    slope. The sword's weight runs across the layers, but a foam
//    sword is light.
//  - lock bar: flat, its strap face up, so its prongs flex along the
//    layers and its lead-in ramp is on top.
//
// Wall thicknesses lie in the layer plane and are set as a whole number
// of extrusion lines (see [Printing]).
//
// Model coordinates (mounted): z runs along the blade, +Z toward the
// hilt, with the sleeve's bottom at z = 0. y = 0 is the face against
// the wearer's back, and +Y points away from it. x is across the blade.
// Set part = "mounted" to view it with the blade and strap as ghosts.
// All dimensions in mm.

/* [Output] */
// Which part(s) to render
part = "all"; // [all, holder, lock, mounted, test]

/* [Blade (measured)] */
// Blade width where the sleeve sits (its widest, below the wider section)
blade_w = 55;
// Blade thickness where the sleeve sits, at its centre ridge
blade_t = 20;
// Blade thickness where the faces turn into the bevelled edges (an estimate; on the generous side)
bevel_t = 12;
// Width of each bevelled edge, measured across the blade (an estimate)
bevel_w = 8;
// Rounding of the blade's corners (an estimate)
blade_edge_r = 2;
// Width of the wider section that rests on the sleeve
wide_w = 72;

/* [Strap (measured)] */
// Strap width
strap_w = 44.5;
// Strap thickness
strap_t = 2.2;
// Thickness of the folded end that has to pass through the channel
strap_fold_t = 5;

/* [Printing] */
// Extrusion line width set in the slicer
line_w = 0.45;
// Layer height set in the slicer
layer_h = 0.28;

/* [Sleeve] */
// Sleeve length along the blade
sleeve_len = 80;
// Length of the fit test piece (part = "test": a short holder, no lock bar)
test_len = 10;
// Gap from the blade to the bore, each side
clearance = 1.5;
// Sleeve wall thickness, in lines
wall_lines = 4;
// How far the flange the wider section rests on reaches out past the sleeve
flange = 4;
// Flange thickness
flange_t = 3;
// 45 degree lead-in round the bore's top
lead_in = 1;
// Width of the web joining the sleeve to the back plate
joint_w = 24;

/* [Strap channel] */
// Gap from the strap's edges to the channel's sides
strap_clearance = 0.75;
// Gap over the folded end as it passes through the channel
fold_clearance = 0.8;
// Thickness of the channel's wall against the back, in lines
back_lines = 4;
// 45 degree chamfer round the channel's top end
channel_chamfer = 0.5;

/* [Lock bar] */
// How much the bar squeezes the strap
strap_squeeze = 0.4;
// Gap from the bar's edges to the channel's sides
lock_clearance = 0.3;
// Play along the channel between the head and the barbs
lock_play = 0.3;
// Width of each snap prong, in lines
prong_lines = 6;
// Width of the slit inside each prong
snap_slit = 1.6;
// Length of the slits, from the prong tips
snap_len = 16;
// How far each barb sticks out
snap_barb = 1;
// Length of the head that stops on the sleeve's top
lock_head_len = 4;
// How far the head reaches past the channel's sides
lock_head_out = 2.5;
// Length of the lead-in ramp at the bar's tip
lock_ramp_len = 8;

/* [Hidden] */
$fn = 96;
eps = 0.01;

// Width of n lines, as the slicer lays them (they overlap)
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));

wall = lines(wall_lines);
back = lines(back_lines);
prong_w = lines(prong_lines);

strap_gap = strap_fold_t + fold_clearance;  // channel depth
ch_hw = strap_w / 2 + strap_clearance;      // channel half-width
plate_hw = ch_hw + wall;                    // back plate half-width
y_ch0 = back;                               // channel, back side
y_ch1 = back + strap_gap;                   // channel, sleeve side
y_pt = y_ch1 + wall;                        // top of the back plate
ba = blade_w / 2;
bb = blade_t / 2;
y_c = y_pt + bb + clearance;                // blade centre

// sleeve length actually built: short for the fit test
body_len = part == "test" ? test_len : sleeve_len;

lock_t = strap_gap - strap_t + strap_squeeze;  // bar thickness (y)
lock_w = 2 * (ch_hw - lock_clearance);         // bar width (x)
barb_ramp = 3;
lock_y0 = -lock_play / 2 - barb_ramp;          // prong tips (bar's own y = mounted z)
lock_y1 = body_len + lock_play / 2;            // head's underside
lock_ramp = strap_squeeze + 0.5;               // lead-in drop at the tip

assert(blade_edge_r > 0 && blade_edge_r < bevel_t / 2, "blade_edge_r must be between 0 and half bevel_t");
assert(bevel_t <= blade_t && bevel_w > blade_edge_r && bevel_w < ba - blade_edge_r,
       "bevel_t must be at most blade_t, and bevel_w inside the blade's half-width");
assert(blade_w + 2 * clearance < wide_w - 4,
       "the bore is nearly as wide as the wider section, which would slip through");
assert(flange > 0, "flange must be positive");
assert(strap_fold_t >= strap_t, "strap_fold_t must be at least strap_t");
assert(lock_t > 2 * line_w, "lock bar too thin; lower strap_fold_t or raise strap_squeeze");
assert(part == "test" || snap_len + 5 < body_len, "the sleeve is too short for the lock bar's slits; raise test_len");
assert(lock_w / 2 - prong_w - snap_slit > 5, "prongs and slits leave too little bar");
assert(lock_head_out - lock_clearance > channel_chamfer + 1,
       "lock bar head barely reaches past the channel's top chamfer");
assert(snap_barb <= 0 || snap_barb - lock_clearance >= 0.5,
       "barbs barely reach past the channel's sides (snap_barb <= 0 turns them off)");

echo(str("Sleeve wall ", wall, " mm; bore ", blade_w + 2 * clearance, " x ",
         blade_t + 2 * clearance, " mm; channel ", 2 * ch_hw, " x ", strap_gap,
         " mm; lock bar ", lock_t, " mm thick"));

// ---------------------------------------------------------------- 2D

// The blade's section grown by g. The faces slope gently from the
// centre ridge (blade_t thick) to the bevels (bevel_t thick, bevel_w
// from each edge), then steeply to the edges. A hull of six circles, so
// its extremes are blade_w / 2 + g and blade_t / 2 + g.
module rblade(g) {
    r = blade_edge_r;
    xs = ba - bevel_w;
    hull()
        for (p = [[ba - r, 0], [r - ba, 0], [0, bb - r], [0, r - bb],
                  [xs, bevel_t / 2 - r], [-xs, bevel_t / 2 - r],
                  [xs, r - bevel_t / 2], [-xs, r - bevel_t / 2]])
            translate([p[0], y_c + p[1]]) circle(r = r + g);
}

module plate2d() {
    translate([-plate_hw, 0])
        offset(r = 1) offset(delta = -1) square([2 * plate_hw, y_pt]);
}

module channel2d(g = 0) {
    translate([-ch_hw - g, y_ch0 - g]) square([2 * (ch_hw + g), strap_gap + 2 * g]);
}

// Web filling the wedge between the back plate and the sleeve's back
module web2d() {
    h = joint_w / 2 * (bb - bevel_t / 2) / (ba - bevel_w) + 1;
    hull() {
        translate([-joint_w / 2, y_pt - eps]) square([joint_w, eps]);
        intersection() {
            rblade(clearance + wall);
            translate([-plate_hw, 0]) square([2 * plate_hw, y_pt + h]);
        }
    }
}

module section2d() {
    difference() {
        union() {
            plate2d();
            rblade(clearance + wall);
            web2d();
        }
        channel2d();
    }
}

module flange2d() {
    difference() {
        union() {
            plate2d();
            intersection() {
                rblade(clearance + wall + flange);
                translate([-200, 0]) square([400, 400]);
            }
        }
        channel2d();
    }
}

// Lock bar outline, in its own frame: x across, y along the channel
// (mounted z), the head at the top
module lock2d() {
    hw = lock_w / 2;
    tip = lock_y0;
    difference() {
        union() {
            translate([-hw, tip]) square([lock_w, lock_y1 - tip]);
            translate([-hw - lock_head_out, lock_y1])
                square([lock_w + 2 * lock_head_out, lock_head_len]);
            // barbs: catch faces just under the sleeve's bottom
            for (s = [-1, 1])
                polygon([[s * hw, -lock_play / 2], [s * (hw + snap_barb), -lock_play / 2],
                         [s * hw, tip]]);
        }
        // a slit inside each edge prong, with a round relief at its root
        for (s = [-1, 1]) {
            x = s * (hw - prong_w - snap_slit / 2);
            translate([x - snap_slit / 2, tip - 1]) square([snap_slit, snap_len + 1]);
            translate([x, tip + snap_len]) circle(d = snap_slit);
        }
    }
}

// ---------------------------------------------------------------- 3D

// Two thin slices hulled: the shape grown by g at z0 tapering to g = 0
// at z1, for 45 degree chamfers on convex holes
module taper(z0, z1) {
    hull() {
        translate([0, 0, z0 - eps]) linear_extrude(2 * eps, convexity = 10) children(0);
        translate([0, 0, z1 - eps]) linear_extrude(2 * eps, convexity = 10) children(1);
    }
}

module holder() {
    difference() {
        union() {
            linear_extrude(body_len, convexity = 10) section2d();
            translate([0, 0, body_len - flange_t])
                linear_extrude(flange_t, convexity = 10) flange2d();
        }
        translate([0, 0, -1])
            linear_extrude(body_len + 2, convexity = 10) rblade(clearance);
        taper(body_len + eps, body_len - lead_in) {
            rblade(clearance + lead_in + eps);
            rblade(clearance);
        }
        // the channel's bottom end stays square for the barbs to catch
        taper(body_len + eps, body_len - channel_chamfer) {
            channel2d(channel_chamfer + eps);
            channel2d();
        }
    }
}

// Lock bar, flat: the face against the sleeve on the bed (z = 0) and
// the strap face up (z = lock_t), with a lead-in ramp at the tip
module lock() {
    difference() {
        linear_extrude(lock_t, convexity = 10) lock2d();
        // 2D [y, z] extruded across x
        rotate([90, 0, 90])
            linear_extrude(lock_w + 2 * snap_barb + 2, center = true, convexity = 10)
                polygon([[lock_y0 - 1, lock_t - lock_ramp], [lock_y0 + lock_ramp_len, lock_t],
                         [lock_y0 + lock_ramp_len, lock_t + 1], [lock_y0 - 1, lock_t + 1]]);
    }
}

// The lock bar in the channel: its bed face on the channel's sleeve side
module lock_mounted() {
    multmatrix([[1, 0, 0, 0], [0, 0, -1, y_ch1], [0, 1, 0, 0]]) lock();
}

// Print orientation: upside down, flange on the bed
module holder_print() {
    translate([0, 0, body_len]) mirror([0, 0, 1]) holder();
}

// Ghost blade: its section through the sleeve, and the wider section
// resting on it (its thickness is a guess)
module blade() {
    translate([0, 0, -150]) linear_extrude(150 + body_len, convexity = 10) rblade(0);
    translate([0, y_c, body_len])
        linear_extrude(40, convexity = 10)
            scale([wide_w / blade_w, 1.2]) translate([0, -y_c]) rblade(0);
}

// Ghost strap, against the back wall
module strap() {
    translate([-strap_w / 2, y_ch0, -100]) cube([strap_w, strap_t, body_len + 200]);
}

// ---------------------------------------------------------------- output

if (part == "mounted") {
    color("orange", 0.4) %blade();
    color("dimgray", 0.4) %strap();
    color("steelblue") holder();
    color("tomato") lock_mounted();
} else if (part == "all") {
    holder_print();
    // the bar beside the holder, along x
    translate([ba + clearance + wall + flange + 8 - lock_y0, y_c / 2, 0])
        rotate([0, 0, -90]) lock();
} else if (part == "holder" || part == "test") {
    holder_print();
} else if (part == "lock") {
    lock();
}
