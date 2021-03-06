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
p_xl = 74.6+p_d;
p_xu = 72.5+p_d;
p_y = 76.2+p_d;
p_H = p_t+p_h+2;

// hooks parameters
h_h = 2;
h_w = 4;

// secondary hooks parameters
h2_h = 32;
h2_yo = 5+p_d;
h2_xo = 5;


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
    connector(l=p_xl,h=p_h);
    cylinder(h=p_H,d=p_d);
    translate([p_xl,0,0])cylinder(h=p_H,d=p_d);
    
    //front2back left connection
    translate([0,0,p_H])
    hull()
    {
        cylinder(d=p_d,h=p_t);
        translate([x_off,p_y,0]) cylinder(d=p_d,h=p_t);
    }
    translate([x_off,p_y,0]) cylinder(d=p_d,h=p_t+p_H);
    
    //front2back right connection
    translate([p_xl,0,p_H])
    hull()
    {
        cylinder(d=p_d,h=p_t);
        translate([-x_off,p_y,0]) cylinder(d=p_d,h=p_t);
    }
    translate([p_xl-x_off,p_y,0]) cylinder(d=p_d,h=p_t+p_H);
    
    // upper additional hooks
    translate([x_off,p_y+h2_yo,p_H-h2_h+p_t])
    {
        // pillar with hook
        difference()
        {
            union()
            {
                cylinder(d=p_d,h=h2_h);
                // connector
                translate([0,0,h2_h-p_t])
                hull()
                {
                    cylinder(d=p_d,h=p_t);
                    translate([0,-h2_yo,0]) cylinder(d=p_d,h=p_t);
                }
            }
            translate([-1,0,-eps]) cube([2,p_d,h2_h+2*eps]);
         }
        
    }
    
    translate([x_off+p_xu,p_y+h2_yo,p_H-h2_h+p_t])
    {
        // pillar 
        difference()
        {
            union()
            {
                cylinder(d=p_d,h=h2_h);
                // connector
                translate([0,0,h2_h-p_t])
                hull()
                {
                    cylinder(d=p_d,h=p_t);
                    translate([0,-h2_yo,0]) cylinder(d=p_d,h=p_t);
                }
            }
            translate([-1,0,-eps]) cube([2,p_d,h2_h+2*eps]);
        }
        
    }
    
}

pipet_hooks();