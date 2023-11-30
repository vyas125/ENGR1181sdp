function [win] = rowCheck(row, board)
% Checks to see if a row is empty on the mancala board (columns 3 through
% 8) by iterating through them
win = true;
for i=3:8
    if (board(row, i) ~= 2) % If any of the values are not 0, set win to false
        win = false;
    end
end


end