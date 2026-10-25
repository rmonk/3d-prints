// Suction Cup Tracker Case
// -------------------------------------------------------------
// A case for a bare Heltec Wireless Tracker V1.1 (no pin headers), held
// upright on a window by one suction cup: USB-C at the bottom, the
// LoRa antenna's SMA bulkhead at the top, and the display facing into
// the room. Two printed buttons in the lid press the board's RST and
// USER buttons. Board sizes come from Heltec's dimension drawing
// (Wireless Tracker V1.1 datasheet, section 4); the positions of the
// display, buttons and U.FL socket are read off that drawing and the
// pin map photo, so check them against the board.
//
// Base: a channel with a back, two side walls and a bottom end, open at
// the front and the top. The board drops in from the front onto two
// rails under its long edges. Stops at its bottom end (beside the USB
// socket) and 45 degree wedges at its top corners hold it along its
// length. The USB-C plug goes in through an opening in the bottom end.
//
// Lid: the front plate, with the display window and the two buttons, and
// the top end wall, which carries the SMA bulkhead. Skirts down its long
// edges press the board's edges onto the rails. Four diamond bumps on the
// skirts snap into windows in the base's side walls; their 45 degree
// faces let the lid come off with a firm pull (pull on the SMA connector
// at the top, then the bottom).
//
// Antenna: thread one of the pigtail's nuts onto the SMA bulkhead, slide
// it between the two walls inside the end wall, push the thread out
// through the hole and fit the washer and the other nut outside. The
// walls sit on the inner nut's flats, so it can't turn: tighten the outer
// nut with a wrench alone. Plug the U.FL end into the board's LoRa socket
// (beside the display, on the left seen from the room) and lay the cable
// over the GNSS patch as the lid closes.
//
// Buttons: each is a thin tongue in the front plate, freed by a slit,
// with a plunger under it that reaches to just above the board's button.
// RST is on the right seen from the room, USER on the left.
//
// Mounting: as on the tracker holder. The cup's T-slot opens through the
// bottom edge, so the case hangs on the knob. Slide the cup in from below
// and push the knob right up, slide the lock bar in sideways under the
// knob's head until its barbs snap past the far side, then press the cup
// onto the glass. Two feet at the bottom corners, outside the cup's rim,
// stop it rocking when the buttons are pressed. The lock bar is the same
// part as the tracker holder's.
//
// Printing, without supports:
//   base  - on its bottom end. The back, walls and rails lie in every
//           layer, so the cup's pull and the walls flexing over the
//           snaps load the layers along their length.
//   lid   - face down. The button tongues lie in the first layers, so
//           they bend along the layers; the end wall stands upright, its
//           SMA hole pointed at the top.
//   lock  - flat, so its prongs flex along the layers.
// Thicknesses that lie in the layers are whole numbers of extrusion
// lines (see [Printing]).
//
// Set part = "mounted" to see it on the glass with the board, antenna and
// USB plug in place. The suction cup sizes are shared with the other
// mounts in suction_cup.scad. Uses BOSL2 from library/. All dimensions
// in mm.

include <../../library/BOSL2/std.scad>
include <../../library/suction_cup.scad>

/* [Output] */
// Which part(s) to render
part = "base"; // [all, base, lid, lock, mounted]

/* [Board] */
// PCB length, USB end to GNSS end (USB-C shell not included)
pcb_l = 63.64;
// PCB width
pcb_w = 28;
// PCB thickness (measure it: the lid clamps the board's edges)
pcb_t = 1.2;
// How far the USB-C shell sticks out past the PCB's end
usb_overhang = 2.2;
// Room under the PCB for the parts on its back (battery socket)
under_space = 4.5;
// Height of the tallest part on the top face (the GNSS patch)
top_parts = 4.6;
// Height of the display's face above the PCB
display_top = 3.6;
// Display's visible area: from the USB end of the PCB, and its width
screen_y0 = 12.7;
screen_y1 = 35.5;
screen_w = 11.8;
// Buttons: centres from the USB end, and across from the centre
button_y = 4.6;
button_x = 8;
// Height of the buttons' tops above the PCB (an estimate; check it)
button_h = 1.8;

/* [Printing] */
// Extrusion line width set in the slicer
line_w = 0.45;
// Layer height set in the slicer
layer_h = 0.28;

/* [Case] */
// Clearance round the board
clearance = 0.3;
// Thickness of the back, walls, end and lid plate, in lines
wall_lines = 4;
// Width of the rails under the board's long edges, in lines
rail_lines = 5;
// Thickness of the lid's skirts, in lines
skirt_lines = 4;
// Space over the tallest part, for the antenna cable
cable_space = 1.9;
// Clearance between the lid and the base's walls, per side
lid_clearance = 0.15;
// How far the skirts reach into the board's edges, so the lid clamps it
pcb_preload = 0.1;
// 45 degree lead-in on the inside of the walls' front edges
lead_in = 0.8;

/* [USB] */
// USB-C plug's overmold, across and front to back (the opening's size)
usb_plug_w = 13;
usb_plug_h = 7.5;
// USB-C shell height (its centre sets the opening's height)
usb_h = 3.26;

/* [Antenna] */
// SMA bulkhead thread diameter (1/4"-36)
sma_d = 6.35;
// Clearance round the thread
sma_clearance = 0.25;
// SMA nut size across flats, and its thickness
sma_nut_af = 8;
sma_nut_t = 2;
// Clearance round the nut, per side
nut_clearance = 0.15;
// SMA position across from the centre (- is left, seen from the room)
sma_x = -8.3;
// SMA axis height above the PCB's top face
sma_up = 1.5;
// Thickness of the end wall the bulkhead goes through, in lines
sma_wall_lines = 5;
// How far the inner nut, the bulkhead's body and its crimp reach inside
// the end wall (measure your pigtail)
sma_inside = 12;
// Length the cable needs to bend up from the SMA over the GNSS patch
cable_rise = 9;
// Walls on the inner nut's flats, in lines
nut_wall_lines = 4;

/* [Snaps] */
// How far the bumps on the lid's skirts stand out into the windows
detent = 0.5;
// Bump size, corner to corner of the diamond
detent_w = 4;
// Clearance round the bumps in the windows
detent_clearance = 0.2;
// Bump positions, up from the USB end of the PCB
snap_y = [20, 72];

/* [Buttons] */
// Tongue thickness, in layers
key_layers = 3;
// Tongue width
key_w = 5;
// Slit round each tongue
key_slit = 0.8;
// Tongue roots, across from the centre (the tongues run outward from here)
key_root_x = 0.75;
// Tongue ends, across from the centre
key_end_x = 11.5;
// Plunger diameter
plunger_d = 3;
// Gap between each plunger and its button, with the lid on
button_gap = 0.4;

/* [Window] */
// Margin round the display's visible area
window_margin = 1;

/* [Feet] */
// Distance from the glass to the top of a stuck-down cup
cup_standoff = 7;
// Gap between the feet and the glass, so the cup can be pressed flat
foot_gap = 0.5;
// Gap between the feet and the cup's rim
foot_clearance = 1;
// Width of each foot's pad on the glass
foot_w = 4;
// Height of the feet, up from the case's bottom edge
foot_len = 10;
// Where the feet meet the back, across from the centre
foot_root = 12;
// How far up the side walls the feet reach, from the back
foot_join = 6;

/* [Lock Bar] */
// Half-width of the band round the lock bar channel (19.05 fits the
// tracker holder's lock bar)
band_hw = 19.05;
// Wall each side of the cup head pocket, in lines
block_lines = 6;
// Clearance between the lock bar and its channel, per side
lock_clearance = 0.3;
// Width of each snap prong, in lines
prong_lines = 6;
// Width of the slit between the snap prongs
snap_slit = 1.6;
// Length of the slit, from the prong tips
snap_len = 12;
// How far each barb sticks out
snap_barb = 0.6;
// Length of the stop head on the lock bar
lock_head_len = 4;

/* [Hidden] */
$fn = 64;

// ---------- derived values ----------
// Thickness of n extrusion lines side by side. Slicers in the PrusaSlicer
// family (also Orca and Bambu Studio) overlap neighbouring lines, spacing
// them line_w - layer_h * (1 - pi / 4) apart.
function lines(n) = line_w + (n - 1) * (line_w - layer_h * (1 - PI / 4));
wall_t    = lines(wall_lines);
rail_w    = lines(rail_lines);
skirt_t   = lines(skirt_lines);
sma_wall  = lines(sma_wall_lines);
nut_wall  = lines(nut_wall_lines);
spine_wall = lines(block_lines);
key_t     = key_layers * layer_h;

// Z (out from the cup's top): back, board, lid
plate_t   = floor_t + pocket_h + wall_t;          // the back is the pocket roof
sheet_z0  = plate_t - wall_t;                     // back face of the back
pcb_z0    = plate_t + under_space;                // PCB's back face
pcb_z1    = pcb_z0 + pcb_t;                       // PCB's top face
lid_z0    = pcb_z1 + top_parts + cable_space;     // lid's inner face
lid_z1    = lid_z0 + wall_t;                      // front face
sma_z     = pcb_z1 + sma_up;
usb_z     = pcb_z1 + usb_h / 2;
// X: the board's centre is over the cup
in_hw     = pcb_w / 2 + clearance;                // inside of the side walls
out_hw    = in_hw + wall_t;
lid_hw    = in_hw - lid_clearance;
// Y: up from the cup's centre, with the case centred on it
head_space = sma_inside + cable_rise;             // PCB's top end to the end wall
below     = usb_overhang + clearance + wall_t;    // PCB's bottom end to the bottom
above     = pcb_l + head_space + sma_wall;        // PCB's bottom end to the top
pcb_y0    = (below - above) / 2;                  // PCB's USB end
pcb_y1    = pcb_y0 + pcb_l;
bot_in    = pcb_y0 - usb_overhang - clearance;    // inside of the bottom end
yb        = bot_in - wall_t;                      // bottom edge (the slot opens here)
top_in    = pcb_y1 + head_space;                  // inside of the lid's end wall
yt        = top_in + sma_wall;                    // top edge
// Cup block and lock bar, as on the tracker holder
spine_hw  = head_r + spine_wall;                  // narrow cup block, round the slot
block_end = head_r + tip_extra + spine_wall;      // cup block, past the cup centre
lock_w    = 2 * lines(prong_lines) + snap_slit;
chan_w    = lock_w + 2 * lock_clearance;
chan_y1   = -head_r;                              // channel top, under the head
chan_y0   = chan_y1 - chan_w;
lock_t    = pocket_h - 2 * lock_clearance;
lock_len  = 2 * band_hw + 0.3;                    // body; the barbs catch the far face
barb_ramp = 3;
band_y0   = chan_y0 - spine_wall;                 // full-width band round the channel
band_y1   = chan_y1 + spine_wall;
// Feet
glass_z   = -cup_standoff;
foot_z    = glass_z + foot_gap;
foot_x0   = cup_d / 2 + foot_clearance;           // feet, outside the cup's rim
foot_x1   = foot_x0 + foot_w;
// Snaps: bumps at mid-skirt. The windows sit c * sqrt(2) lower, so with
// the lid lifted by pcb_preload the bumps press on their top faces.
bump_z    = (pcb_z1 + lid_z0) / 2;
window_z  = bump_z - detent_clearance * sqrt(2);
// SMA nut: walls on its flats, corners toward the lid and the back
nut_hw    = sma_nut_af / 2 + nut_clearance;       // half the gap between the walls
nut_r     = nut_hw * 2 / sqrt(3);                 // to the corners
nut_y0    = top_in - sma_nut_t - 1.5;             // the walls' inner ends
// Display window
win_hw    = screen_w / 2 + window_margin;
win_y0    = pcb_y0 + screen_y0 - window_margin;
win_y1    = pcb_y0 + screen_y1 + window_margin;
// Buttons
key_y     = pcb_y0 + button_y;
plunger_z0 = pcb_z1 + button_h + button_gap;

assert(sma_z + nut_r < lid_z0, "SMA nut would cut into the lid plate; lower sma_up");
assert(sma_z - nut_r > plate_t + 0.5, "SMA nut would reach the back; raise sma_up");
assert(sma_x - nut_hw - nut_wall > -lid_hw, "SMA nut walls reach past the lid; move sma_x in");
assert(lock_len + barb_ramp - snap_len > band_hw + head_r + 1,
       "snap prongs would reach over the slot; shorten snap_len");
assert(yb + foot_len < band_y0 - 2, "feet would reach the lock bar's band");
assert(bump_z + detent_w / 2 < lid_z0 && bump_z - detent_w / 2 > pcb_z1,
       "snap bumps don't fit on the skirts");
assert(key_end_x + key_slit < lid_hw - skirt_t, "button tongues reach the skirts");
assert(key_y + key_w / 2 + key_slit < win_y0 - wall_t, "button tongues reach the window");
assert(abs(button_x) - plunger_d / 2 > key_root_x + 1 && button_x + plunger_d / 2 < key_end_x,
       "plunger must sit on its tongue");
assert(usb_z + usb_plug_h / 2 < lid_z0, "USB opening reaches the lid");
assert(-out_hw + 1 < sma_x, "SMA outside the case");

// ---------- helpers ----------
// Extrude a 2D XZ profile along Y from y0 to y1
module extrude_y(y0, y1) {
    back(y1) xrot(90) linear_extrude(y1 - y0, convexity = 10) children();
}

// Extrude a 2D outline drawn as [-z, y] along X from x0 to x1
module extrude_x(x0, x1) {
    right(x0) yrot(90) linear_extrude(x1 - x0, convexity = 10) children();
}

// Diamond (45 degree sides), w corner to corner, centred on the origin
module diamond2d(w) {
    rotate(45) square(w / sqrt(2), center = true);
}

// ---------- base ----------
// Cross-section (XZ): the back and side walls, with a 45 degree lead-in
// on the inside of each wall's front edge
module base2d() {
    difference() {
        translate([-out_hw, sheet_z0]) square([2 * out_hw, lid_z1 - sheet_z0]);
        polygon([[-in_hw, plate_t], [in_hw, plate_t], [in_hw, lid_z1 - lead_in],
                 [in_hw + lead_in, lid_z1 + 0.01], [-in_hw - lead_in, lid_z1 + 0.01],
                 [-in_hw, lid_z1 - lead_in]]);
    }
}

// Rails under the board's long edges (XZ)
module rail2d() {
    xflip_copy() translate([in_hw - rail_w, plate_t - 0.01]) square([rail_w + 0.01, pcb_z0 - plate_t + 0.01]);
}

// Foot (XZ, right side): a strut from the back and the side wall out past
// the cup's rim and down to foot_gap short of the glass. Its inner edge
// stays outside the cup's outline, rising straight from the pad past the
// rim, so the cup slides in under it.
module foot2d() {
    difference() {
        polygon([[foot_root, sheet_z0], [foot_x0, foot_z + 2], [foot_x0, foot_z], [foot_x1, foot_z],
                 [out_hw - 0.01, plate_t + foot_join], [foot_root, plate_t + foot_join]]);
        translate([-in_hw, plate_t]) square([2 * in_hw, lid_z1]);
    }
}

// Cup block behind the back, from the bottom edge to past the cup, round
// the slot. Round the lock bar channel it widens to band_hw, so the bar's
// prongs are clear of the slot; below the channel it widens at 45 degrees,
// so in print it grows out of the narrow block.
module cup_block() {
    block_h = sheet_z0 + 0.5;
    extrude_x(-spine_hw, spine_hw)
        polygon([[0, yb], [0, block_end], [-block_h, block_end], [-block_h, yb]]);
    taper = band_hw - spine_hw;
    linear_extrude(block_h, convexity = 10)
        polygon([[-spine_hw, band_y0 - taper], [spine_hw, band_y0 - taper],
                 [band_hw, band_y0], [band_hw, band_y1],
                 [-band_hw, band_y1], [-band_hw, band_y0]]);
}

// Stops that hold the board along its length, both below the PCB's top
// face so they miss the parts on it: blocks at the USB end, either side
// of the USB opening, and 45 degree wedges at the far corners, which
// print without overhang.
module board_stops() {
    z0 = plate_t - 0.01;
    z1 = pcb_z1 - 0.3;
    xflip_copy() {
        x0 = usb_plug_w / 2 + 0.3;
        translate([x0, bot_in - 0.01, z0]) cube([in_hw - x0 + 0.01, pcb_y0 - 0.2 - bot_in + 0.01, z1 - z0]);
        ys = pcb_y1 + 0.2 - (in_hw - pcb_w / 2);
        w = 2.5;
        translate([0, 0, z0]) linear_extrude(z1 - z0, convexity = 10)
            polygon([[in_hw + 0.01, ys], [in_hw + 0.01, ys + w], [in_hw - w, ys + w]]);
    }
}

// Diamond window through a side wall, for one snap bump
module snap_window(s, y) {
    translate([s * (in_hw + wall_t / 2), y, window_z])
        yrot(90) linear_extrude(wall_t + 2, center = true, convexity = 10)
            rotate(90) diamond2d(detent_w + 2 * detent_clearance * sqrt(2));
}

module base() {
    difference() {
        union() {
            extrude_y(yb, yt) base2d();
            // rails, stopping short of the lid's end wall
            extrude_y(yb, pcb_y1 + 3) rail2d();
            // bottom end
            translate([-out_hw, yb, sheet_z0]) cube([2 * out_hw, wall_t, lid_z1 - sheet_z0]);
            cup_block();
            // feet at the bottom corners; they stand on the bed in print
            extrude_y(yb, yb + foot_len) xflip_copy() foot2d();
            board_stops();
        }
        cup_slot(yb);
        // lock bar channel across the block, at head-pocket height
        translate([-band_hw - 1, chan_y0, floor_t])
            cube([2 * band_hw + 2, chan_w, pocket_h]);
        // USB-C opening, for the plug's overmold
        translate([0, yb - 1, usb_z]) xrot(-90)
            linear_extrude(wall_t + 2, convexity = 10) rect([usb_plug_w, usb_plug_h], rounding = 1.5);
        for (s = [-1, 1], y = snap_y) snap_window(s, pcb_y0 + y);
    }
}

// Print orientation: bottom end on the bed
module base_print() { translate([0, 0, -yb]) rotate([90, 0, 0]) base(); }

// ---------- lid ----------
// One snap bump on the right skirt: a diamond seen from the side, its
// faces 45 degrees all round, so it rides in over the wall's lead-in and
// pulls out again with a firm tug.
module snap_bump(y) {
    intersection() {
        translate([lid_hw - 1, y, bump_z]) yrot(90)
            linear_extrude(detent + 1, convexity = 10) rotate(90) diamond2d(detent_w);
        translate([0, y, 0]) extrude_y(-detent_w, detent_w)
            polygon([[lid_hw - 1, bump_z - detent_w / 2 - 1], [lid_hw + detent, bump_z - detent_w / 2 + detent],
                     [lid_hw + detent, bump_z + detent_w / 2 - detent], [lid_hw - 1, bump_z + detent_w / 2 + 1]]);
    }
}

// Button tongue (right side, mirrored for the left), as an outline
module key2d() {
    translate([key_root_x, key_y - key_w / 2]) square([key_end_x - key_root_x, key_w]);
}

// Slit round the tongue's three free sides
module key_slit2d() {
    difference() {
        translate([key_root_x, key_y - key_w / 2 - key_slit])
            square([key_end_x + key_slit - key_root_x, key_w + 2 * key_slit]);
        translate([key_root_x - 1, key_y - key_w / 2]) square([key_end_x - key_root_x + 1, key_w]);
    }
}

// Display window, widening outward at 45 degrees through the plate
module window_cut() {
    hull() {
        translate([0, 0, lid_z0 - 0.01]) linear_extrude(0.01, convexity = 10)
            translate([-win_hw, win_y0]) square([2 * win_hw, win_y1 - win_y0]);
        translate([0, 0, lid_z1]) linear_extrude(0.01, convexity = 10)
            translate([-win_hw - wall_t, win_y0 - wall_t]) square([2 * (win_hw + wall_t), win_y1 - win_y0 + 2 * wall_t]);
    }
}

// End wall at the top, with the SMA hole pointed toward the back (up in
// print), and the two walls on the inner nut's flats. The gap between
// them is open toward the back, so the nut slides in along the thread.
module end_wall() {
    z0 = plate_t + 0.3;
    difference() {
        union() {
            translate([-lid_hw, top_in, z0]) cube([2 * lid_hw, sma_wall, lid_z1 - z0]);
            for (s = [-1, 1])
                translate([sma_x + s * nut_hw + (s < 0 ? -nut_wall : 0), nut_y0, z0])
                    cube([nut_wall, top_in - nut_y0 + 0.01, lid_z0 - z0 + 0.01]);
        }
        translate([sma_x, top_in - 1, sma_z]) xrot(-90)
            linear_extrude(sma_wall + 2, convexity = 10)
                pointed_circle2d(sma_d / 2 + sma_clearance, sma_d / 2 + sma_clearance + 0.5);
    }
}

module lid() {
    y0 = bot_in + lid_clearance;
    difference() {
        union() {
            // front plate
            translate([-lid_hw, y0, lid_z0]) cube([2 * lid_hw, yt - y0, wall_t]);
            // skirts that press the board's edges onto the rails
            xflip_copy() translate([lid_hw - skirt_t, y0, pcb_z1 - pcb_preload])
                cube([skirt_t, top_in - y0 + 0.01, lid_z0 - pcb_z1 + pcb_preload + 0.01]);
            end_wall();
            xflip_copy() for (y = snap_y) snap_bump(pcb_y0 + y);
        }
        window_cut();
        xflip_copy() {
            // slits through the plate, and the tongues thinned from inside
            translate([0, 0, lid_z0 - 1]) linear_extrude(wall_t + 2, convexity = 10) key_slit2d();
            translate([0, 0, lid_z0 - 1]) linear_extrude(lid_z1 - key_t - lid_z0 + 1, convexity = 10) key2d();
        }
    }
    // plungers, under the tongues
    xflip_copy() translate([button_x, key_y, plunger_z0])
        cylinder(d = plunger_d, h = lid_z1 - key_t - plunger_z0 + 0.01);
}

// Print orientation: face down
module lid_print() { up(lid_z1) xrot(180) lid(); }

// ---------- lock bar (print orientation, flat) ----------
// x = 0 is the inner face of the stop head, which sits against the -X side
// of the band. The same part as the tracker holder's lock bar.
module lock_bar2d() {
    w = lock_w;
    difference() {
        union() {
            // stop head
            translate([-lock_head_len, -w / 2 - 2]) square([lock_head_len, w + 4]);
            // body
            translate([0, -w / 2]) square([lock_len, w]);
            // snap prongs with barbs; catch faces sit just past the far side
            for (s = [-1, 1])
                polygon([[lock_len, s * (w / 2 + snap_barb)],
                         [lock_len + barb_ramp, s * w / 2],
                         [lock_len + barb_ramp, 0],
                         [lock_len, 0]]);
        }
        // slit that lets the prongs flex inward, with a round relief at its root
        translate([lock_len + barb_ramp - snap_len, -snap_slit / 2])
            square([snap_len + 1, snap_slit]);
        translate([lock_len + barb_ramp - snap_len, 0]) circle(d = snap_slit);
    }
}

module lock_bar() {
    linear_extrude(lock_t, convexity = 10) lock_bar2d();
}

// Lock bar in place in the base
module lock_bar_mounted() {
    translate([-band_hw, (chan_y0 + chan_y1) / 2, floor_t + lock_clearance]) lock_bar();
}

// ---------- display models ----------
module cup_model() {
    up(glass_z) cyl(h = 1.5, d = cup_d, anchor = BOTTOM);  // rim
    up(glass_z + 1.5) cyl(h = -glass_z - 1.5, d1 = cup_d - 4, d2 = 18, anchor = BOTTOM);
    down(1) cyl(h = floor_t + 1, d = neck_d, anchor = BOTTOM);
    up(floor_t) cyl(h = head_height, d = head_d, anchor = BOTTOM);
}

// The board, in place: PCB, USB-C socket, display, GNSS patch, buttons
// and the U.FL socket with the pigtail's plug
module board_model() {
    color("darkslategray") translate([-pcb_w / 2, pcb_y0, pcb_z0]) cube([pcb_w, pcb_l, pcb_t]);
    color("silver") translate([-4.47, pcb_y0 - usb_overhang, pcb_z1]) cube([8.94, 7.35, usb_h]);
    color("teal") translate([-8, pcb_y0 + 11.4, pcb_z1]) cube([16, 32, display_top - 0.3]);
    color("black") translate([-screen_w / 2, pcb_y0 + screen_y0, pcb_z1 + display_top - 0.3])
        cube([screen_w, screen_y1 - screen_y0, 0.3]);
    color("ivory") translate([-9.5, pcb_y1 - 19.8, pcb_z1]) cube([19.8, 19.8, top_parts]);
    color("dimgray") xflip_copy() translate([button_x - 2, key_y - 2, pcb_z1]) cube([4, 4, button_h]);
    color("gold") translate([-9.7, pcb_y0 + 19.8, pcb_z1]) cyl(h = 2.5, d = 3, anchor = BOTTOM);
}

// SMA bulkhead, its two nuts and an antenna, with the pigtail's cable
module sma_model() {
    translate([sma_x, 0, sma_z]) {
        color("gold") {
            // thread, body and crimp
            translate([0, top_in - 4, 0]) ycyl(h = 4 + sma_wall + 5, d = sma_d, anchor = FRONT);
            translate([0, top_in - sma_inside, 0]) ycyl(h = sma_inside - 4, d = 4.5, anchor = FRONT);
            // nuts, flats toward the walls
            for (y = [top_in - sma_nut_t, yt + 0.5])
                translate([0, y, 0]) xrot(-90) rotate(30)
                    cylinder(h = sma_nut_t, d = sma_nut_af * 2 / sqrt(3), $fn = 6);
        }
        color("dimgray") translate([0, yt + 5, 0]) {
            ycyl(h = 12, d = 9, anchor = FRONT);
            back(12) ycyl(h = 90, d = 10, anchor = FRONT);
        }
    }
    // cable from the crimp, up over the GNSS patch, down to the U.FL socket
    path = [[sma_x, top_in - sma_inside, sma_z], [-9.7, pcb_y1 + 1, lid_z0 - 0.7],
            [-9.7, pcb_y1 - 21, lid_z0 - 0.7], [-9.7, pcb_y0 + 22, pcb_z1 + 2.5]];
    color("black") for (i = [0 : len(path) - 2]) hull() {
        translate(path[i]) sphere(d = 1.13, $fn = 16);
        translate(path[i + 1]) sphere(d = 1.13, $fn = 16);
    }
}

// USB-C plug, plugged in
module usb_plug_model() {
    color("white") translate([0, pcb_y0 - usb_overhang, usb_z]) {
        ycyl(h = 6.5, d = 2.4, anchor = BACK);
        translate([0, -6.5, 0]) cuboid([usb_plug_w - 1, 25, usb_plug_h - 1], rounding = 1.5, anchor = BACK);
    }
}

// ---------- output ----------
if (part == "mounted") {
    base();
    color("steelblue") lid();
    color("orange") lock_bar_mounted();
    color("lightgray") cup_model();
    board_model();
    sma_model();
    usb_plug_model();
    %translate([-60, -70, glass_z - 3]) cube([120, 200, 3]);
} else if (part == "all") {
    // Every part in print orientation, side by side
    base_print();
    right(60) lid_print();
    translate([-20, -37, 0]) lock_bar();
} else if (part == "base") {
    base_print();
} else if (part == "lid") {
    lid_print();
} else if (part == "lock") {
    lock_bar();
}
