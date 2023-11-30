function [opp] = getOpp(inp)
% Gets the row value of the opposite side of the board as the input
if (inp == 3)
    opp = 2;
else
    opp = 3;
end
end