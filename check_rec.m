% Author: Jinxin Yang
% Function: check whether the input of cirlular is valid
% Parameters: x_t,y_t (center point); r_t (radius)

function is_Valid = check_rec (x_tl, y_tl, x_br, y_br)
global DIAMETER;
global FIT;

x_tl = int32(x_tl);
y_tl = int32(y_tl);
x_br = int32(x_br);
y_br = int32(y_br);

x_bl = x_tl;
y_bl = y_br;
x_tr = x_br;
y_tr = y_tl;

x0 = int32(DIAMETER/2);
y0 = x0;
r0 = x0 - FIT;

point_tl = is_InCircle (x_tl, y_tl, x0, y0, r0);
point_tr = is_InCircle (x_tr, y_tr, x0, y0, r0);
point_bl = is_InCircle (x_bl, y_bl, x0, y0, r0);
point_br = is_InCircle (x_br, y_br, x0, y0, r0);

if (point_tl && point_tr && point_bl && point_br)
    is_Valid = true;
else
    is_Valid = false;
end

end