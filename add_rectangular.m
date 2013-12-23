% Author: Jinxin Yang
% Function: add a new rectangular within the big circle
% Parameters: (x_tl, y_tl, x_br, y_br) that is top_left and bottom_right;
%              target image I and grayscale color (1,0), 1 means white

function I = add_rectangular(I, x_tl, y_tl, x_br, y_br, color)

line_width = 2;
global GRAYSCALE;

% white, then use submatrix and assignment, 255
if color ~= GRAYSCALE
    I(x_tl:x_br, y_tl:y_br) = color;
    
    % other-color, then draw a rectangular through four lines
else
    I(x_tl:x_br, y_tl:y_tl+line_width) = 1.0; % left
    I(x_tl:x_br, y_br-line_width:y_br) = 1.0; % right
    I(x_tl:x_tl+line_width, y_tl:y_br) = 1.0;
    I(x_br-line_width:x_br, y_tl:y_br) = 1.0;
end

end