% Author: Jinxin Yang
% Function: check whether a point is in the circle
% Parameters: x_t,y_t (target point); x0, y0, r (target circle)

function is_In = is_InCircle (x_t, y_t, x0, y0, r)

if ( (x_t-x0)*(x_t-x0) + (y_t-y0)*(y_t-y0) ) <= r*r
    is_In = true;
else is_In = false;
end

end