
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

nbHoles = 37;
hole_radius = 1.2;

slack = 0.5;
small_slack = slack/2;

difference() {
    union() {
        difference() {
            /* Wheel */
            cylinder(h=wheel_thickness, r=radius_splitflap + ext_border, $fn=my_nbfaces);

            /* Holes for the cards */
            for (i = [0:nbHoles-1]) {
                translate ([cos(i*360/nbHoles) * radius_splitflap,sin(i*360/nbHoles) * radius_splitflap,  -wheel_thickness/2]) {
                    cylinder(h=2*wheel_thickness, r=hole_radius, $fn=30);
                }
            }
        }
        
        /* Cylinder between wheels */
        cylinder(h=card_width + wheel_thickness + slack, r=radius_splitflap + small_slack - int_border, $fn=my_nbfaces);
    }
    
    /* Empty the cylinder in order to let some place for the motor */
    translate([0,0,-1]) {
        cylinder(h=card_width + wheel_thickness + slack + 2, r=radius_splitflap + small_slack - int_border - wall_thickness, $fn=my_nbfaces);
    }
}

intersection() {
    /* We just want to keep the part that is inside the cylinder between wheels */
    cylinder(h=card_width + wheel_thickness + slack, r=radius_splitflap - int_border, $fn=my_nbfaces);
    
    /* Interfacing blocking part */
    for (i = [0:3]) {
        translate([sin(i*90)*(radius_splitflap - int_border) , cos(i*90) * (radius_splitflap - int_border), card_width + wheel_thickness -rotor1_wall_height-13]) {
            rotate(a=i*90) {
                translate([(interfacing_thickness + slack)/2, -2, 0])
                    cube([4, 4, 13]);
                translate([-4-(interfacing_thickness + slack)/2, -2, 0])
                    cube([4, 4, 13]);
            }
        }
    }
}