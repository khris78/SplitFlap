
my_nbfaces=120;

radius_splitflap = 34.5;
card_width = 39.5;

/* rotor 2 */

ext_border = 3;
int_border = 5;
wheel_thickness = 2.5;
wall_thickness = 1.2;
interfacing_thickness = 1.7;
rotor1_wall_height = 7;
axis_base_radius = 8;
axis_top_radius = 5.2;

hole_radius = 1.2;
slack = 0.5;

min_interfacing_high = 16;
max_interfacing_high = 20.5;

difference() {
    cube([20, 20, 5], center=true);
    
    /* Hole for the motor axis */
    translate([0, 0, -5])
    intersection() {
        cylinder(h = max_interfacing_high + 2, r = 2.6, $fn=my_nbfaces);    
        cube([50, 3.2, 2*(max_interfacing_high + 2)], center = true);
    }
}