// Suction Cup Phone Holder
// -------------------------------------------------------------
// Holds a phone in its case (default an iPhone 16 Pro, 153 x 72 x 11 mm
// with the case) upright on a window or shower screen, screen facing out.
//
// Mounting: two suction cups, one above the other, each held in a short
// T-slot block on the back. The top cup's slot opens upward and the
// bottom cup's downward. Slide each cup in from its end of the holder
// (the knob passes under the back sheet until it reaches its block), push
// both knobs right to the closed ends, then press the holder onto the
// glass. With both cups stuck the
// holder can't slide up (the bottom knob stops it) or down (the top knob
// carries its weight), and the two knobs stop it turning. Feet at the
// four corners reach almost to the glass, so pressing on the screen
// can't rock the holder on its cups. To take it down, lift the cup tabs.
//
// Phone: drop it in from the top. Lips along both sides wrap over the
// front edges of the case and its bottom corners sit in rounded cradles.
// The bottom middle is open for the speaker, mic and port, to let water
// out, and to push the phone up from below to remove it. Two spring fins
// behind the phone press it gently forward against the lips so it
// doesn't rattle; they stop below the camera bump. Windows in the side
// walls keep the buttons clear (and reachable), and diamond windows in
// the back sheet save plastic and let water behind the phone drain.
//
// Printing: on its bottom edge, without supports. Every part of the
// cross-section, lips, walls, fins and the back, then lies in each
// layer, so the phone pushing out on the lips, the fins flexing and the
// cups pulling all load along the layers, not between them. The cup slots
// are vertical channels with pointed ends, the windows have peaked
// tops, and the free ends of the fins, cup blocks and top feet are cut
// at 45 degrees.
// PETG is recommended (tough, and fine with warm water); ASA also works.
// Wall, lip, sheet and fin thicknesses lie in the layer plane in print and
// are set as a whole number of extrusion lines (see [Printing]), so they
// slice as whole perimeters with no gap fill.
//
// Angle adapter (part = "adapter"): two wedge blocks, one per cup, that
// turn the holder adapter_angle (45) degrees so the screen faces left. Each
// has a cup slot on its back, opening the same way as the holder's, and a
// knob like the cup's on its angled face, with rails either side of the
// holder's cup block so the holder can't twist on it. They fit just as the
// cups do: slide a cup into each block, slide each block's knob into the
// holder's slot from its end, then press the cups onto the glass. The
// blocks are separate because the holder's slots open in opposite
// directions, so it couldn't slide onto two fixed knobs. Print them standing
// on the end their cup slot opens through.
//
// Set part = "mounted" to view it on the glass with the phone in place, or
// "mounted_angled" to view it on the angle adapter.
// The suction cup sizes are shared with the other mounts in
// suction_cup.scad. Uses BOSL2 from library/. All dimensions in mm.

include <../../library/BOSL2/std.scad>
include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "all"; // [all, holder, adapter, mounted, mounted_angled]

/* [Phone] */
// Width of the phone in its case
phone_w = 72;
// Height of the phone in its case
phone_h = 153;
// Thickness of the phone in its case (not counting the camera bump)
phone_t = 11;
// Corner radius of the case, seen from the front
phone_corner_r = 10;
// Gap behind the phone for the camera bump
camera_clearance = 4;

/* [Printing] */
// Extrusion line width set in the slicer
line_w = 0.45;
// Layer height set in the slicer
layer_h = 0.28;

/* [Holder] */
// Clearance each side of the phone (a soft case drags on tight walls)
side_clearance = 1.5;
// Extra room between the back of the cavity and the lips, front to back.
// The fins follow it, so the grip is still set by fin_preload.
depth_clearance = 1;
// Side wall thickness, in lines
wall_lines = 4;
// How far the lips reach over the front of the case
lip = 3.5;
// Lip thickness, in lines
lip_lines = 4;
// Material under the phone's bottom corners
ledge_t = 3;
// How much of the phone sticks out above the holder
top_open = 15;
// Distance between the two cup centres
cup_gap = 66;
// Back sheet thickness, in lines (it's also the roof over the cup pockets)
sheet_lines = 5;
// Wall each side of the cup head pockets, in lines
block_lines = 6;
// Lead-in on the side walls at the top
lead_in = 2;

/* [Spring Fins] */
// How far the fins are pressed down by the phone (sets how firmly it's held)
fin_preload = 0.3;
// Fin thickness measured across the fin, in lines
fin_lines = 3;
// Fin thickness where it joins the back, in lines; it tapers to fin_lines
fin_root_lines = 6;
// Length of the taper from the root thickness to fin_lines
fin_taper = 5;
// Where each fin joins the back, from the centre line
fin_root_x = 13;
// Where each fin touches the phone, from the centre line
fin_tip_x = 33;
// Bottom of the fins at the root, measured up from the phone's bottom
fin_y0 = 0;
// Top of the fins at the root, measured up from the phone's bottom
fin_y1 = 95;

/* [Button Windows] */
// Cut windows in the side walls around the buttons
button_windows = true;
// Bottom of the windows, measured up from the phone's bottom
window_y0 = 25;
// Top of the windows, measured up from the phone's bottom
window_y1 = 125;
// Crossbars across the left window (volume and Action side, -X), measured
// up from the phone's bottom. They tie the lip to the back so it doesn't
// wobble while printing. Keep them clear of the buttons.
left_bars = [50, 78];
// Crossbars across the right window (side button and Camera Control, +X)
right_bars = [78];
// Height of a crossbar at its narrowest (its middle)
bar_t = 3;

/* [Back Windows] */
// Cut diamond windows in the back sheet to save plastic and drain water
back_windows = true;
// Width of the ribs between the windows
rib_t = 2.5;

/* [Feet] */
// Distance from the glass to the top of a stuck-down cup
cup_standoff = 7;
// Gap between the feet and the glass, so the cups can be pressed flat
foot_gap = 0.5;
// Length of each foot
foot_len = 15;

/* [Angle Adapter] */
// How far the adapter turns the screen to the left
adapter_angle = 45;
// Where the holder's knobs sit, across from the cup centre (- is left)
adapter_x = -12;
// Where the holder's knobs sit, out from the top of the cup
adapter_z = 27;
// Rail thickness each side of the holder's cup blocks, in lines
rail_lines = 6;
// Rail height off the adapter face
rail_h = 3;
// Clearance between the rails and the holder's cup blocks
rail_clearance = 0.3;

/* [Hidden] */
$fn = 64;

// ---------- derived values ----------
// Thickness of n extrusion lines side by side. Slicers in the PrusaSlicer
// family (also Orca and Bambu Studio) overlap neighbouring lines, spacing
// them line_w - layer_h * (1 - pi / 4) apart.
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));
wall_t    = lines(wall_lines);
lip_t     = lines(lip_lines);
sheet_t   = lines(sheet_lines);
roof_thickness = sheet_t;                         // the sheet's back is the pocket top
spine_wall = lines(block_lines);
fin_t     = lines(fin_lines);
plate_t   = floor_t + pocket_h + roof_thickness;  // cup blocks + sheet, cup top at z = 0
sheet_z0  = plate_t - sheet_t;
spine_hw  = head_r + spine_wall;
cav_hw    = phone_w / 2 + side_clearance;         // phone cavity half width
out_hw    = cav_hw + wall_t;
cav_r     = phone_corner_r + side_clearance;
lip_x0    = phone_w / 2 - lip;                    // inner edge of the lips
holder_len = ledge_t + phone_h - top_open;
yb        = -holder_len / 2;                      // bottom edge (bottom slot opens here)
yt        =  holder_len / 2;                      // top edge (top slot opens here)
phone_y0  = yb + ledge_t;                         // phone's bottom
z_back    = plate_t + camera_clearance;           // phone's back
z_lip     = z_back + phone_t + depth_clearance;   // underside of the lips
z_top     = z_lip + lip_t;
glass_z   = -cup_standoff;
foot_z    = glass_z + foot_gap;
notch_hw  = phone_w / 2 - phone_corner_r - 1;     // open middle of the bottom
cup_y     = cup_gap / 2;                          // cups at y = -cup_y and +cup_y
fin_tip_z = z_back + depth_clearance + fin_preload;  // phone's back against the lips, less preload
// The fin's top and underside are parallel, fin_v apart vertically, so it's
// fin_t thick measured across it. Solved by iterating fin_v = fin_t * sqrt(1 + m^2).
function fin_v_iter(v, n) = n == 0 ? v
    : fin_v_iter(fin_t * sqrt(1 + pow((fin_tip_z - plate_t - v) / (fin_tip_x - fin_root_x), 2)), n - 1);
fin_v     = fin_v_iter(fin_t, 5);
fin_m     = (fin_tip_z - plate_t - fin_v) / (fin_tip_x - fin_root_x);  // fin slope
fin_root_v = lines(fin_root_lines) * sqrt(1 + fin_m * fin_m);  // vertical thickness at the root
fin_fillet = 2;                                   // fillet inside the root, along the back
fin_slope = 1.2;                                  // end cuts, a bit steeper than 45
block_h   = sheet_z0 + 0.5;                       // cup blocks reach into the sheet
block_cut = fin_slope * block_h;                  // length of a block's 45 degree end
block_in  = head_r + 1;                           // block length on the open side of a cup
block_end = head_r + tip_extra + spine_wall;      // block length on the closed side

// angle adapter
ad_c      = cos(adapter_angle);
ad_s      = sin(adapter_angle);
rail_x0   = spine_hw + rail_clearance;            // rails, from the knob line
rail_x1   = rail_x0 + lines(rail_lines);
ad_neck_h = floor_t + 0.1;                        // head clears the slot floor
ad_apex   = head_d / 2 * sqrt(2);                 // knob's pointed side, from its centre
ad_y0     = -(ad_apex + 1);                       // block ends (slot opens at y0)
ad_y1     = block_end;
ad_back_hw = head_r + spine_wall;                 // half width on the cup
// A point [x, z] on the holder's back (z = 0 at its cup tops) moved onto
// the adapter face
function ad_pt(p) = [adapter_x + ad_c * p[0] - ad_s * p[1],
                     adapter_z + ad_s * p[0] + ad_c * p[1]];

// ---------- helpers ----------
// Extrude a 2D XZ profile along Y from y0 to y1
module extrude_y(y0, y1) {
    back(y1) xrot(90) linear_extrude(y1 - y0, convexity = 10) children();
}

// Extrude a 2D outline drawn as [-z, y] along X from x0 to x1
module extrude_x(x0, x1) {
    right(x0) yrot(90) linear_extrude(x1 - x0, convexity = 10) children();
}

// Phone outline seen from the front, bottom at y = 0, running off the top
module phone_outline2d(hw, r) {
    rect([2 * hw, 500], rounding = [0, 0, r, r], anchor = FRONT);
}

// ---------- holder ----------
// Cross-section through the back, walls and lips (XZ)
module body2d() {
    round2d(or = 0.8) union() {
        translate([-out_hw, sheet_z0]) square([2 * out_hw, sheet_t]);
        xflip_copy() {
            translate([cav_hw, sheet_z0]) square([wall_t, z_top - sheet_z0]);
            translate([lip_x0, z_lip]) square([out_hw - lip_x0, lip_t]);
        }
    }
}

// One spring fin (XZ, right side): rises from the back toward the phone.
// Its top tapers from fin_root_lines thick at the root to fin_lines over
// fin_taper, and a fillet inside the root spreads it along the back. The
// root sits further in than it would without the taper, so the fin is
// about as stiff as a plain one of the same thickness.
module fin2d() {
    polygon([[fin_root_x - fin_fillet, sheet_z0 + 0.5], [fin_root_x + 1, sheet_z0 + 0.5],
             [fin_root_x + 1, plate_t + fin_m], [fin_tip_x, fin_tip_z - fin_v],
             [fin_tip_x, fin_tip_z],
             [fin_root_x + fin_taper, plate_t + fin_v + fin_m * fin_taper],
             [fin_root_x, plate_t + fin_root_v],
             [fin_root_x - fin_fillet, plate_t]]);
}

module fin() {
    y0 = phone_y0 + fin_y0;
    y1 = phone_y0 + fin_y1;
    x2 = fin_tip_x + 1;
    intersection() {
        extrude_y(y0, y1) fin2d();
        // ends cut back from the root, so the fin grows out of the back
        // layer by layer and the top end is a lead-in for the phone
        translate([0, 0, sheet_z0])
            linear_extrude(z_top, convexity = 10)
                polygon([[fin_root_x - fin_fillet - 1, y0], [fin_root_x, y0],
                         [x2, y0 + fin_slope * (x2 - fin_root_x)],
                         [x2, y1 - fin_slope * (x2 - fin_root_x)],
                         [fin_root_x, y1], [fin_root_x - fin_fillet - 1, y1]]);
        // and cut back with height off the back, so the thick root and
        // the fillet don't start as a flat ledge
        z0 = plate_t - 0.5;
        h = z_top - z0;
        extrude_x(0, x2)
            polygon([[-sheet_z0, y0], [-z0, y0], [-z_top, y0 + fin_slope * h],
                     [-z_top, y1 - fin_slope * h], [-z0, y1], [-sheet_z0, y1]]);
    }
}

// Cup block (holds one cup's T-slot) from y0 up to y1 at the glass side.
// Its lower end is cut back at 45 degrees from the sheet, so in print it
// grows out of the sheet instead of starting in mid-air.
module cup_block(y0, y1) {
    extrude_x(-spine_hw, spine_hw)
        polygon([[-block_h, y0 - block_cut], [0, y0], [0, y1], [-block_h, y1]]);
}

// Diamond (45 degree sides) window centred on [x, y], w wide and tall
module diamond2d(x, y, w) {
    translate([x, y]) rotate(45) square(w / sqrt(2), center = true);
}

// Windows in the back sheet: one column each side between the fin root and
// the fin tip (the sheet under the tips stays, as a stop for the fins), and
// in the middle between the cup blocks and above the top one
module back_windows() {
    side_w = fin_tip_x - 4 - (fin_root_x + 3);
    side_x = (fin_tip_x - 4 + fin_root_x + 3) / 2;
    pitch  = side_w + rib_t * sqrt(2);
    y_lo   = phone_y0 + cav_r + 2 + side_w / 2;   // clear of the cradles
    y_hi   = yt - rib_t - side_w / 2;
    mid_w  = 2 * (fin_root_x - fin_fillet - 2.5);
    // free spans in the middle, between the blocks and above the top one
    spans  = [[-cup_y + block_end + rib_t, cup_y - block_end - block_cut - rib_t],
              [cup_y + block_in + rib_t, yt - rib_t]];
    // stop just above the sheet, under the fins
    translate([0, 0, sheet_z0 - 1]) linear_extrude(sheet_t + 1.3, convexity = 10) {
        xflip_copy()
            for (i = [0 : floor((y_hi - y_lo) / pitch)])
                diamond2d(side_x, y_lo + i * pitch, side_w);
        for (s = spans)
            if (s[1] - s[0] >= mid_w)
                diamond2d(0, (s[0] + s[1]) / 2, mid_w);
    }
}

// Rounded cradles under the phone's bottom corners
module cradles() {
    translate([0, 0, sheet_z0])
        linear_extrude(z_top - sheet_z0, convexity = 10)
            difference() {
                xflip_copy()
                    translate([notch_hw, yb]) square([out_hw - notch_hw, ledge_t + cav_r + 1]);
                translate([0, phone_y0]) phone_outline2d(cav_hw, cav_r);
            }
}

// Corner foot (right side) reaching toward the glass, cut at 45 degrees
// on its inner end; mirrored in y for the bottom
module foot() {
    h = sheet_z0 + 0.5 - foot_z;
    extrude_x(cav_hw, out_hw)
        polygon([[-foot_z, yt], [-foot_z, yt - foot_len],
                 [-(sheet_z0 + 0.5), yt - foot_len - h], [-(sheet_z0 + 0.5), yt]]);
}

// Window through the side wall on side s (1 = +X, -1 = -X), split by
// crossbars at the heights in bars. Each opening has a flat bottom and a
// peaked top, so in print the bars' undersides are 45 degree slopes, not
// bridges.
module button_window(s, bars) {
    z0 = z_back + 1;
    z1 = z_lip - 1;
    peak = (z1 - z0) / 2;
    cuts = [phone_y0 + window_y0,
            for (b = bars) each [phone_y0 + b - bar_t / 2, phone_y0 + b + bar_t / 2],
            phone_y0 + window_y1];
    mirror([s < 0 ? 1 : 0, 0, 0])
        for (i = [0 : 2 : len(cuts) - 1]) {
            y0 = cuts[i];
            y1 = cuts[i + 1];
            if (y1 - y0 > peak)
                extrude_x(cav_hw - 1, out_hw + 1)
                    polygon([[-z0, y0], [-z1, y0], [-z1, y1 - peak],
                             [-(z0 + z1) / 2, y1], [-z0, y1 - peak]]);
        }
}

// Lead-ins at the top of the lips and walls
module top_lead_ins() {
    d = cav_hw - lip_x0;
    translate([0, 0, z_lip - 1]) linear_extrude(lip_t + 2, convexity = 10)
        polygon([[lip_x0 - eps, yt - d], [lip_x0 - eps, yt + 1], [cav_hw + 1, yt + 1]]);
    translate([0, 0, sheet_z0 - 1]) linear_extrude(z_top - sheet_z0 + 2, convexity = 10)
        polygon([[cav_hw - eps, yt - lead_in], [cav_hw - eps, yt + 1],
                 [cav_hw + lead_in + 1, yt + 1]]);
}

module holder() {
    difference() {
        union() {
            extrude_y(yb, yt) body2d();
            cradles();
            // bottom cup's block, open end down, and top cup's, open end up
            cup_block(-cup_y - block_in, -cup_y + block_end);
            cup_block(cup_y - block_end, cup_y + block_in);
            xflip_copy() {
                fin();
                foot();
                mirror([0, 1, 0]) foot();
            }
        }
        // cup slots: the bottom one opens down, the top one up
        translate([0, -cup_y, 0]) cup_slot(-block_in);
        translate([0, cup_y, 0]) mirror([0, 1, 0]) cup_slot(-block_in);
        if (back_windows) back_windows();
        if (button_windows) {
            button_window(1, right_bars);
            button_window(-1, left_bars);
        }
        xflip_copy() top_lead_ins();
    }
}

// Print orientation: bottom edge on the bed
module holder_print() { translate([0, 0, -yb]) rotate([90, 0, 0]) holder(); }

// ---------- angle adapter ----------
// Moves the holder's frame onto the adapter face
module to_adapter_face() {
    translate([adapter_x, 0, adapter_z]) yrot(-adapter_angle) children();
}

// Cross-section (XZ): from the cup top up to the angled face, with rails
// each side of the holder's cup block
module adapter2d() {
    polygon([[-ad_back_hw, 0], [ad_back_hw, 0],
             ad_pt([rail_x1, 0]), ad_pt([-rail_x1, 0])]);
    for (sx = [-1, 1])
        polygon([ad_pt([sx * rail_x0, -1]), ad_pt([sx * rail_x1, -1]),
                 ad_pt([sx * rail_x1, rail_h]), ad_pt([sx * rail_x0, rail_h])]);
}

// Knob in the holder's frame, like the cup's but pointed toward -y (the
// slot's open end), which is down in print. The neck runs down to the same
// point as the head, so every layer of the head joins the block.
module adapter_knob() {
    down(1) linear_extrude(ad_neck_h + 1.5, convexity = 10)
        hull() {
            circle(d = neck_d);
            back(-ad_apex) square(0.01, center = true);
        }
    up(ad_neck_h) linear_extrude(head_height, convexity = 10)
        rotate(180) pointed_circle2d(head_d / 2, ad_apex);
}

// Bottom block, its cup at the origin; the top block is its mirror in y
module adapter_block() {
    difference() {
        union() {
            extrude_y(ad_y0, ad_y1) adapter2d();
            to_adapter_face() adapter_knob();
        }
        cup_slot(ad_y0);
    }
}

// Print orientation: each block standing on the end its cup slot opens
// through
module adapter_print() {
    fwd(5) up(-ad_y0) xrot(90) adapter_block();
    back(5) up(-ad_y0) xrot(-90) mirror([0, 1, 0]) adapter_block();
}

// ---------- display models ----------
module cup_model() {
    up(glass_z) cyl(h = 1.5, d = cup_d, anchor = BOTTOM);
    up(glass_z + 1.5) cyl(h = -glass_z - 1.5, d1 = cup_d - 4, d2 = 18, anchor = BOTTOM);
    down(1) cyl(h = floor_t + 1, d = neck_d, anchor = BOTTOM);
    up(floor_t) cyl(h = head_height, d = head_d, anchor = BOTTOM);
}

// Phone in its case, at y = 0 .. phone_h, back at z = 0
module phone_model() {
    cuboid([phone_w, phone_h, phone_t], rounding = phone_corner_r, edges = "Z",
           anchor = FRONT + BOTTOM);
}

// ---------- output ----------
if (part == "mounted") {
    holder();
    for (y = [-cup_y, cup_y]) color("lightgray") translate([0, y, 0]) cup_model();
    color("dimgray", 0.6) translate([0, phone_y0, z_lip - phone_t]) phone_model();
    %translate([-90, -110, glass_z - 3]) cube([180, 220, 3]);
} else if (part == "mounted_angled") {
    for (y = [-cup_y, cup_y]) color("lightgray") translate([0, y, 0]) cup_model();
    translate([0, -cup_y, 0]) adapter_block();
    translate([0, cup_y, 0]) mirror([0, 1, 0]) adapter_block();
    to_adapter_face() {
        holder();
        color("dimgray", 0.6) translate([0, phone_y0, z_lip - phone_t]) phone_model();
    }
    %translate([-140, -110, glass_z - 3]) cube([240, 220, 3]);
} else if (part == "adapter") {
    adapter_print();
} else if (part == "all" || part == "holder") {
    holder_print();
    if (part == "all") right(90) adapter_print();
}
