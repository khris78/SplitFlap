
my_nbfaces=120;

radius_splitflap = 34.5;

card_width = 39.5;
card_height = 38;
card_thickness = 1.3;

nbHoles = 37;
hole_radius = 1.2;

ext_border = 3;
int_border = 5;
wheel_thickness = 2.5;
wall_thickness = 1.2;
interfacing_thickness = 1.7;
rotor1_wall_height = 7;

slack = 0.5;
small_slack = slack/2;

// external loop
difference() {
    cylinder(h=wheel_thickness, r = radius_splitflap + card_width*3/4, $fn=my_nbfaces);
    cylinder(h=wheel_thickness, r = radius_splitflap + card_width*3/4 -5, $fn=my_nbfaces);
}


difference() {
    union(){
        for (i=[0:7]) {
        rotate([0,0,45*i])    
            translate([0, -0.5, 0])
                cube([radius_splitflap + card_width*3/4 - 3, 1, 0.6]);
        }

        cylinder(h=0.6, r=radius_splitflap+ext_border+5);
    }

    cylinder(h=0.6, r=radius_splitflap+ext_border+slack);

   #translate([-10, -radius_splitflap-ext_border-5, 0])
        cube([10, 10, 0.6]);
}

for (i=[0:nbHoles-1]) {
    rotate([0, 0, i * 360/nbHoles]) {
        translate([radius_splitflap + card_width*3/4 - 3, card_thickness / 2 + slack - 0.5, 0])
            cube([1, 1, card_width/3]);
        translate([radius_splitflap + card_width*3/4 - 3, -card_thickness / 2 - slack - 0.5, 0])
            cube([1, 1, card_width/3]);
    }
}
    

