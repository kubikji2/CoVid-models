use<round_corners.scad>;

// general parameters
$fn = 90;
eps = 0.01;
tol = 0.5;
t_tol = 0.1;

// wall thickness
wt = 2;
wh = 10;

// holder parameters
h_x = 84;
h_y = 90;
h_z = wt;

// well paramters
w_y = 83;
echo(w_xo);
w_xo = 4.5;
w_yo = (h_y-w_y)/2;


// locker parameters
l_x = 2;
// additional locker extention for higher labware
l_extention = -5;
// lower y dimension
l_yl = 60;
l_yu = 43;
l_zu = 17+l_extention;
l_zl = 42-l_zu-h_z+l_extention;

// bolt hole
bh_d = 4.3;
bh_h = 23+l_extention;
bh_off = 13;

// support beams
sb_x = 2;
sb_y = 4;
sb_yo = 3;

module mag_holder_compact()
{
    difference()
    {
        // main shape
        cube([h_x,h_y,h_z]);
        
        // well cut
        translate([w_xo,w_yo,-eps])
            cube([h_x-w_xo+eps,w_y,h_z+2*eps]);
        
        // locker connection hole
        translate([-eps,0,-eps])
            locker();       
        
    }
   
    
    difference()
    {
        // borders
        union()
        {
            // adding borders
            // left border
            translate([w_xo-wt,w_yo-wt,h_z])
                cube([wt,h_y-2*w_yo+2*wt,wh]);
            // left border
            translate([w_xo-wt,w_yo-wt,h_z])
                cube([h_x-w_xo+wt, wt,wh]);

            // right border
            translate([w_xo-wt,h_y-w_yo,h_z])
                cube([h_x-w_xo+wt, wt,wh]);
        }
        
        // cutting 
        txt = "CoVeni, CoVidi, CoVici";
        translate([w_xo-wt/2+eps,w_yo+(h_y-w_yo)/2,h_z+wh/2])
            rotate([90,0,90])
                linear_extrude(wt/2)
                    text(   text=txt, size=5,
                            font="Arial:style=Bold",
                            halign="center", valign="center");
        
        
    }
    
   
        
}

//mag_holder_compact();


module locker()
{
    // locker
    translate([0,(h_y-l_yl)/2,h_z])
    difference()
    {
        // locker main geometry
        // lower part
        _l_yu_o = (l_yl-l_yu)/2;
        translate([0,_l_yu_o,-wt])
            cube([l_x,l_yu,l_zl+l_zu+wt]);
        
        // bolt hole
        translate([-eps,(l_yl)/2,bh_off-h_z+bh_d/2])
        hull()
        {
            rotate([0,90,0]) cylinder(d=bh_d,h=l_x+2*eps);
            translate([0,0,bh_h-bh_d]) rotate([0,90,0])
                cylinder(d=bh_d,h=l_x+2*eps);
        }
    }
    
    // support beams
    translate([-sb_x,(h_y-l_yu)/2+sb_yo,0])
        cube([sb_x,sb_y,h_z+l_zu+l_zl]);
    translate([-sb_x,h_y -(h_y-l_yu)/2-sb_yo-sb_y,0])
        cube([sb_x,sb_y,h_z+l_zu+l_zl]);

}

locker();


/*
// box parameters
// main geometry parameters
b_x = 84;
b_y = 90;
b_z = 8;
// box bottom thickness
b_bt = 2;
// box wall thickness
b_wt = 2;

// bottom cut parameters
bc_x = b_x;
bc_xo = 10;
bc_y = 75;
bc_yo = 7.5;
bc_t = b_bt;
bc_d = 8;

// hooks parameters
h_l = 7;
h_d = 4;

// locker parameters
l_x = b_wt;
// additional locker extention for higher labware
l_extention = 25;
// lower y dimension
l_yl = 60;
l_yu = 43;
l_zu = 17+l_extention;
l_zl = 42-l_zu-b_z+l_extention;

// bolt hole
bh_d = 4.3;
bh_h = 23+l_extention;
bh_off = 13;

// support beams
sb_x = 2;
sb_y = 4;
sb_yo = 3;

module mag_holder()
{

    difference()
    {
        // main shape
        cube([b_x,b_y,b_z]);
        
        // upper cut
        translate([b_wt,b_wt,b_bt])
            cube([b_x,b_y-2*b_wt,b_z]);
        
        // lower cut
        translate([bc_xo,bc_yo,-eps])
            round_cube(x=bc_x,y=bc_y,z=b_bt+2*eps,d=bc_d);
    }
    
    // locker
    translate([0,(b_y-l_yl)/2,b_z])
    difference()
    {
        // locker main geometry
        union()
        {
            // lower part
            _l_yu_o = (l_yl-l_yu)/2;
            hull()
            {
                a = 1;
                translate([0,0,-a])
                    cube([l_x,l_yl,a]);
                translate([0,_l_yu_o,l_zl])
                    cube([l_x,l_yu,a]);
            }
            // upper part
            translate([0,_l_yu_o,l_zl])
                cube([l_x,l_yu,l_zu]);
            
        }
        
        // bolt hole
        translate([-eps,(l_yl)/2,bh_off-b_z+bh_d/2])
        hull()
        {
            rotate([0,90,0]) cylinder(d=bh_d,h=l_x+2*eps);
            translate([0,0,bh_h-bh_d]) rotate([0,90,0])
                cylinder(d=bh_d,h=l_x+2*eps);
        }
    }
    
    // hooks
    translate([b_x-h_d/2,bc_yo-h_d,0])
        round_cube(x=h_l+h_d,y=h_d,z=b_bt,d=h_d);
    translate([b_x-h_d/2,b_y-h_d-(bc_yo-h_d),0])
        round_cube(x=h_l+h_d,y=h_d,z=b_bt,d=h_d);
    
    // support beams
    translate([-sb_x,(b_y-l_yu)/2+sb_yo,0])
        cube([sb_x,sb_y,b_z+l_zu+l_zl]);
    translate([-sb_x,b_y -(b_y-l_yu)/2-sb_yo-sb_y,0])
        cube([sb_x,sb_y,b_z+l_zu+l_zl]);

}

//mag_holder();
*/