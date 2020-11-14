
my_nbfaces=120;

radius_splitflap = 34.5;
card_width = 39.5;

/* rotor 2 */

ext_border = 3;
int_border = 5;
stator_thickness = 3.5;
wall_thickness = 1.2;
interfacing_thickness = 1.7;
rotor1_wall_height = 7;
axis_base_radius = 8;
axis_top_radius = 5.2;

hole_radius = 1.2;
slack = 0.5;

min_interfacing_high = 16;
max_interfacing_high = 20.5;

stand_thickness = 3;
stand_height=17;
stand_radius=3.5;
screw_radius=1.6;

stand_base_length = 24;

motor_radius=14;
motor_height=19;
screw_distance=35;

difference() {
    union() {
        /* main body */
        cylinder(h=stator_thickness, r=radius_splitflap - int_border - wall_thickness - slack/2, $fn=my_nbfaces);

        /* motor stand */
        for (i=[0:1]) {
            translate([(i*2-1)*screw_distance/2, 8, stator_thickness]) {
                cylinder(r=stand_radius, h=stand_height, $fn=my_nbfaces);
                hull() {
                    translate([-stand_thickness/2, -stand_base_length/2, 0])
                        cube([stand_thickness, stand_base_length, 0.1]);
                    translate([-stand_thickness/2, -stand_radius+0.15, stand_height - 0.1])
                        cube([stand_thickness, (stand_radius-0.15)*2, 0.1]);
                }
            }
        }
    }
    
    /* screws*/
    for (i=[0:1]) {
        translate([(i*2-1)*screw_distance/2, 8, -1]) {
            cylinder(r=screw_radius+slack/2, h=stand_height + stator_thickness + 2, $fn=my_nbfaces);
        }
    }
    
    /* motor back */
    translate([0, 8, -1])
    {
        cylinder(h=stand_thickness + 2, r=motor_radius + slack/4, $fn=my_nbfaces);
    
        hull() {
        cube([1.5 * motor_radius, 0.1, 4*stand_thickness+2], center=true);
        translate([0, motor_radius, 0]) 
            cube([1.5 * motor_radius, 0.1, 4*stand_thickness+2], center=true);
        translate([0, 1.15 * motor_radius, 0]) 
            cube([1.2 * motor_radius, 0.1, 4*stand_thickness+2], center=true);
        }
    }
}

translate([-(motor_radius*2 + 2) / 2, 5, 0])
cube([motor_radius*2 + 2, 6, stator_thickness + stand_height - motor_height]);