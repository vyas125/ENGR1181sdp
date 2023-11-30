function [num] = click2num(clickr,clickc, board)
% Finds the number value of a spot on the board (as assigned in the sprite sheet)
val = board(clickr, clickc);
if (val == 2 || 3 || 4 || 5 || 6 || 7 || 8 || 9)
    num = val - 2;
else
    num = val - 3;
end