// general parameters
$fn = 90;
eps = 0.01;

g_l = 9;

// hole parameters
d = 5.2;
D = 7.5;
H = 27-12.3;
h = 1.5;

// body parameters
wt = 1;
y_o = 1;

// connectors parameters
// connector bolt diameter
c_bd = 3.5;
// connector nut diameter
c_nd = 5.75;
// connector wall thickness
c_wt = 2;
// distance from one hole to another
c_l = 77.5+2*c_bd+2*c_wt;
// offset in x axis
c_xo = -(c_l-8*g_l)/2;
// connector dimension size in x axis
c_x = 2*c_wt+c_bd;
// connectors y offset
c_yo = -1;
// connector dimension in y axis
c_y = 2*c_wt;
// connector dimension in z axis
c_z = 15+c_bd+c_wt;


// box parameters
x = 8*g_l;
y = g_l;
z = h+H;

module pipet_tip_holder()
{
    difference()
    {
        //%cube([x,y,z]);
        
        union()
        {
            // main holder body
            hull()
            {
                cylinder(d=g_l,h=H+h);
                translate([7*g_l,0,0]) cylinder(d=g_l,h=H+h);
            }
            // connector connector
            translate([c_xo-g_l/2,c_yo-c_y,0]) cube([c_l,c_y,H+h]);
            // left connector
            translate([c_xo-g_l/2,c_yo-c_y,0])
                cube([c_x,c_y,c_z]);
            // right connector
            translate([c_l+c_xo-c_x-g_l/2,c_yo-c_y,0])
                cube([c_x,c_y,c_z]);
                
        }
        
        // holes for pipet heads
        for(i=[0:7])
        {
            _xo = i*g_l;
            translate([_xo,0,0])
            {
                translate([0,0,h-eps]) cylinder(h=H+2*eps,d=D);
                translate([0,0,-eps])cylinder(h=h+2*eps,d=d);
            }
        }
        
        // left connector bolt hole
        translate([c_xo-g_l/2,c_yo-c_y,0])
        {
            // bolt hole
            translate([c_x/2,c_y+eps,c_z-c_bd/2-c_wt])
                rotate([90,0,0])
                    {
                        // bolt hole
                        cylinder(d=c_bd,h=c_y+2*eps);
                        // nut hole
                        translate([0,0,c_wt+eps])
                            cylinder(d=c_nd,h=c_wt+2*eps,$fn=6);
                    }
            
        }
        
        // right connector bolt hole
        translate([c_l+c_xo-c_x-g_l/2,c_yo-c_y,0])
        {
            // screw hole for M3 bolt and nut
            translate([c_x/2,c_y+eps,c_z-c_bd/2-c_wt]) 
                rotate([90,0,0])
                    {
                        // bolt hole
                        cylinder(d=c_bd,h=c_y+2*eps);
                        // nut hole
                        translate([0,0,c_wt+eps])
                            cylinder(d=c_nd,h=c_wt+2*eps,$fn=6);
                    }
        }
            
    }
    
    
}

pipet_tip_holder();