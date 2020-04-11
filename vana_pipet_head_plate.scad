use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// number of channels
n_ch = 8;

// std grid parameters
g_l = 9;

// pipet parameters
// diameter of the filter tips
p_d = 6;
// diameter of the plate corners
p_D = 9;
// x border offset
p_bo = 3;

//dimension
p_x = n_ch*g_l+p_bo;
p_y = g_l +p_bo;
p_b = 1;
p_h = 3;
p_z = p_b+p_h;
// conicity of the inner cut
p_c = 0.5;

// upper connector parameters
// connector offset
c_xo = 6;
c_x = 6;
c_yo = 5;
c_y = 6;
c_h = 3;
c_z = 6;


// rubber hook parameters
rh_wt = 1.5;
rh_a = 2;

module pipet_head_plate()
{
    difference()
    {
        // main geometry
        union()
        {
            // main shape
            round_cube(x=p_x,y=p_y,z=p_z,d=p_y);
            
            // upper connectors
            translate([-c_xo,0,p_z])
                cube([p_x+2*c_xo,p_y,c_h]);
            
        }
        
        // main conical workspace hole
        hull()
        {
            _d = p_y-p_bo;
            translate([p_y/2,p_y/2,p_b])
                cylinder(h=p_h+c_h+eps,d1=_d,d2=p_y+p_c);
            translate([p_x-p_y/2,p_y/2,p_b])
                cylinder(h=p_h+c_h+eps,d1=_d,d2=p_y+p_c);
        }
        
        // removing upper connector in the middle
        translate([p_D/2,-eps,p_z])
            cube([p_x-p_D,p_y+2*eps,p_h]);
        
        // holes for pipet tips
        x_off = (p_x-n_ch*g_l)/2;
        ho_y = g_l/2+p_bo/2;
        for(i=[0:n_ch-1])
        {
            ho_x = x_off+g_l/2+i*g_l;
            translate([ho_x,ho_y,-eps])
            cylinder(h=p_b+2*eps, d=p_d);
        }
    }
    
    // adding hooks
    translate([c_x-c_xo,p_y/2,0])
        rubber_hook();
    translate([p_x+c_xo,p_y/2,0])
        rubber_hook();
}

pipet_head_plate();

module rubber_hook()
{
    _x = c_x;
    _y = p_y+2*c_y+2*c_yo;
    _z = c_z;
    
    translate([-_x,-_y/2,0]) difference()
    {
        // main shape
        union()
        {
            // main block
            cube([_x, _y, _z]);
            
            hull()
            {
                // connecting to upper part
                translate([0,(_y-p_y)/2,_z]) cube([_x,p_y,1]);
                translate([0,2*rh_a,0]) cube([_x,_y-4*rh_a,_z]);
            }
            
        }
        // lower hook
        translate([-eps,rh_a,_z-2*rh_a+eps])
            cube([_x+2*eps,rh_a,2*rh_a+eps]);
        // further hook
        translate([-eps,_y-2*rh_a,_z-2*rh_a+eps])
            cube([_x+2*eps,+rh_a,2*rh_a+eps]);
        
        // lower cut
        translate([-eps,(_y-p_y-2*c_yo)/2,-eps])
            cube([_x+2*eps, p_y+2*c_yo, p_z-0.5]);
        
    }
}

//rubber_hook();



