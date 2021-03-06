// general parameters
$fn = 90;
eps = 0.01;

// extention
extention = 14+3;

// grid parameter
g_l = 9;

// body parameters
// lower x dimension
x_l = 79;
// upper x dimension
x_u = 75.5;
// lowest y part size
y_l = 17;
// middle transition y part size
y_m = 3;
// upper y part size
y_u = 24;
// top y part size (hulled cylinders)
y_t = 10.75 + extention;
// z dimension
z = 11.6;
// z step between y body and hulled cylinders
z_s = 1;
// top part diameter
z_d = 12.5;
// general thickness
t = 2;
// top wall thickness
wt_t = 1;
// upper diameter
u_d = 6.3;

// carriage parameters
// carriage length in y axis
c_l = 27;
// carriage width in x axis
c_w = 3.5;
// carriages distance in x axis
c_d = 19;
// distance from the lowes part
c_yo = 13;
// side wall thickness for the border
c_t = 1;

// stopper parameters
// stopper width in x axis
s_w = 11;
// stopper lenght in y axis
s_l = 2.2;
// stopper offset in y axis from the lowest part
s_yo = 44-0.2;
// stopper carriage offset
sc_yo = c_yo+1;
// stopper carriage depth
sc_d = 1;

// arch parameters
// arch diameter
a_d = 6;
// arch height (distance from lowest part to the beginning of the arch)
a_h = 7.25-a_d;
// pillar width
a_p = 3;

// blade extentions
//bes = [0,0.2,0.4,0.8,0.8,0.4,0.2,0];
bes = [0.0,0.5,1.0,1.5,1.5,1.0,0.5,0.0];

// TMP solution for top blade thickness, max value is thickness t
/////////////////////////////////////
t_t = 1;
/////////////////////////////////////


// "blade", "body", "back"

module opentrons_pipet_tips_pusher(part="body")
{
    x_off = (x_l-x_u)/2;
    z_off = z-z_d;
    
    difference()
    {
        union()
        {
            // lowest block
            cube([x_l,y_l,z]);
            
            // middle block
            hull()
            {
                _o = 1;
                translate([0,y_l-_o,0]) cube([x_l,_o,z]);
                translate([x_off,y_l+y_m,0]) cube([x_u,_o,z]);
            }
            // upper block
            //translate([x_off,y_l+y_m,0]) cube([x_u,y_u,z]);
            translate([x_off,y_l+y_m,0]) hull()
            {
                _t = 3;
                cube([x_u,y_u-2*_t,z]); 
                translate([_t,y_u-1]) cube([x_u-2*_t,1,z]);
            }
            
            // top part
            translate([ x_off+z_d/2,
                        y_l+y_m+y_u,
                        z_d/2-(z_d-z)-z_s])
            rotate([-90,0,0])
            difference()
            {
                union()
                {
                    //basic top part
                    hull()
                    {
                        cylinder(h=y_t,d=z_d);
                        translate([x_u-z_d,0,0])
                            cylinder(h=y_t,d=z_d);
                    }
                    // extended and reinforced top part
                    translate([0,0,y_t-extention])
                    hull()
                    {
                        cylinder(h=extention,d=z_d+2*wt_t);
                        translate([x_u-z_d,0,0])
                            cylinder(h=extention,d=z_d+2*wt_t);
                    }
                }
                                                
                // hole for pipette tips
                for(i=[0:7])
                {
                    _x = i*g_l;
                    translate([_x,0,-eps])
                        cylinder(d=u_d,h=z_d+extention);
                    
                }
                
            }
            
            // top reinforcement
            translate([ x_off+z_d/2, y_l+y_m+y_u, z-z_s])
                cube([x_u-z_d,y_t,z_s]);
        }
        
        
        //////////////
        // TOP CUTS //
        //////////////
        // cut into the pipet tips part and the most upper part of y
        translate([-eps-wt_t,y_l+y_m+y_u-t,-z_s-wt_t+z_off-eps])
            cube([x_l+2*eps+2*wt_t,y_t-extention+t+extention/3,z_d+wt_t-z_s]);
        
        
        // main cut in top part
        translate([ x_off+z_d/2,
                    y_l+y_m+y_u-t-eps,
                    z_d/2-(z_d-z)-z_s])
        rotate([-90,0,0])
        difference()
        {
            translate([0,0,-eps]) hull()
            {
                cylinder(h=y_t+2*eps,d=z_d-2*c_t);
                translate([x_u-z_d,0,0])
                    cylinder(h=y_t+2*eps,d=z_d-2*c_t);
            }
            
            // adding support beams
            /*
            for(i=[0:6])
            {
                _t = 1.5;
                _xo = i*g_l+g_l/2-_t/2;
                // tip shafts supports
                translate([_xo,-z_d/2,y_t-extention+t]) cube([_t,z_d,extention]);
                // upper support beams
                //translate([_xo,-z_d/2-z_s,t]) cube([_t,z_d,y_t-t]);
            }
            */
        }
        
        // sloped cut
        translate([-wt_t-eps,y_l+y_m+y_u+y_t-2*extention/3,-z_s-(z_d-z)-wt_t])
        hull()
        {
            _s = extention/3;
            translate([0,_s,0]) rotate([0,90,0])
                cylinder(d=eps,h=x_l+2*wt_t+2*eps);
            translate([0,0,z_d/2+wt_t]) rotate([0,90,0])
                cylinder(d=eps,h=x_l+2*wt_t+2*eps);
            translate([0,0,0]) rotate([0,90,0])
                cylinder(d=eps,h=x_l+2*wt_t+2*eps);
        }
        
        ////////////////
        // MIDDLE CUT //
        ////////////////
        
        // cut into the main block
        translate([x_off-eps,t,-eps])
            cube([x_u+2*eps, y_l+y_m+y_u-t+eps-t, z-t+eps]);
        
        
        // side cut in the lower part
        translate([-eps,t,-eps])
        hull()
        {
            rotate([0,90,0]) cylinder(d=eps,h=x_l+2*eps);
            translate([0,z-t,z-t]) rotate([0,90,0]) cylinder(d=eps,h=x_l+2*eps);
            translate([0,z-t,0]) rotate([0,90,0]) cylinder(d=eps,h=x_l+2*eps);
        }
        
        // side cut
        translate([-eps,z,-eps])
            cube([x_l+2*eps,y_l+y_m-t,z-t]);
        
        //////////////
        // ARCH CUT //
        //////////////
        for(i=[0:7])
        {
            _xo = (x_l-8*g_l)/2 + i*g_l+g_l/2;
            translate([_xo,-eps,-eps])
            {
                translate([0,t+2*eps,a_d/2+a_h]) rotate([90,0,0])
                    cylinder(d=a_d,h=t+2*eps);
                translate([-a_d/2,0,0]) cube([a_d,t+2*eps,a_h+a_d/2]);
            }
           
        }
        
        //////////////////
        // CARRIAGE CUT //
        //////////////////
        // translate to the middle in x axis
        translate([x_l/2,c_yo,z-t])
        {
            // left and right carriages
            translate([-c_d/2-c_w,0,-eps]) cube([c_w,c_l,t+2*eps]);
            translate([c_d/2,0,-eps]) cube([c_w,c_l,t+2*eps]);
        }
        
        /////////////////
        // STOPPER CUT //
        /////////////////
        translate([x_l/2-s_w/2,s_yo,z-t-z_s-eps])  
            cube([s_w,s_l,t+z_s+2*eps]);
        translate([x_l/2-s_w/2,sc_yo+eps,0])
            cube([s_w,(s_yo-sc_yo),z-t+sc_d]);
        
        
        // VISUALIZATION
        //%cube([x_l/2,y_l+y_m+y_u+y_t,z]);
        
        // used extention cut
        _h = 0.1;
        translate([x_l/2,t+(sc_yo-t)/2,z-t+_h-eps])
            rotate([0,180,0])
                linear_extrude(_h+eps)
                    text(
                        text=str(extention),
                        font="Arial Unicode MS:style=Regular",
                        size=5, valign="center", halign="center");
        
       
        ///////////////////
        // CHOOSING PART //
        ///////////////////
        
        if(part != "blade")
        {
            translate([-wt_t-eps,y_l+y_m+y_u+y_t-t-eps,-z_s-(z_d-z)-wt_t])
                cube([x_l+2*wt_t+2*eps,t+2*eps,z_d+2*eps+z_s+2*wt_t]);
        }
        
        if(part != "body")
        {
            translate([-wt_t-eps,t,-wt_t-eps-z_d])
                cube([x_l+2*wt_t+2*eps,y_l+y_m+y_u+y_t-t-t_t,z+z_d+2*wt_t+2*eps]);
        }
        
        if(part != "back")
        {
            translate([-eps,-eps,-eps])
                cube([x_l+2*eps,t+2*eps,z+2*eps]);
        }
        
           
    }
    
   
    // additional blade extentioins
    if(part=="blade")
    {
        translate([ x_off+z_d/2,
                        y_l+y_m+y_u+y_t,
                        z_d/2-(z_d-z)-z_s])
        for(i=[0:7])
        {
            difference()
            {
                _h = bes[i];
                _x = i*g_l;
                _yo = wt_t+(z_d-g_l)/2;
                translate([_x-g_l/2,0,-g_l/2-_yo]) cube([g_l,_h,g_l+2*_yo]);
                translate([_x,eps+_h,0]) rotate([90,0,0])
                    cylinder(h=_h+2*eps,d=u_d);
                
                
            }
        }
    }
}

opentrons_pipet_tips_pusher();