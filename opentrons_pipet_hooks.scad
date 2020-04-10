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
p_x = 80;

module pipet_hooks()
{
    round_cube(x=p_x+p_d,y=p_d,z=p_t,d=p_d);
    translate([p_d/2,p_d/2,p_t]) cylinder(d=p_d, h=p_h);
    translate([p_x+p_d/2,p_d/2,p_t]) cylinder(d=p_d, h=p_h);
    
}

pipet_hooks();