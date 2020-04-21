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

// holes parameters
h_xf = 80+1.5;
h_xb = 79+1;
h_y = 82;
h_yo = 2.5;


// basic geometry parameters
g_x = 90;
g_y = 91+h_yo;
g_z = 12;
g_d = 8;
// advanced geometry parameters
// cut paramers
// wall thickness
wt = 2;
// locking-border thickness
bt = 1; 

// pipet tip holder cuts parameters
pth_y = 7.5+h_yo;
pth_z = 6;

// shoulders parameters
s_x = 40;
// y dimension is measured from back holes center
// e.g. requires adding distance from center to the border
s_y = 17-(g_y-h_y)/2+h_yo;
//echo(s_y);
// final height in z axis including roof
s_z = 15;

// neck parameters
n_x = s_x;
n_y = 20;
n_z = 13;

// neck holes parameters
nhl_d = 5.8;
nhl_l = nhl_d+24;
nhl_yo = n_y - nhl_d/2 - 13.5;

// neck holes upper left diameter
nhu_ld = 5.7;
nhu_rD = 6.2;
nhu_rd = 3.5;
nhu_rh = 6;
nhu_l = nhu_ld/2+nhu_rD/2+14.4;

nhu_xo = 7+nhu_ld/2;
nhu_yo = n_y-(3.5+nhu_ld/2);

// neck sloped cut
sc_y1 = 2;
sc_y2 = 8;

// trench parameters
t_y = n_y-13;
t_z = 6;

// fortification parameters
f_xl = 21;
f_xu = 13;
f_yl = 7.6;
f_d = 1.7;

// support beams
sb_w = 5;
sb_t = 2;


// In the end, I only wish for closure.
module closure()
{
    // bolt and nuts hole
    // front x offset
    _xfo = (g_x-h_xf)/2;
    _xbo = (g_x-h_xb)/2;
    _yo = (g_y-h_y-h_yo)/2;
    
    hps = [ [_xfo,_yo+h_yo,-eps],
            [g_x-_xfo,_yo+h_yo,-eps],
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
                translate([g_x/2-s_x/2,g_y+s_y-eps-1,0])
                    cube([s_x,eps,s_z]);
            }
            translate([g_x/2-s_x/2,g_y+s_y-eps-1,0])
                    cube([s_x,1+eps,s_z-bt]);
            
            // neck
            translate([(g_x/2-n_x/2),g_y+s_y,0])
                cube([n_x,n_y,n_z]);
            
            
        }
    
        // main cut
        difference()
        {
            translate([wt,wt,-eps])
                round_cube(x=g_x-2*wt,y=g_y-2*wt,z=g_z-wt+eps,d=g_d);
            // support beams
            // front <-> beack
            for(i=[1:3])
            {
                _xo = (g_x/4)*i-sb_w/2;
                translate([_xo,0,g_z-wt-sb_t])
                    cube([sb_w,g_y,sb_t]);
            }
            // left <-> right
            for(i=[2:4])
            {
                
                _w = (i==2) ? 2*sb_w : sb_w;
                _yo = (g_x/4)*i-sb_w/2;
                //echo(_yo);
                translate([0,_yo,g_z-wt-sb_t])
                    cube([g_x,_w,sb_t]);
            }
        }
        
        // border cut 
        translate([bt,bt,-eps])
            round_cube(x=g_x-2*bt,y=g_y-2*bt,z=bt+eps,d=g_d);
        
        // frontal cut
        _fc_xo = (g_x-h_xf)/2+m3_bd/2+1;
        translate([_fc_xo,-eps,-eps])
            cube([g_x-2*_fc_xo,wt+2*eps,g_z-wt+eps-sb_t]);
        
        // connecting cut
        // torso <-> shoulders
        translate([(g_x-h_xb)/2+wt,g_y-wt-eps,-eps])
            cube([h_xb-2*wt,wt+2*eps,g_z-wt-sb_t]);

        // pipet tip holder side cuts
        translate([-eps,-eps,-eps]) cube([g_x+2*eps,pth_y+eps,pth_z+eps]);
      
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
        
        ///////////////
        // NECK CUTS //
        ///////////////
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
            
            ///////////////////////
            // NECK INTERIOR CUT //
            ///////////////////////
            
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
            
            // side sloped cut
            translate([-eps,sc_y1,0]) hull()
            {
                _h = 2*wt;
                // lower front
                rotate([0,90,0]) cylinder(h=_h,d=eps);
                // lower back
                translate([0,n_y-sc_y1,0]) rotate([0,90,0])
                    cylinder(h=_h,d=eps);
                // upper back
                translate([0,n_y-sc_y1,n_z-wt]) rotate([0,90,0])
                    cylinder(h=_h,d=eps);
                                // upper back
                translate([0,n_y-sc_y1-sc_y2,n_z-wt]) rotate([0,90,0])
                    cylinder(h=_h,d=eps);
            }
            
            
            // cubic cut next to the sloped cut
            // TODO might be optional
            translate([-eps,n_y-sc_y2+eps,-eps])
                cube([(n_x-f_xu)/2-wt,sc_y2,n_z-bt+2*eps]);
                        
        
        }
        
        // shoulders inner cut
        difference()
        {
            translate([wt,g_y,-eps]) hull()
            {
                translate([(g_x-h_xb)/2,0,0]) cube([h_xb-2*wt,eps,g_z-wt]);
                translate([(g_x-n_x)/2,s_y-wt,0]) cube([n_x-2*wt,eps,n_z-wt]);
            }
            
            // support beams
            for(i=[1:3])
            {
                _xo = (g_x/4)*i-sb_w/2;
                if(i!=2)
                {
                    translate([_xo,g_y,g_z-wt-sb_t])
                        cube([sb_w,g_y,g_z]);
                }
            }
            // ... beam me up, Sarrah
        }
        
        
        // just... keep going
        // go not cry
                
        // shoulder <-> neck cut
        sn_x = n_x-4*wt-2*nhl_d;
        //echo(sn_x);
        translate([g_x/2-sn_x/2,g_y+s_y-wt-eps,-eps])
            cube([sn_x,2*wt+2*eps,s_z-wt+2*eps]);
        
        // soulder border cut
        translate([wt-bt,g_y-bt-eps-g_d/2,-eps])
            cube([g_x-2*bt,g_d/2+bt+s_y-bt,bt]);
        translate([0,g_y-eps,-eps])
            cube([g_x,bt+s_y-bt+2*eps,bt]);
        /*
        translate([wt-bt,g_y-bt,-eps]) hull()
        {
            #translate([0,0-eps-g_d/2,0])cube([g_x-2*bt,eps,bt]);
            translate([0,0-eps,0]) cube([g_x-2*bt,eps,bt]);
            translate([(g_x-n_x)/2,s_y-bt,0]) cube([n_x-2*bt,bt+eps,bt]);
        }
        */
          
        
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
        
        // adding msg to the main support beam...
        _tt = 0.1;
        translate([g_x/2,g_y/2,g_z-wt+_tt-eps-sb_t])
            rotate([0,180,0])
                linear_extrude(_tt)
                    text(   text="I am so sorry Sarrah...", size=5.5,
                            font="Malgun Gothic:style=Bold",
                            halign="center", valign="center");

        // ... but will she?
        // ... but is it enough?
        // ... but did these weeks make me a better human being?

    }   
    
    
    // adding bold distancers
    difference()
    {
        union()
        {
            for(i=[0:len(hps)-1])
            {
                translate(hps[i])
                translate([0,0,bt])
                difference()
                {
                    _h = g_z-bt-wt;
                    _D = 2+m3_bd;
                    // outer shell
                    cylinder(d=_D,h=_h);
                    // bolt hole
                    translate([0,0,-eps])
                        cylinder(d=m3_bd,h=_h+2*eps);
                }
            }
        }
        
        // pipet tip holder cut
        translate([-eps,-eps,-eps])
            cube([g_x+2*eps,pth_y+eps,pth_z+eps]);
        
    }
    
}

//closure();

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



closure_part("bust");