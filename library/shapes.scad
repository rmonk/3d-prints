// Shared 2D shapes
// -------------------------------------------------------------
// Small helpers used by more than one project. Include it with
//   include <../../library/shapes.scad>
// (suction_cup.scad already includes it). All dimensions in mm.

// Circle with a 45 degree point toward +Y, cut flat at y = top.
// Used for holes that lie sideways in the print, point up.
// (Not named teardrop2d, which BOSL2 already defines differently.)
module pointed_circle2d(r, top) {
    intersection() {
        union() {
            circle(r);
            rotate(45) square(r);
        }
        translate([-2 * r, -2 * r]) square([4 * r, 2 * r + top]);
    }
}
