% Author: Jinxin Yang
% Function: add a circular on the canvas
% Parameters: x0,y0; r(radius); color(double) (GRAYSCALE = 0.3 by default)
function I = add_circular(I, x0, y0, r, color)

x0 = int16(x0);
y0 = int16(y0);
r = int16(r);
%color = int16(color);

global GRAYSCALE;
PRECISION = 100000;

if color == GRAYSCALE
    i=1;
    for a = pi/PRECISION : pi/PRECISION : 2*pi
        x(i) = ceil(cos(a)*r + x0);
        y(i) = ceil(sin(a)*r + y0);
        
        % edge is white
        I(y(i),x(i)) = 1.0;
        i = i + 1;
    end
    %circle_size = i - 1;
else
    % range of repict area
    %     u_x = x0 - r;
    %     l_x = x0 + r;
    %     u_y = y0 - r;
    %     l_y = y0 + r;
    
    % to fix the bug of matlab, I have to use the non-efficient way
    % draw the entire circle one line by one line
    for r_i = 0 : r
        i=1;
        for a = pi/(PRECISION/10) : pi/(PRECISION/10) : 2*pi
            x(i) = ceil(cos(a)*r_i + x0);
            y(i) = ceil(sin(a)*r_i + y0);
            
            % edge is white
            I(y(i),x(i)) = color;
            i = i + 1;
        end
    end
    %     else
    %         for i = u_x : l_x
    %             for j = u_y : l_y
    %                 if is_InCircle(i, j, x0, x0, r)
    %                     I(i,j) = color;
    %                 end
    %             end
    %         end
    %     end
end

end