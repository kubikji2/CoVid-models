use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// number of channels
n_ch = 8;

// std grid parameters
g_l = 9;

// pipette parameters
// diameter of the filter tips
p_d = 6;
// diameter of the plate corners
p_D = 8;
// x border offset
p_bo = 3;

//dimension
p_x = n_ch*g_l+p_bo;
p_y = g_l +p_bo;
//p_b = 0.5;
//p_bd = [1.5,1,0,0,0,0,1,1.5];
p_b = 0.75;
p_bd = [0.25,0,0,0,0,0,0,0.25];
p_h = 3;
p_z = p_b+p_h;
// conicity of the inner cut
p_c = 0.5;

// upper connector parameters
// connector offset
//c_xo = 2;
//c_x = 6;
//c_yo = 0;
//c_y = 6;
//c_h = 3;
//c_z = 6;


// rubber hook parameters
rh_wt = 1.5;
rh_a = 2;
rh_xo = 4;
rh_h = 4;


module pipette_head_plate()
{
    difference()
    {
        // main geometry
        union()
        {
            // main shape
            round_cube(x=p_x,y=p_y,z=p_b,d=p_y);
             
            
            // borders
            translate([0,0,p_b])
                round_cube(x=p_x,y=p_y,z=p_h,d=p_y);
            // hook bases
            hull()
            {
                // lower block
                translate([0,0,p_b+p_h])
                    round_cube(x=p_x,y=p_y,z=p_b,d=p_y);
                // upper part
                translate([-rh_xo,0,p_b+p_h+p_b])
                    round_cube(x=p_x+2*rh_xo,y=p_y,z=rh_h,d=p_y);
            }
            
        }
        
        // main conical workspace hole
        hull()
        {
            _d = p_D;
            _h = p_b+p_h+rh_h+eps;
            translate([p_y/2,p_y/2,p_b])
                cylinder(h=_h,d1=_d,d2=p_y+p_c);
            translate([p_x-p_y/2,p_y/2,p_b])
                cylinder(h=_h,d1=_d,d2=p_y+p_c);
        }
        
        // cutting out borders
        translate([p_bo/2+g_l-p_D,-eps,p_b])
            cube([p_x-p_bo-2*(g_l-p_D),p_y+2*eps,p_h+p_h+rh_h+eps]);
        
        // rubber holes
        // left part
        translate([x_off-1.5*rh_a,-eps,2*p_b+p_h+rh_h-rh_a-eps])
            cube([rh_a/2,p_y+2*eps,rh_a+2*eps]);
        translate([x_off-1.75*rh_a,-eps,2*p_b+p_h+rh_h-1.5*rh_a-eps])
            cube([rh_a,p_y+2*eps,rh_a+2*eps]);
        // right part
        translate([p_x+x_off-0.5*rh_a,-eps,p_b+p_h+p_b+rh_h-rh_a-eps])
            cube([rh_a/2,p_y+2*eps,rh_a+2*eps]);
        translate([p_x+x_off-0.75*rh_a,-eps,p_b+p_h+p_b+rh_h-1.5*rh_a-eps])
            cube([rh_a,p_y+2*eps,rh_a+2*eps]);

        // holes for pipette tips
        x_off = (p_x-n_ch*g_l)/2;
        ho_y = g_l/2+p_bo/2;
        for(i=[0:n_ch-1])
        {
            ho_x = x_off+g_l/2+i*g_l;
            translate([ho_x,ho_y,-eps])
                cylinder(h=p_b+2*eps+max(p_bd), d=p_d);
        }
    }
    
    // different height for each filter tip
    x_off = (p_x-n_ch*g_l)/2;
    ho_y = g_l/2+p_bo/2;
    for(i=[0:n_ch-1])
    {
        ho_x = x_off+g_l/2+i*g_l;
        difference()
        {
            translate([ho_x,ho_y,p_b])
                cylinder(d=p_D-eps, h=p_bd[i]);
            translate([ho_x,ho_y,-eps])
                cylinder(h=p_b+2*eps+max(p_bd), d=p_d);
        }
    }
}

pipette_head_plate();
