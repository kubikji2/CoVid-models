eps = 0.01;
$fn = 90;
tol = 0.5;
ttol = 0.3;


// basic 96 well parameters
// source: TODO
// filter tips parameters
t_d = 5.46;
t_l = 9.00;
// filter tip separation wall thickness
t_wt = 1.5;
// filter tip wall secure hook thickness
// mk2.1
//t_wst = 1+0.05;
// mk2.2  
t_wst = 1+0.1;
// fillter tip wall secure hook height before skewed part
// mk2.1
//t_wsh = 2;
// mk2.2
t_wsh = 4;

n_cols = 12;
n_rows = 8;

x_o = 124;
y_o = 81.5;
z = 15;

// upper tips support frame
z_t = 2;

// wall thickness
w_t = 3;

module wall()
{
    a = t_wst/2;
    b = t_l;  
    c = z-z_t + t_wsh/2;
    // long vertical wall
    //translate([0,0,t_wsh/2]) cube([a,b,c]);
    // hook inner lwall
    translate([a,a,0]) cube([t_wst,b-2*a,t_wsh]);
    hull()
    {
        translate([0,0,t_wsh-a]) cube([a,b,t_wst+a]);
        translate([0,0,t_wsh-a]) cube([t_wst+a,b,a]);
    }
}



module walls()
{
    for(i=[0:3])
    {
        rotate([180,0,i*90]) translate([-t_l/2,-t_l/2,-z-t_wsh/2]) wall();
    }    
}

//walls();
/*
translate([t_l,0,0])walls();
translate([t_l,t_l,0])walls();
translate([0,t_l,0])walls();
*/
module adapter()
{
    x_off = (x_o-((n_cols-1)*t_l+t_d))/2;
    y_off = (y_o-((n_rows-1)*t_l+t_d))/2;
    
    difference()
    {
        cube([x_o,y_o,z]);               
        //translate([w_t,w_t,z_t+eps])
        //    cube([x_o-2*w_t, y_o-2*w_t, z]);
        
        for(i = [0:n_cols-1])
        {
            for(j = [0:n_rows-1])
            {
                xt = x_off+t_d/2+i*t_l;
                yt = y_off+t_d/2+j*t_l;
                h = z+2*eps;
                d = t_d + 2*eps + tol;
                translate([xt,yt,-eps]) cylinder(h=h, d=d);
            }
        }
        
        /*
        v_label = "ABCDEFGH";
        
        for(i = [0:n_rows-1])
        {
            th = 1;
            x = x_off/2; 
            y = y_off+t_d/2+i*t_l;
            translate([x_o-x,y,+th-eps]) rotate([0,180,0])
                linear_extrude(th)
                {
                    text(v_label[n_rows-1-i],
                        font="Microsoft Sans Serif:style=Regular",
                        size = 5, valign="center", halign="center");
                }
        }
        
        for(i = [0:n_cols-1])
        {
            th = 1;
            x = x_off + t_d/2+i*t_l; 
            y = y_o-y_off/2;
            translate([x_o-x,y,+th-eps]) rotate([0,180,0])
                linear_extrude(th)
                {
                    text(str(i+1),
                        font="Microsoft Sans Serif:style=Regular",
                        size = 3.5, valign="center", halign="center");
                }
        }
        */
    }
    
    for(i = [0:n_cols-1])
        {
            for(j = [0:n_rows-1])
            {
                xt = x_off+t_d/2+i*t_l;
                yt = y_off+t_d/2+j*t_l;
                translate([xt,yt,-eps]) walls();
            }
        }

}

adapter();

