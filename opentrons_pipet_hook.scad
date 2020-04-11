use<round_corners.scad>;

// general parameters
$fn = 90;
eps = 0.01;
tol = 0.5;
t_tol = 0.1;

// plate parameters
p_d = 6.15;
p_t = 2;
p_h = 3;
p_H = 8.5+4;
p_xl = 74.6+p_d;
p_xu = 72.5+p_d;
p_y = 76.2+p_d;

// hook parameters
h_h = 2;
h_w = 4;

module connector(d=p_d,t=p_t,l=10,h=p_h)
{
    
    H = h+t; 
    translate([0,0,h])
    hull()
    {
        cylinder(d=d,h=t);
        translate([l,0,0]) cylinder(d=d,h=t);
    }
    cylinder(d=d,h=H);
    translate([l,0,0]) cylinder(d=d,h=H);
}


module pipet_hooks()
{
    x_off = (p_xl-p_xu)/2;
    // lower horizontal connector
    //connector(l=p_xl);
    // lower upper connector
    connector(l=p_xl,h=p_H);
    // upper horizontal connector
    translate([x_off,p_y,0]) difference()
    {   
        _t = h_w+p_t;
        _h = p_H-h_w;
        connector(l=p_xu,h=_h,t=_t);
        // cutting hole for the rubber band
        translate([p_xu/2-h_w/2,-p_d/2-eps,p_H+eps])
            cube([h_w,p_d+2*eps,h_h+2*eps]);
        translate([p_xu/2-1.5*h_w,-p_d/2-eps,p_H+eps-h_h])   
            cube([3*h_w,p_d+2*eps,h_h+2*eps]);
    }
    
    //front2back left connection
    translate([0,0,p_H])
    hull()
    {
        cylinder(d=p_d,h=p_t);
        translate([x_off,p_y,0]) cylinder(d=p_d,h=p_t);
    }
    
    //front2back right connection
    translate([p_xl,0,p_H])
    hull()
    {
        cylinder(d=p_d,h=p_t);
        translate([-x_off,p_y,0]) cylinder(d=p_d,h=p_t);
    }
    
    /*
    round_cube(x=p_x+p_d,y=p_d,z=p_t,d=p_d);
    translate([p_d/2,p_d/2,p_t]) cylinder(d=p_d, h=p_h);
    translate([p_x+p_d/2,p_d/2,p_t]) cylinder(d=p_d, h=p_h);
    
    // vertical connectors
    translate([p_d,0,0]) rotate([0,0,90])
        round_cube(x=p_y+p_d,y=p_d,z=p_t,d=p_d);
    translate([p_x+p_d,0,0]) rotate([0,0,90])
        round_cube(x=p_y+p_d,y=p_d,z=p_t,d=p_d);
    
    // upper connectors
    translate([0+p_d/2,p_y+p_d/2,p_t]) cylinder(d=p_d,h=p_h); 
    translate([p_x+p_d/2,p_y+p_d/2,p_t]) cylinder(d=p_d,h=p_h);
    */
}

pipet_hooks();