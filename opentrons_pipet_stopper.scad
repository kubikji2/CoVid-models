// general parameters
$fn = 90;
eps = 0.01;

g_l = 9;

d = 6;
t = 3.5;
wt = 1.5;
D = d+2*1;

module pipet_stopper()
{
    difference()
    {
        hull()
        {
            cylinder(h=t,d=D);
            translate([7*g_l,0,0]) cylinder(h=t,d=D);
        }
        
        for(i=[0:7])
        {
            translate([i*g_l,0,-eps])cylinder(h=t+2*eps,d=d);
        }
        translate([0,-wt/2,-eps]) cube([7*g_l,wt,t+2*eps]);
        
    }
}

pipet_stopper();