function [spriteVal] = num2pocket(num)
% Finds the sprite value (for store/pockets) for a given number
if (num == 0)
    spriteVal = 10;
else
    spriteVal = num + 36;
end

end