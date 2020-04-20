eps = 0.01;
$fn = 90;

// used libraries
use<round_corners.scad>;

// M3 parameters
// bold diameter
m3_bd = 3;
// bold height
m3_bh = 18;
// nut diameter
m3_nd = 6.5;
// nut height
m3_nh = 2.5;
// bolt head diameter
m3_bhd = 5.5;
// bolt head height
m3_bht = 2;


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

// holes parameters
h_xf = 80;
h_xb = 78;
h_y = 82;

// In the end, I only wish for closure.
module closure()
{
    // bolt and nuts hole
    // front x offset
    _xfo = (g_x-h_xf)/2;
    _xbo = (g_x-h_xb)/2;
    _yo = (g_y-h_y)/2;
    
    hps = [ [_xfo,_yo,-eps],
            [g_x-_xfo,_yo,-eps],
            [_xbo,g_y-_yo,-eps],
            [g_x-_xbo,g_y-_yo,-eps]];
    
    difference()
    {
        // body basic shape
        round_cube(x=g_x,y=g_y,z=g_z,d=g_d);
        
        // main cut
        translate([wt,wt,-eps]) round_cube(x=g_x-2*wt,y=g_y-2*wt,z=g_z-wt+eps,d=g_d);
        
        // border cut 
        translate([bt,bt,-eps]) round_cube(x=g_x-2*bt,y=g_y-2*bt,z=bt+eps,d=g_d);
        
        // frontal cut
        translate([g_d,-eps,-eps]) cube([g_x-2*g_d,wt+2*eps,g_z-wt+eps]);

      
        // nuts and bolts holes
        for (i=[0:len(hps)-1])
        {
            translate(hps[i])
            {
                // bolt
                cylinder(h=g_z+2*eps,d=m3_bd);
                // nut
                translate([0,0,g_z-1]) cylinder(h=1+2*eps,d=m3_nd,$fn=6);
            }
        }
        
        // adding text
        _tt = 0.1;
        translate([g_x/2,g_y-15,g_z-wt+_tt-eps])
            rotate([0,180,0])
                linear_extrude(_tt)
                    text(   text="I am sorry Sarrah...", size=6,
                            font="Malgun Gothic:style=Bold",
                            halign="center", valign="center");

    }   
    
    
    // adding bold distancers
    for(i=[0:len(hps)-1])
    {
        translate(hps[i])
        translate([0,0,bt])
        difference()
        {
            _h = g_z-bt-wt;
            // outer shell
            cylinder(d=2+m3_bd,h=_h);
            // bolt hole
            translate([0,0,-eps]) cylinder(d=m3_bd,h=_h+2*eps);
        }
    }
}

closure();