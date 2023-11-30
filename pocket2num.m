function [num] = pocket2num(spriteVal)
% Finds the number value from the sprite sheet for store spots 
if (spriteVal == 10)
    num = 0;
else
    num = spriteVal - 36;
end

end