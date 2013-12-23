% Author: Jinxin Yang
% Function: generate the basic canvas
function I = canvas

global DIAMETER;
DIAMETER = 420;
global GRAYSCALE;
GRAYSCALE = 0.3;

I = zeros(DIAMETER) + GRAYSCALE;
%imshow(I);

global FIT;
FIT = 1;
x0 = DIAMETER / 2;
y0 = x0;
r = DIAMETER / 2 - FIT;
PRECISION = 100000;

i=1;
for a = pi/PRECISION : pi/PRECISION : 2*pi
    x(i) = ceil(cos(a)*r + x0);
    y(i) = ceil(sin(a)*r + y0);
    I(y(i),x(i)) = 1.0;
    i = i + 1;
end

%imshow(I)
%save I.txt -ascii I;

end