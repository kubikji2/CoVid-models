use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// frame parameters
b_x = 127.9;
b_y = 86;
b_z = 8;

// holder parameters
h_x = 113.5;
h_y = 71.5;
h_h = 3.3;
h_t = 4.5;

// box parameters
d_i = 1;
x_i = 120;
y_i = 83.5;
// border thickness
b_t = 10;
// border height
b_h = 2.5;

// lock offset
l_off = 12;
w_t = 2;

// wing parameters
w_l = 10;

module frame()
{
    // main inner frame
    difference()
    {
        // basic shape
        round_cube(x=b_x,y=b_y,z=b_z,d=4);
        
        // tips rack holder hole
        translate([(b_x-x_i)/2,(b_y-y_i)/2,b_h-eps])
            cube([x_i,y_i,b_z-b_h+2*eps]);
        
        // lower hole
        translate([b_t,b_t,-eps])
            round_cube(x=b_x-2*b_t,y=b_y-2*b_t,z=b_h+2*eps,d=2);
    }
    
    translate([(b_x-x_i)/2,l_off,0]) cylinder(d=d_i,h=b_z);
    translate([b_x-(b_x-x_i)/2,l_off,0]) cylinder(d=d_i,h=b_z);
    translate([(b_x-x_i)/2,b_y-l_off,0]) cylinder(d=d_i,h=b_z);
    translate([b_x-(b_x-x_i)/2,b_y-l_off,0]) cylinder(d=d_i,h=b_z);
    
}

//frame();

module side_frame()
{
    difference()
    {
        // main shape for lock
        translate([0,-h_y/2,0])
            cube([h_t+w_l,h_y,w_t+h_t]);
        // cut for outer frame
        translate([-eps,-h_y/2-eps,-eps])
            cube([h_t,h_y+2*eps,h_h]);
    }
    // lower wings
    translate([h_t,-b_y/2,0])
        round_cube(x=w_l,y=b_y,z=b_h,d=4);
    // leverage
    translate([h_t+w_l-eps,h_y/2,h_t]) hull()
    {
        d_ = 0.01;
        rotate([90,0,0]) cylinder(d=d_, h=h_y);
        translate([0,0,w_t]) rotate([90,0,0])
            cylinder(d=d_, h=h_y);
        translate([w_t,0,w_t]) rotate([90,0,0])
            cylinder(d=d_, h=h_y);
    }
    // levarage support
    translate([0,-h_y/2,h_t+w_t])
        cube([h_t+w_l+w_t,h_y,b_z-h_t-w_t]);
    
}

//side_frame();

module advanced_frame()
{
    // basic frame
    frame();
    
    // left frame
    translate([0,b_y/2,0]) rotate([0,0,180])
        side_frame();
    
    // right frame
    translate([b_x,b_y/2,0]) side_frame();
}

advanced_frame();
