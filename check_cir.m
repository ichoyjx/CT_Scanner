% Author: Jinxin Yang
% Function: check whether the input of cirlular is valid
% Parameters: x_t,y_t (center point); r_t (radius)

function is_Valid = check_cir (x_t, y_t, r_t)
global DIAMETER;
global FIT;

x_t = int32(x_t);
y_t = int32(y_t);
r_t = int32(r_t);

x0 = int32(DIAMETER/2);
y0 = x0;
r0 = x0 - FIT;

dist_int = (x_t-x0)*(x_t-x0) + (y_t-y0)*(y_t-y0);

dist_0_t = sqrt( str2double( int2str(dist_int) ) );

if ( dist_0_t + r_t ) <= r0
    is_Valid = true;
else is_Valid = false;
end

% if r_t > 185
%     is_Valid = false;
% end

end