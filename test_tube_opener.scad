use<round_text.scad>;

$fn = 90;
eps = 0.01;
tol = 0.25;

// test tube parameters
// handle part height
h = 10;
// diamter of the test tube
d = 18.5;
// wall thickness for the middle part (test tube holder)
w_T = 5;
// middle part (test tube holder) diameter
D = 2*w_T+d;
// distance from the test tube hole to the bottom of the model
H = 13+5;
// depth of the testube hole
h_i = 5;
// cone base diameter
d_i = 2;

// lever parameters
//l_h = 18;
l_d = 17;
l_l = 50;
l_t = 3;

// pusher parameters
p_d = 8;
p_D = 10;
p_t = 2;
p_l = 24+H-h_i;

// finger protective shield parameters
// protective shield wall thickness
w_t = 1;
// height of the protective wall
ps_h = 5;


module test_tube_opener()
{
    difference()
    {
        // main body
        union()
        {
            // main inner part
            cylinder(d=D,h=H);
            
            // handling leverage
            minkowski()
            {
                m_d = 5;
                _D = D-m_d;
                _h = h-m_d;
                _l_d = l_d-m_d;
                sphere(d=m_d);
                
                translate([0,0,m_d/2])
                hull()
                {
                    cylinder(d=D,h=_h);
                    translate([-l_l/2,0,0])
                        cylinder(d=_l_d,h=_h);
                    translate([l_l/2,0,0])
                        cylinder(d=_l_d,h=_h);
                }
            }
        }
        // test tube hole
        translate([0, 0, H-h_i-eps])
            cylinder(h=h_i+2*eps,d=d);
        
        // main hole for the pusher (middle part)
        translate([0,0,-eps])
            cylinder(d=p_d+2*tol,h=p_l);
        translate([0,0,-eps])
            cylinder(d=p_D+2*tol,h=p_t+2*eps);
        translate([0,0,p_t-eps])
            cylinder(d2=p_d+2*tol, d1=p_D+2*tol, h=p_D-p_d);
        
        // left hole in lever for better grip
        translate([-l_l/2,0,-eps])
        {
            cylinder(d=l_d-4*l_t,h=h+2*eps);
            cylinder(d1=l_d-2*l_t, d2=l_d-4*l_t,h=l_t);
            translate([0,0,h-l_t+2*eps])
                cylinder(d1=l_d-4*l_t, d2=l_d-2*l_t, h=l_t);
        }
        
        // right hole in lever for better grip
        translate([l_l/2,0,-eps])
        {
            cylinder(d=l_d-4*l_t,h=h+2*eps);
            cylinder(d1=l_d-2*l_t, d2=l_d-4*l_t,h=l_t);
            translate([0,0,h-l_t+2*eps])
                cylinder(d1=l_d-4*l_t, d2=l_d-2*l_t, h=l_t);
        }
        
        // texts
        translate([0,0,-eps]) arch_text(" JIRI KUBIK ",
            size=2.5, r=9, t=1, inv=true,
            font="Arial:style=Bold");
        translate([0,0,-eps]) inv_arch_text(" FEE CTU ",
            size=3, r=8, t=1, inv=true,
            font="Arial:style=Bold");
        
    }
    
    // inner teeth for better friction
    translate([0,0,H-h_i])
    for(i=[1:60])
    {
        rotate([0,0,i*6]) translate([d/2,0,0])
            cylinder(d2=d_i/2,d1=d_i,h=h_i);
    }    
    
    // inner pusher
    cylinder(d=p_d,h=p_l);
    cylinder(d=p_D,h=p_t+2*eps);
    translate([0,0,p_t])
        cylinder(d2=p_d, d1=p_D, h=p_D-p_d);
    
    translate([0,0,p_l-p_t])
        cylinder(d=p_D,h=p_t+2*eps);
    translate([0,0,p_l-p_t-(p_D-p_d)])
        cylinder(d1=p_d, d2=p_D, h=p_D-p_d);
    
    
    // finger protective shielding
    translate([0,0,H]) difference()
    {
        cylinder(d=D,h=ps_h);
        translate([0,0,-eps]) cylinder(d=D-2*w_t,h=ps_h+2*eps);
        translate([0,D/2+tol,D/2-2]) rotate([90,0,0])
            cylinder(d=D,h=D+2*tol);
    }    
}

test_tube_opener();