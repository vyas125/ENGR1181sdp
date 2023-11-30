function [nextSprite] = nextPocket(clickr, clickc, board)
% Finds the sprite value (for a store/pocket) after the provided one given its current value
if(board(clickr,clickc) == 10)
    nextSprite = 37;
else
    nextSprite = board(clickr,clickc) + 1;
end
end