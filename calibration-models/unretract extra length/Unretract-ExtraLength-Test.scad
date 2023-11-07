/*
 * Test pattern to tune extra unretract length of FDM printers.
 * 
 * (c) 2023 Frank Zechert
 * Distributed under MIT License
 */
 
// Nozzle Size of the printer, and also line width for the test.
nozzle_size = 0.4;
// Height of the first layer.
layer_height = 0.2;
// Width of the test pattern in mm.
pattern_width = 200;
// Length of the test pattern in mm.
pattern_length = 200;
// Number of test retractions.
number_of_retractions = 5;
// Number of test repetitions.
number_of_repetitions = 5;

function direction(value) = 0 == sign(value) ? 1 : sign(value);

module draw_line(from, to) {
    x_distance = to[0] - from[0];
    y_distance = to[1] - from[1];
    
    distance = sqrt(x_distance ^ 2 + y_distance ^ 2);
    angle = distance == 0 ? 0 : 
        (x_distance < 0 ? 180 - asin(y_distance / distance) : asin(y_distance / distance));
    
    echo("Distance x:", x_distance, "Distance y:", y_distance, "Distance:", distance, "Angle:", angle);
    
    linear_extrude(layer_height) {
        translate(from) {
            rotate([0, 0, angle]) {
                translate([0, -nozzle_size / 2]) {
                    square([distance, nozzle_size], false);
                }
            }
        }
    }
}

module outer_perimeter() {
    draw_line([0, 0], [pattern_width, 0]);
    draw_line([pattern_width, 0], [pattern_width, pattern_length]);
    draw_line([pattern_width, pattern_length], [0, pattern_length]);
    draw_line([0, pattern_length], [0, 0]);
}


x_interval = pattern_width / (number_of_retractions + 1);
y_interval = pattern_length / (number_of_repetitions + 3);

module scale() {
    for (x = [1 : number_of_retractions]) {
        draw_line([x * x_interval, y_interval * 0.5], [x * x_interval, y_interval * 2.5]);
        if (x < number_of_retractions) {
            draw_line([x * x_interval, y_interval], [(x + 1) * x_interval, y_interval]);
            draw_line([x * x_interval, y_interval * 1.5], [(x + 1) * x_interval, y_interval * 1.5]);
            draw_line([x * x_interval, y_interval * 2], [(x + 1) * x_interval, y_interval * 2]);
        }
    }
}

module test() {
    for (x = [ 1 : number_of_repetitions]) {
        x_start = x_interval + x_interval * ((x - 1) % 3) - nozzle_size / 2;
        x_end = x_interval * (3 + ((x - 1) % 3)) + nozzle_size / 2;
        y_start = y_interval * (2 + x);
        y_end = y_interval * (2 + x);
        draw_line([x_start, y_start], [x_end, y_end]);
    }
}

outer_perimeter();
scale();
test();
