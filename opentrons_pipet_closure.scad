eps = 0.01;
$fn = 90;

// used libraries
use<round_corners.scad>;


// basic geometry parameters
g_x = 89;
g_y = 91;
g_z = 11;
g_d = 4;
// advanced geometry parameters
// cut paramers
// wall thickness
wt = 2;
// locking-border thickness
bt = 1; 

// In the end, I only wish for closure.
module closure()
{
    difference()
    {
        // body basic shape
        round_cube(x=g_x,y=g_y,z=g_z,d=g_d);
        
        // main cut
        translate([wt,wt,-eps]) round_cube(x=g_x-2*wt,y=g_y-2*wt,z=g_z-wt+eps,d=g_d);
        
        // border cut 
        translate([bt,bt,-eps]) round_cube(x=g_x-2*bt,y=g_y-2*bt,z=bt+eps,d=g_d);
    }
}

closure();