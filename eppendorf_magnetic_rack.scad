eps = 0.01;
$fn = 90;

// interface dimensions
i_x = 127.5;
i_y = 85.5;

// general parameters
g_l = 9;
n_cols = 12;
n_rows = 8;
wt = 3;

// body dimensions
b_z = 24;
// magnets dimensions
m_D = 8;
m_d = m_D-2*1.5;
m_z = 6;
// magnet hole depth
m_hd = 3;

// stops parameters
// stops thickness for borders
s_tb = 3.5;
// stops thickness for roofs
s_tr = 2.5;
s_o = 0.5;
s_h = 9;
s_xy = 11+s_tb+s_o;

module stopper()
{
    // stoppers
    _sc_x = s_xy;
    _sc_y = s_xy;
    _sc_z = s_tr + s_h;
    
    difference()
    {
        translate([-s_tb-s_o,-s_tb-s_o, -s_tr])
            cube([_sc_x, _sc_y, _sc_z]);
        translate([-s_o+eps, -s_o+eps, eps])
            cube([_sc_x-s_tb,_sc_y-s_tb,_sc_z-s_tr]);
    }
}
//stopper();


module eppendorf_magnetic_rack()
{
    // base module
    difference()
    {
        cube([i_x, i_y, b_z]);
        // inner cur
        translate([wt,wt,-eps])
            cube([i_x-2*wt,i_y-2*wt,b_z-wt]);
    }
    
    // magnetic offsets
    m_xo = (i_x - g_l*n_cols)/2;
    m_yo = (i_y - g_l*n_rows)/2;
    
    // magnets
    for(i=[0:n_cols-1])
    {
        for(j=[0:n_rows-1])
        {
            _m_xo = m_xo + i*g_l + g_l/2;
            _m_yo = m_yo + j*g_l + g_l/2;
            
            translate([_m_xo,_m_yo, b_z]) difference()
            {
                // magnet
                cylinder(d=m_D,h=m_z);
                
                // magnet hole
                translate([0,0,m_z-m_hd])
                    cylinder(d=m_d,h=m_hd+eps);
            
            }
        }
    }
    
    // adding stoppers
    translate([0,0,b_z]) stopper();
    translate([i_x,0,b_z]) rotate([0,0,90]) stopper();
    translate([i_x,i_y,b_z]) rotate([0,0,180]) stopper();
    translate([0,i_y,b_z]) rotate([0,0,270]) stopper();
    
    
}

eppendorf_magnetic_rack();