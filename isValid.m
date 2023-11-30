function [status] = isValid(clickr,clickc,board, turn)
%   Checks to see if the chosen space is valid
%   Detailed explanation goes here

if (rem(turn, 2) ~= 0) % Finds out which players turn it is
    player = 1;
else
    player = 2;
end

% Is the selected spot within the bounds of the board?
if (player == 1)
    if ((clickr == 2) && (clickc == 3 || 4 || 5 || 6 || 7 || 8))
        status = true;
    else
        status = false;
    end
    if (click2num(clickr,clickc,board) == 0)
        status = false;
    end
else
    if ((clickr == 3) && (clickc == 3 || 4 || 5 || 6 || 7 || 8))
        status = true;
    else
        status = false;
    end
    if (click2num(clickr,clickc,board) == 0)
        status = false;
    end
end

% Spot is not a store/pocket
if(board(clickr, clickc) == 1 || board(clickr, clickc) == 10 || board(clickr, clickc) > 36)
    status = false;
end

