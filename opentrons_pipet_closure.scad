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

// shoulders parameters
s_x = 40;
// y dimension is measured from back holes center
// e.g. requires adding distance from center to the border
s_y = 17+(g_y-h_y)/2;
// final height in z axis including roof
s_z = 15;

// neck parameters
n_x = s_x;
n_y = 22;
n_z = 13.5;

// neck holes parameters
nhl_d = 5.8;
nhl_l = nhl_d+24;
nhl_yo = n_y - nhl_d/2 - 14.5;

// neck holes upper left diameter
nhu_ld = 5.7;
nhu_rD = 6.2;
nhu_rd = 3.5;
nhu_rh = 6;
nhu_l = nhu_ld/2+nhu_rD/2+14.4;

nhu_xo = 7+nhu_ld/2;
nhu_yo = n_y-(4.5+nhu_ld/2);

// neck sloped cut
sc_y1 = 2;
sc_y2 = 7;

// trench parameters
t_y = n_y-13;
t_z = 6;

// fortification parameters
f_xl = 21;
f_xu = 13;
f_yl = 7.6;
f_d = 1.7;


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
        union()
        {
            // chest shape
            round_cube(x=g_x,y=g_y,z=g_z,d=g_d);
            
            // shoulders
            translate([0,g_y-g_d,0])
                    cube([g_x,g_d,g_z]);
            hull()
            {
                translate([0,g_y-eps,0])
                    cube([g_x,eps,g_z]);
                translate([g_x/2-s_x/2,g_y+s_y-eps,0])
                    cube([s_x,eps,s_z]);
            }
            
            // neck
            translate([(g_x/2-n_x/2),g_y+s_y,0])
                cube([n_x,n_y,n_z]);
            
            
        }
    
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
        
        // neck cuts
        translate([g_x/2-n_x/2,g_y+s_y,0])
        {
            // digging trench
            translate([-eps,0,n_z-t_z+eps])
                cube([s_x+2*eps,t_y,t_z+eps]);
            
            // digging fortification
            translate([n_x/2-f_xu/2,eps,n_z-f_d+eps])
                cube([f_xu,n_y+2*eps,f_d]);
            translate([n_x/2-f_xl/2,t_y-eps,n_z-f_d+eps])
                cube([f_xl,f_yl+2*eps,f_d]);
            
            // neck piercings
            // lower
            translate([n_x/2-nhl_l/2,0,-eps])
            {
                translate([0,nhl_yo,0])
                    cylinder(d=nhl_d, h=n_z+2*eps);
                translate([nhl_l,nhl_yo,0])
                    cylinder(d=nhl_d, h=n_z+2*eps);
            }
            
            // I should not be making fun of comments...
            // ... but I am running low on both sanity and will
            
            // neck piercings
            // upper
            translate([nhu_xo,nhu_yo,-eps])
            {
                // left hole
                cylinder(h=n_z+2*eps,d=nhu_ld);
                // right hole
                translate([nhu_l,0,0])
                {
                    cylinder(h=n_z+2*eps,d=nhu_rd);
                    // right upper hole
                    translate([0,0,n_z-nhu_rh])
                        cylinder(h=nhu_rh+2*eps,d=nhu_rD);
                }                
            }
            
            difference()
            {
                union()
                {   
                    // main lower cut
                    translate([wt,-eps,-eps])
                        cube([n_x-2*wt,n_y+2*eps, n_z-wt-t_z+eps]);
                        
                    
                    // main upper cut
                    translate([wt,t_y+wt,-eps])
                        cube([n_x-2*wt,n_y-t_y-wt+2*eps,n_z-wt-f_d]);           
                }
                
                // lower screw shafts
                translate([n_x/2-nhl_l/2,0,-eps])
                {
                    translate([0,nhl_yo,0])
                        cylinder(d=nhl_d+2*wt, h=n_z+2*eps);
                    translate([nhl_l,nhl_yo,0])
                        cylinder(d=nhl_d+2*wt, h=n_z+2*eps);
                }
                
                // upper screw shafts
                translate([nhu_xo,nhu_yo,-eps])
                {
                    // left hole
                    cylinder(h=n_z+2*eps,d=nhu_ld+2*wt);
                    // right hole
                    translate([nhu_l,0,0]) hull()
                    {
                        cylinder(h=n_z+2*eps,d=nhu_rd+2*wt);
                        // right upper hole
                        translate([0,0,n_z-nhu_rh])
                            cylinder(h=nhu_rh+2*eps,d=nhu_rD+2*wt);
                    }                
                }
                               
            }
            
            // I just want to be sure, that I am not bad person.
            
            // sloped cut
            translate([-eps,sc_y1,0]) hull()
            {
                // lower front
                rotate([0,90,0]) cylinder(h=wt+2*eps,d=eps);
                // lower back
                translate([0,n_y-sc_y1,0]) rotate([0,90,0])
                    cylinder(h=wt+2*eps,d=eps);
                // upper back
                translate([0,n_y-sc_y1,n_z-wt]) rotate([0,90,0])
                    cylinder(h=wt+2*eps,d=eps);
                                // upper back
                translate([0,n_y-sc_y1-sc_y2,n_z-wt]) rotate([0,90,0])
                    cylinder(h=wt+2*eps,d=eps);
            }
            
            // cubic cut next to the sloped cut
            // TODO might be optional
            translate([-eps,n_y-sc_y2+eps,-eps])
                cube([(n_x-f_xu)/2-wt,sc_y2,n_z-wt+2*eps]);
                        
        
        }
        
        // shoulders cut
        translate([wt,g_y,-eps]) hull()
        {
            translate([(g_x-h_xb)/2,0,0]) cube([h_xb-2*wt,eps,g_z-wt]);
            translate([(g_x-n_x)/2,s_y,0]) cube([n_x-2*wt,eps,n_z-wt]);
        }
        
        
        // just... keep going
        // go not cry
        
        // border cut
        translate([wt-bt,g_y-bt/2,-eps]) hull()
        {
            translate([0,0-eps-g_d/2,0])cube([g_x-2*bt,eps,bt]);
            translate([0,0-eps,0]) cube([g_x-2*bt,eps,bt]);
            translate([(g_x-n_x)/2,s_y,0]) cube([n_x-2*bt,eps,bt]);
        }
        
        // connecting cut
        translate([(g_x-h_xb)/2+wt,g_y-wt-eps,-eps])
            cube([h_xb-2*wt,wt+2*eps,g_z-wt]);
        
        
        
        // adding product placement
        _pp_t = 1;
        translate([g_x/2,g_y/2-10,g_z-_pp_t-eps])
            rotate([0,0,0])
                linear_extrude(_pp_t+2*eps)
                    text(   text="FEL ČVUT", size=10,
                            font="Arial:style=Bold",
                            halign="center", valign="center");
        
        translate([g_x/2,g_y/2+10,g_z-_pp_t-eps])
            rotate([0,0,0])
                linear_extrude(_pp_t+2*eps)
                    text(   text="PřF UK", size=10,
                            font="Arial:style=Bold",
                            halign="center", valign="center");

        // This should be my magnum opus,
        // my materialized wish for forgiveness..
        
        // adding msg
        _tt = 0.1;
        translate([g_x/2,g_y-15,g_z-wt+_tt-eps])
            rotate([0,180,0])
                linear_extrude(_tt)
                    text(   text="I am so sorry Sarrah...", size=5.5,
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


// possible names = ["torso", "bust"]
module closure_part(name)
{
    difference()
    {
        
        // main geometry
        closure();
        
        if(name != "torso")
        {
            translate([-eps,-eps,-eps])
                cube([g_x+2*eps,g_y+2*eps,g_z+2*eps]);
        }
        
        if(name != "bust")
        {
            translate([-eps,g_y-eps,-eps])
                cube([g_x+2*eps,s_y+n_y+2*eps,s_z+2*eps]);
            
        }
    }
}



closure_part("torso");