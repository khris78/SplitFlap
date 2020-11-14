
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

nbHoles = 37;
hole_radius = 1.2;
slack = 0.5;

min_interfacing_high = 16;
max_interfacing_high = 20.5;

difference() {
    union() {
        difference() {
            union() {
                difference() {
                    /* Wheel */
                    rotate([0, 180, 0])
                        translate([0, 0, -wheel_thickness])
                            cylinder(h=wheel_thickness, r=radius_splitflap + ext_border, $fn=my_nbfaces);

                    /* Holes for the cards */
                    for (i = [0:nbHoles-1]) {
                        translate ([cos(i*360/nbHoles) * radius_splitflap,sin(i*360/nbHoles) * radius_splitflap,  -wheel_thickness/2]) {
                            cylinder(h=2*wheel_thickness, r=hole_radius, $fn=30);
                        }
                    }
                }
                
                /* Cylinder between wheels */
                cylinder(h=rotor1_wall_height + wheel_thickness, r=radius_splitflap - int_border - wall_thickness, $fn=my_nbfaces);
              
            }
            
            /* Empty the cylinder in order to let some place for the motor */
            translate([0,0,wheel_thickness]) {
                cylinder(h=rotor1_wall_height + wheel_thickness, r=radius_splitflap - int_border - 2 * wall_thickness, $fn=my_nbfaces);
            }

            /* Make holes to see through the wheel */
            for (i = [0:3]) {
                wheel_hole_radius = (radius_splitflap - int_border - 2 * wall_thickness - axis_base_radius - 5) / 2;
                wheel_hole_center_dist = radius_splitflap - int_border - 2 * wall_thickness - 2.5 - wheel_hole_radius;
                translate([cos(45 + i * 90) * wheel_hole_center_dist, sin(45 + i * 90) * wheel_hole_center_dist, -wheel_thickness/2]) {
                    cylinder(r = wheel_hole_radius, h=2 * wheel_thickness, $fn=30);
                }
            }
            
        }

        /* interfacing walls */
        intersection() {
            cylinder(h=max_interfacing_high, r=radius_splitflap - int_border - wall_thickness, $fn=my_nbfaces);    
            
            for (i = [0:3]) {
                rotate([0, 0, i*90]) {
                    hull() {
                    translate([0, -interfacing_thickness / 2, 0])
                        cube([0.1, interfacing_thickness, min_interfacing_high]);
                    translate([radius_splitflap - int_border - wall_thickness, -interfacing_thickness / 2, 0])
                        cube([0.1, interfacing_thickness, max_interfacing_high]);
                    }
                }
            }
        }

        /* central axis */
        hull() {
            translate([0,0, wheel_thickness]) {
                cylinder(h=0.1, r=axis_base_radius, $fn=my_nbfaces);
            }
            translate([0, 0, max_interfacing_high - 0.1]) {
                cylinder(h=0.1, r=axis_top_radius, $fn=my_nbfaces);
            }
        }
    }

    /* Hole for the motor axis */
    intersection() {
        cylinder(h = max_interfacing_high + 2, r = 2.6, $fn=my_nbfaces);    
        cube([50, 3.2, 2*(max_interfacing_high + 2)], center = true);
    }
}

translate([-5, -radius_splitflap-ext_border-4.5, 0]) {
    difference() {
    cube([5, 5, wheel_thickness]);

    rotate([0, 0, -30])
        translate([-5, -1, -1])
            cube([10, 5, wheel_thickness + 2]);
    }
}

