echo(version=version());

my_nbfaces=120;

font = "Linux Libertine Mono O";

letter_size = 40;
letter_height = 5;
letter_footprint = 0.2;

card_thickness = 1.3;
card_width = 39.5;
card_height = 38;

wheel_thickness = 2.5;
hole_radius = 1.2;
slack = 0.5;

letter_top="A";
letter_bottom="B";

module letter(l) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = my_nbfaces);
	}
}


difference() {
    union() 
    {
        /* main surface */
        cube([card_width - slack, card_height, card_thickness]);

        difference() {
            translate([-wheel_thickness - slack / 2, card_height - (hole_radius - slack)- 1, hole_radius - slack]) {
                rotate([0, 90, 0]) {
                    cylinder(h=card_width + 2 * wheel_thickness, r= hole_radius - slack, $fn=my_nbfaces);
                }
            }
            
            translate([0, 0, card_thickness])
                cube([card_width - slack, card_height, card_thickness]);
        }
    }

    translate([card_width/2, card_height, card_thickness - letter_footprint]) 
        letter(letter_bottom);
    
    translate([card_width/2, card_height, letter_footprint])
        rotate([180, 0, 0])
            letter(letter_top);
}


