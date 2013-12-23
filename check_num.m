% Author: Jinxin Yang
% Parameters: check the legality of NT and Anginc
%             they should be int and >0

function isLegal = check_num(num)

isLegal = false;

if int32(num)==num && num>0
    isLegal = true;
end

end