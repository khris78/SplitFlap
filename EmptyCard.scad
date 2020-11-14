echo(version=version());

my_nbfaces=120;

letter_size = 40;
letter_height = 5;
letter_footprint = 0.2;

card_thickness = 1.3;
card_width = 39.5;
card_height = 38;

wheel_thickness = 2.5;
hole_radius = 1.2;
slack = 0.5;

difference() {
    union() 
    {
        /* main surface */
        cube([card_width - slack, card_height, card_thickness]);

        difference() {
            translate([-wheel_thickness - slack, card_height - 2.4, hole_radius - slack]) {
                rotate([0, 90, 0]) {
                    cylinder(h=card_width + 2 * wheel_thickness + 2 * slack, r= hole_radius - slack, $fn=my_nbfaces);
                }
            }
            
            translate([0, 0, card_thickness])
                cube([card_width - slack, card_height, card_thickness]);
        }
    }
}


