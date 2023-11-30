function [sprite] = num2sprite(num)
% Finds the sprite value (for regular slots) for a given number
if (num < 8)
    sprite = num + 2;
elseif (num > 10)
    sprite = num + 2;
else
    sprite = num + 3;
end