// general parameters
$fn = 90;
eps = 0.01;
t_tol = 0.2;

g_l = 9;

// metal tip bigger diamer length
mt_l = 13.3;
extention = mt_l+0.7;

// hole parameters
d = 5.2+t_tol;
D = 7.5+t_tol;
H = 27-13.3;
h = 1.5;

echo(h+H-extention);

// body parameters
wt = 1;
y_o = 1;

// connectors parameters
// connector bolt diameter
c_bd = 3.5;
// connector nut diameter
c_nd = 6.5;
// connector wall thickness
c_wt = 2;
// distance from one hole to another
c_l = 77.5+2*c_bd+2*c_wt;
// offset in x axis
c_xo = -(c_l-8*g_l)/2;
// connector dimension size in x axis
c_x = 2*c_wt+c_bd;
// connectors y offset
// -2 is offset used for distancers
c_yo = 1.5-2;
// connector dimension in y axis
c_y = 2*c_wt;
// connector dimension in z axis
c_z = mt_l+3.2+c_bd+c_wt;


// box parameters
x = 8*g_l;
y = g_l;
z = h+H;

module left_distancer()
{
    // connector connector            
    _h = H+h-2*extention/3;
    _ho = H+h-_h;
    _w = 2;
    
    translate([-c_x-1,0,0])
    difference()
    {
        translate([0,0,_ho])
            cube([c_x,_w,c_z-_ho]);
        
        // bolt hole
        translate([c_x/2,_w+eps,c_z-c_bd/2-c_wt])
        {
            rotate([90,0,0])
            {
                // bolt hole
                cylinder(d=c_bd,h=g_l/2+c_yo+2*eps);
            }
            
            // support plane cuts
            translate([0,-1,0])
            {
                translate([-c_x/2-eps,0,-c_bd/2]) cube([c_wt,1,c_bd]);
                translate([-c_x/2-eps,0,-c_nd/2-5*c_wt]) cube([c_x+2*eps,1,5*c_wt]);
            }
        }
        
        // left sloped cut
        translate([c_xo+c_x,c_yo,2*extention/3]) hull()
        {
            translate([0,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([-c_xo,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([0,g_l/2+eps,extention/3]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
        }
    }
}

module right_distancer()
{
    // connector connector            
    _h = H+h-2*extention/3;
    _ho = H+h-_h;
    _w = 2;
    
    translate([1,0,0])
    difference()
    {
        translate([0,0,_ho])
            cube([c_x,_w,c_z-_ho]);
        
        // screw hole for M3 bolt and nut
        translate([c_x/2,_w+eps,c_z-c_bd/2-c_wt])
        {
            rotate([90,0,0])
            {
                // bolt hole
                cylinder(d=c_bd,h=g_l/2+c_yo+2*eps);
            }
            
            // support plane cuts
            translate([0,-1,0])
            {
                translate([c_x/2-c_wt+eps,0,-c_bd/2]) cube([c_wt+2*eps,1,c_bd]);
                translate([-c_x/2-eps,0,-c_nd/2-5*c_wt]) cube([c_x+2*eps,1,5*c_wt]);
            }
        }

        
        
        // right sloped cut
        translate([0,c_yo,2*extention/3]) hull()
        {
            translate([-c_xo,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([0,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([-c_xo,g_l/2+eps,extention/3]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
        }
    }
}
    


// This module is terrible, but it's almost 3.00 in the morning and I am tired and desparate to become better human being.
module distancers()
{
    
    // connector connector            
    _h = H+h-2*extention/3;
    _ho = H+h-_h;
    _w = 2;
    
    _alpha = 5;
    a = 20;
    b = 10;
    c = 30;
    
    
    if(_alpha > 0)
    {
        difference()
        {
            translate([0,0,-c_z])
            union()
            {
                left_distancer();
                right_distancer();
            }
            translate([-a/2,0,0]) #rotate([180+_alpha,0,0]) cube([a,b,c]);
        }
    } else {
        difference()
        {
            rotate([-_alpha,0,0]) translate([0,0,-_ho])
            union()
            {
                left_distancer();
                right_distancer();
            }
            #translate([-a/2,-b,0]) cube([a,b,c]);
        }
    }
    
    
}

//distancers();

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
            
            // extention 
            %translate([c_xo-g_l/2,-c_y,0])
                cube([c_l,c_y,extention]);
            
            // connector connector            
            _h = H+h-2*extention/3;
            _ho = H+h-_h;
            translate([c_xo-g_l/2,-g_l/2,_ho])
                cube([c_l,g_l/2+c_yo,_h]);
            // left connector
            translate([c_xo-g_l/2,-g_l/2,_ho])
                cube([c_x,g_l/2+c_yo,c_z-_ho]);
            // right connector
            translate([c_l+c_xo-c_x-g_l/2,-g_l/2,_ho])
                cube([c_x,g_l/2+c_yo,c_z-_ho]);
                
        }
        
        // holes for pipet heads
        for(i=[0:7])
        {
            
            //if(i==0 || i==7)
            _xo = i*g_l;
            //_D = (i==0 || i==7) ? D + 0.2 : D;
            _D = D +0.2;
            translate([_xo,0,0])
            {
                translate([0,0,h-eps]) cylinder(h=H+2*eps,d=_D);
                translate([0,0,-eps])cylinder(h=h+2*eps,d=d);
            }
        }
        
        // left connector bolt hole
        translate([c_xo-g_l/2,-c_y+c_yo,0])
        {
            // bolt hole
            translate([c_x/2,c_y+eps,c_z-c_bd/2-c_wt])
            {
                rotate([90,0,0])
                {
                    // bolt hole
                    cylinder(d=c_bd,h=g_l/2+c_yo+2*eps);
                    // nut hole
                    /*
                    translate([0,0,g_l/2+c_yo-1+eps])
                        cylinder(d=c_nd,h=g_l/4+2*eps,$fn=6);
                    */
                }
                              
                
            }
            
        }
        
        // right connector bolt hole
        translate([c_l+c_xo-c_x-g_l/2,-c_y+c_yo,0])
        {
            // screw hole for M3 bolt and nut
            translate([c_x/2,c_y+eps,c_z-c_bd/2-c_wt])
            {
                rotate([90,0,0])
                {
                    // bolt hole
                    cylinder(d=c_bd,h=g_l/2+c_yo+2*eps);
                    // nut hole
                    translate([0,0,g_l/2+c_yo-1+eps])
                        cylinder(d=c_nd,h=g_l/4+2*eps,$fn=6);
                }
                
            }
        }
        
        // left sloped cut
        translate([c_xo-g_l/2,c_yo-g_l/2,2*extention/3]) hull()
        {
            translate([0,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([-c_xo,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([0,g_l/2+eps,extention/3]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
        }
        
        // right sloped cut
        translate([x-g_l/2,c_yo-g_l/2,2*extention/3]) hull()
        {
            translate([-c_xo,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([0,g_l/2+eps,0]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
            translate([-c_xo,g_l/2+eps,extention/3]) rotate([90,0,0])
                cylinder(d=eps,h=g_l/2+c_yo+2*eps);
        }
            
    }
    
    
}

pipet_tip_holder();