echo(version=version());

my_nbfaces=120;

font = "Linux Libertine Mono O";

letter_size = 40;
letter_height = 0.5;
letter_footprint = 0.2;

card_thickness = 1.3;
card_width = 39.5;
card_height = 38;

wheel_thickness = 2.5;
hole_radius = 1.2;
slack = 0.5;

letter_top="A";

module letter(l) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = letter_height) {
		text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = my_nbfaces);
	}
}

translate([0, 2, 0])
    difference() {
        letter(letter_top);
        rotate([0, 0, 180])
            translate([-2*card_width, 0, -letter_height])
                cube([4*card_width, 4* card_height, 2*letter_height]);
    }

translate([0, -2, 0])
    difference() {
        letter(letter_top);
        translate([-2*card_width, 0, -letter_height])
            cube([4*card_width, 4* card_height, 2*letter_height]);
    }


