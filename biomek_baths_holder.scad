use<round_corners.scad>;

eps = 0.01;

// main parameters
// holder outer dimensions
h_x = 127.5;
h_y = 84;
h_z = 37.2;

// wall thickness
wt = 2.5;

// bath hole parameters
bh_x = 110;
bh_y = 73;
// bath hole peaks parameters
bhp_x = 2.5;
bhp_y = 2.2;
bhp_off = 25;

module bath_holder()
{
    difference()
    {
        // basic shape
        //cube([h_x, h_y, h_z]);
        round_cube(x=h_x,y=h_y,z=h_z,d=10);
        
        // main inner hole
        translate([wt,wt,wt])
            //cube([h_x-2*wt, h_y-2*wt, h_z-wt+eps]);
            round_cube(x=h_x-2*wt,y=h_y-2*wt,z=h_z-wt+eps,d=10);
        // main holes for baths
        mhx_o = (h_x-bh_x)/2;
        mhy_o = (h_y-bh_y)/2;
        translate([mhx_o,mhy_o,-eps]) cube([bh_x, bh_y, wt+2*eps]);
        // peak holes
        for(i=[0:3])
        {
            xi_o = mhx_o+bhp_off/2 + i*(bhp_off+bhp_x);
            yi_o = mhy_o-bhp_y;
            zi_o = -eps;
            xi = bhp_x;
            yi = bh_y + 2*bhp_y; 
            zi = wt + 2*eps;
            translate([xi_o, yi_o, zi_o]) cube([xi, yi, zi]);
        }
    }
}

bath_holder();