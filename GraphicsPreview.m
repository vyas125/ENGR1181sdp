% Arjun Vyas.125 - ENGR 1181 SDP Graphics Preview
clear, clc

h = 233; % Sprite height (pixels)
w = 241; % Sprite width (pixels)
s = 5; % Scale
scn = simpleGameEngine('v5MancalaSpritesheet.png', h, w, s); 
% Defines the sprite sheet, size of each sprite, and the scale

layout =    [35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
            35, 1, 02, 02, 02, 02, 02, 02, 01, 35;
            35, 10, 02, 02, 02, 02, 02, 02, 10, 35;
            35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
            35, 35, 35, 35, 35, 35, 35, 35, 35, 35];
% This is the initial layout of the board.

drawScene(scn, layout)
% This makes the board using the defined sprite sheet and the layout
title('Base Board')
text(w*10*(5/2), h*10*(1/5), 'Player 1', 'FontSize',50, 'FontWeight','bold', ...
    HorizontalAlignment='center', VerticalAlignment='middle')
text(w*10*(5/2), h*10*(9/5), 'Player 2', 'FontSize',50, 'FontWeight','bold', ...
   HorizontalAlignment='center', VerticalAlignment='middle')
xlabel('The Mancala board and the two players are shown');

[click.r, click.c] = getMouseInput(scn); % Gets mouse input and stores it in struct variables

if (click.r == 1 || 2 || 3 || 4 && click.c == 1|| 2 || 3 || 4 || 5 || 6 || 7 || 8 || 9 || 10) % Makes sure mouse click is within bounds of the gameboard 
    layout = [35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
            35, 1, 06, 06, 06, 06, 06, 06, 01, 35;
            35, 10, 06, 06, 06, 06, 06, 06, 10, 35;
            35, 35, 35, 35, 35, 35, 35, 35, 35, 35,
            35, 35, 35, 35, 35, 35, 35, 35, 35, 35]; % Changes layout
    drawScene(scn, layout)
    title('Board Between Plays')
    text(w*10*(5/2), h*10*(1/5), 'Player 1', 'FontSize',50, 'FontWeight','bold', ...
    HorizontalAlignment='center', VerticalAlignment='middle', Color = 'r') % Player 1's name bold
    text(w*10*(5/2), h*10*(9/5), 'Player 2', 'FontSize',50, 'FontWeight','bold', ...
    HorizontalAlignment='center', VerticalAlignment='middle')
    xlabel('The board is filled & It''s player 1''s turn')
end

[click.r, click.c] = getMouseInput(scn);

if (click.r == 2 || 3 && click.c == 3 || 4 || 5 || 6 || 7 || 8) 
    layout(end, 1) = layout(click.r, click.c); % Sets value of one section to the value of the selected sprite
    layout(click.r, click.c) = 36; % Changes the selected sprite
end

    drawScene(scn, layout)
    title('Playing a Turn')
    text(w*10*(5/2), h*10*(1/5), 'Player 1', 'FontSize',50, 'FontWeight','bold', ...
    HorizontalAlignment='center', VerticalAlignment='middle', Color = 'r')
    text(w*10*(5/2), h*10*(9/5), 'Player 2', 'FontSize',50, 'FontWeight','bold', ...
    HorizontalAlignment='center', VerticalAlignment='middle')
    xlabel('The selected slot is highlighted, and the value is show in the corner prior to being distributed')


% EVALUATE:
% Figuring out how to create my own sprite sheet was difficult, although I
% think I understand how it works now. I will be discussing the complexity
% of the graphics with my teammates since the graphics of this game can be
% made extrememly complex and it's important to define how the game will
% look before it's developed. I intend to add actual images to the
% spritesheet instead of just Excel cells.