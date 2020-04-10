use<round_corners.scad>;

$fn = 180;
eps =  0.01;
tol = 0.25;

// frame parameters (outer dimensions)
b_x = 127.9;
b_y = 86;
b_z = 8;

// holder parameters (wing parameters)
h_x = 113.5;
h_y = 71.5;
h_h = 3.3;
h_t = 4.5;

// box parameters (inner dimensions)
d_i = 1;
x_i = 120;
y_i = 84;
// border thickness
b_t = 10;
// border height
b_h = 2.5;

// lock offset
l_off = 12;
w_t = 2;

// wing parameters
w_l = 10;

module frame()
{
    // main inner frame
    difference()
    {
        // basic shape
        round_cube(x=b_x,y=b_y,z=b_z,d=4);
        
        // tips rack holder hole
        translate([(b_x-x_i)/2,(b_y-y_i)/2,b_h-eps])
            cube([x_i,y_i,b_z-b_h+2*eps]);
        
        // lower hole
        translate([b_t,b_t,-eps])
            round_cube(x=b_x-2*b_t,y=b_y-2*b_t,z=b_h+2*eps,d=2);
        
        // names
        names = "Adéla, Jirka, Kuba, Petr, Petr";
        f_size = 5.5;
        t_yo = b_t/2;
        translate([b_t,t_yo,b_h+eps-2])
        linear_extrude(2)
        {
            // rotate on the arch
            rotate([0,0,0]) 
                // rotate bottom to the center
                rotate([0,0,0])
                    text(text=names,size=f_size,
                    valign="center",
                    font="Arial:style=Bold",halign="left");
        }
        
        // quotes
        quote = "S láskou pro Motol";
        //quote = "S láskou pro Motol";
        translate([b_t,y_i+t_yo-b_t+1.5, b_h+eps-2])
        linear_extrude(2)
        {
            // rotate on the arch
            rotate([0,0,0]) 
                // rotate bottom to the center
                rotate([0,0,0])
                    text(text=quote,size=f_size,
                    valign="center",
                    font="Arial:style=Bold",halign="left");
        }
    }
    
    translate([(b_x-x_i)/2,l_off,0]) cylinder(d=d_i,h=b_z);
    translate([b_x-(b_x-x_i)/2,l_off,0]) cylinder(d=d_i,h=b_z);
    translate([(b_x-x_i)/2,b_y-l_off,0]) cylinder(d=d_i,h=b_z);
    translate([b_x-(b_x-x_i)/2,b_y-l_off,0]) cylinder(d=d_i,h=b_z);
    
}

//frame();

module side_frame(txt="")
{
    difference()
    {
        // main shape for lock
        translate([0,-h_y/2,0])
            cube([h_t+w_l,h_y,w_t+h_t]);
        // cut for outer frame
        translate([-eps,-h_y/2-eps,-eps])
            cube([h_t,h_y+2*eps,h_h]);
    }
    // lower wings
    translate([h_t,-b_y/2,0])
        round_cube(x=w_l,y=b_y,z=b_h,d=4);
    // leverage
    translate([h_t+w_l-eps,h_y/2,h_t]) hull()
    {
        d_ = 0.01;
        rotate([90,0,0]) cylinder(d=d_, h=h_y);
        translate([0,0,w_t]) rotate([90,0,0])
            cylinder(d=d_, h=h_y);
        translate([w_t,0,w_t]) rotate([90,0,0])
            cylinder(d=d_, h=h_y);
    }
    
    difference()
    {
        // levarage support 
        translate([0,-h_y/2,h_t+w_t])
            cube([h_t+w_l+w_t,h_y,b_z-h_t-w_t]);
        // text
        translate([(h_t+w_l+w_t)/2,0,h_t+w_t])
        linear_extrude(2)
        {
            // rotate on the arch
            rotate([0,0,90+180]) 
                // rotate bottom to the center
                rotate([0,0,0])
                    text(text=txt,size=8,valign="center",
                    font="Arial:style=Bold",halign="center");
        }
       
    }
    
}

//side_frame();

module advanced_frame()
{
    // basic frame
    frame();
    
    // left frame
    translate([0,b_y/2,0]) rotate([0,0,180])
        side_frame(txt="FEL ČVUT");
    
    // right frame
    translate([b_x,b_y/2,0]) side_frame(txt="PřF UK");
}

advanced_frame();
