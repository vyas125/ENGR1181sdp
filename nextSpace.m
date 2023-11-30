function [nextr,nextc] = nextSpace(posr,posc, turn)
%   Finds the next valid space to put stones into (the layout is
%   predefined)

if (rem(turn, 2) ~= 0)
    player = 1;
else
    player = 2;
end

if player == 1
    if (posr == 2)
        if (posc == 3) % at end
            nextr = 3;
            nextc = 2;
        else % not at the end
            nextr = 2;
            nextc = posc - 1;
        end
    else % clicked row is 3
        if (posc == 8) % at end
            nextr = 2;
            nextc = 8;
        else % not at the end
            nextr = 3;
            nextc = posc + 1;
        end
    end
else
    if (posr == 2) % clicked row is 2
        if (posc == 3) % at end
            nextr = 3;
            nextc = 3;
        else % not at the end
            nextr = 2;
            nextc = posc - 1;
        end
    else % clicked row is 3
        if (posc == 9) % at end
            nextr = 2;
            nextc = 8;
        else % not at the end
            nextr = 3;
            nextc = posc + 1;
        end
    end
end