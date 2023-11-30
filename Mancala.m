
% ███╗░░░███╗░█████╗░███╗░░██╗░█████╗░░█████╗░██╗░░░░░░█████╗░
% ████╗░████║██╔══██╗████╗░██║██╔══██╗██╔══██╗██║░░░░░██╔══██╗
% ██╔████╔██║███████║██╔██╗██║██║░░╚═╝███████║██║░░░░░███████║
% ██║╚██╔╝██║██╔══██║██║╚████║██║░░██╗██╔══██║██║░░░░░██╔══██║
% ██║░╚═╝░██║██║░░██║██║░╚███║╚█████╔╝██║░░██║███████╗██║░░██║
% ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
%
% █▄▄ █▄█   ▄▀█ █▀█ ░░█ █░█ █▄░█   █░█ █▄█ ▄▀█ █▀ ░ ▄█ ▀█ █▀
% █▄█ ░█░   █▀█ █▀▄ █▄█ █▄█ █░▀█   ▀▄▀ ░█░ █▀█ ▄█ ▄ ░█ █▄ ▄█
% 
% vyas.125@osu.edu
%
% ----------------------------------------------------
% INITIALIZING
h = 233; % Sprite height (pixels)
w = 241; % Sprite width (pixels)
s = 5; % Scale
scn = simpleGameEngine('v5MancalaSpritesheet.png', h, w, s); 
% Defines the sprite sheet, size of each sprite, and the scale

turn = 1; % Counts the turns. If its odd, it's player 1s turn
game = true; % Loop that only stops if the player chooses to quit
win = false; % If win conditions are true, this becomes true
next.r = 0; % The row value of the matrix spot that needs to be edited
next.c = 0; % The column value of the matrix spot that needs to be edited
selVal = 0; % Value of selected box
playing = true; % True when stones are being distributed
nextVal = 0; % The value of the matrix spot that needs to/is being edited
winCheck = false; % True when all slots on a players side are true
turnGoing = true; % True when a player is playing their turn
invMove = false; % True when player clicks an invalid spot

layout =    [35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
            35, 1, 02, 02, 02, 02, 02, 02, 01, 35;
            35, 10, 02, 02, 02, 02, 02, 02, 10, 35;
            35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
            35, 35, 35, 35, 35, 35, 35, 35, 35, 35];
% This is the initial layout of the board.

drawScene(scn, layout) % Draws layout

% ----------------------------------------------------

% Text for starting screen
intro = text(w*10*(5/2), h*15*(1/5), 'Mancala', 'FontSize',100, 'FontWeight','bold', ...
    HorizontalAlignment='center', VerticalAlignment='middle', Color='r');
btm = text(w*10*(5/2), h*10*(9/5)+233*5, 'Click to Play!', 'FontSize',50, 'FontWeight','bold', ...
   HorizontalAlignment='center', VerticalAlignment='middle', Color='b');
instr = text(w*10*(5/2), h*85*(1/5), 'For instructions, visit: tinyurl.com/mancalaInstructions', 'FontSize',25, 'FontWeight','bold', ...
   HorizontalAlignment='center', VerticalAlignment='middle', Color = [128 128 128]/225);
% https://tinyurl.com/mancalaInstructions

layout = [35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
        35, 1, 06, 06, 06, 06, 06, 06, 01, 35;
        35, 10, 06, 06, 06, 06, 06, 06, 10, 35;
        35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
        35, 35, 35, 35, 35, 35, 35, 35, 35, 35]; % Changes layout
[click.r, click.c] = getMouseInput(scn); % Gets position of where the player has clicked on the sprite sheet
delete(intro); % Deletes text from starting screen
delete(btm);
delete(instr);
% ----------------------------------------------------
while(game) % Runs until the user decides they want to quit
    while (~win) % Runs until the win conditions are true
% ----------------------------------------------------

% Player 1's turn

        if (rem(turn, 2) ~= 0)
    % ----------------------------------------------------
    % CHANGES PLAYER TEXT COLOR
            drawScene(scn, layout)
            p1 = text(w*10*(5/2), h*10*(1/5), 'Player 1', 'FontSize',50, 'FontWeight','bold', ...
            HorizontalAlignment='center', VerticalAlignment='middle', Color = 'r'); % Player 1's name red
            p2 = text(w*10*(5/2), h*10*(9/5), 'Player 2', 'FontSize',50, 'FontWeight','bold', ...
            HorizontalAlignment='center', VerticalAlignment='middle', Color = 'k');
    % ----------------------------------------------------
            while(turnGoing)
                [click.r, click.c] = getMouseInput(scn);
                invMove = false;
                if (isValid(click.r, click.c, layout, turn)) % Makes sure mouse click is within bounds of the gameboard 
                    playing = true;
                    selVal = click2num(click.r,click.c,layout);
                    layout(click.r,click.c) = 36;
                    layout(5, 1) = num2sprite(selVal);
                    drawScene(scn, layout)
                    next.r = click.r; next.c = click.c;
                    while(playing) % Distribute stones
        % ----------------------------------------------------
        % UPDATING NEXT SPACE
                        pause(.5) % pause to show the user that the stones are distributing
                        [next.r, next.c] = nextSpace(next.r,next.c,turn); % Finds the next valid space
                        if (next.r == 3 && next.c == 2)% End position 
                            layout(next.r, next.c) = nextPocket(next.r, next.c, layout);
                        else % normal position
                            nextVal = click2num(next.r,next.c,layout);
                            nextVal = nextVal + 1; % The value you want to change the next spot to
                            layout(next.r, next.c) = num2sprite(nextVal);
                        end
                        drawScene(scn, layout)
        % ----------------------------------------------------
                        selVal = selVal - 1;
                        layout(5, 1) = num2sprite(selVal);
                        drawScene(scn,layout)
                        if (selVal == 0) % No stones left
                            playing = false;
                        end
                    end
                    layout(click.r, click.c) = num2sprite(0); % Updates the spot the player just picked to be 0
                    layout(5, 1) = 35; % Sets the bottom left of the board blank again
                    drawScene(scn, layout)

            % ----------------------------------------------------
            % LAST DROPPED IN EMPTY?
                    if ((next.c ~= 2) && (layout(next.r, next.c) == num2sprite(1))) % The last spot is not the store, and it was empty before
                        pause(.5)
                        layout(3, 2) = nextPocket(3, 2, layout); % Adds one to the value of the store
                        layout(next.r, next.c) = num2sprite(0); % Sets the last spot to 0
                        layout(3, 2) = num2pocket(pocket2num(layout(3, 2)) + click2num(getOpp(next.r),next.c, layout)); % Adds the value of the opposite spot to the store
                        layout(getOpp(next.r), next.c) = 2; % Sets the value of the opposite spot to 0
                        drawScene(scn, layout)
                    end
        % ----------------------------------------------------
                else
                    invMove = true; 
                end
    % PLAY AGAIN CONDITIONS
                % Breaks out of the turnGoing loop if the player cannot replay
                if (next.c ~= 2)
                    turnGoing = false;
                end
                if (invMove) % If the click wasn't in a valid spot, it stays the same players turn
                    turnGoing = true;
                    disp('Inv move')
                end

            end
            turnGoing = true;
            turn = turn + 1;
    % ----------------------------------------------------

% Player 2's turn

            % EVERYTHING IS MIRROR FOR PLAYER 2 (Certian values are changed)

        else
    % ----------------------------------------------------
    % CHANGES PLAYER TEXT COLOR
            drawScene(scn, layout)
            p1 = text(w*10*(5/2), h*10*(1/5), 'Player 1', 'FontSize',50, 'FontWeight','bold', ...
            HorizontalAlignment='center', VerticalAlignment='middle', Color = 'k'); % Player 1's name red
            p2 = text(w*10*(5/2), h*10*(9/5), 'Player 2', 'FontSize',50, 'FontWeight','bold', ...
            HorizontalAlignment='center', VerticalAlignment='middle', Color = 'r');
    % ----------------------------------------------------
            while(turnGoing)
                [click.r, click.c] = getMouseInput(scn);
                invMove = false;
                if (isValid(click.r, click.c, layout, turn)) % Makes sure mouse click is within bounds of the gameboard 
                    playing = true;
                    selVal = click2num(click.r,click.c,layout);
                    layout(click.r,click.c) = 36;
                    layout(5, 1) = num2sprite(selVal);
                    drawScene(scn, layout)
                    next.r = click.r; next.c = click.c;
                    while(playing) % Distribute stones
        % ----------------------------------------------------
        % UPDATING NEXT SPACE
                        pause(.5)
                        [next.r, next.c] = nextSpace(next.r,next.c,turn);
                        if (next.r == 3 && next.c == 9)% End position 
                            layout(next.r, next.c) = nextPocket(next.r, next.c, layout);
                        else % normal position
                            nextVal = click2num(next.r,next.c,layout);
                            nextVal = nextVal + 1; % The value you want to change the next spot to
                            layout(next.r, next.c) = num2sprite(nextVal);
                        end
                        drawScene(scn, layout)
        % ----------------------------------------------------
                        selVal = selVal - 1;
                        layout(5, 1) = num2sprite(selVal);
                        drawScene(scn,layout)
                        if (selVal == 0) % No stones left
                            playing = false;
                        end
                    end
                    layout(click.r, click.c) = num2sprite(0); % Updates the spot the player just picked to be 0
                    layout(5, 1) = 35; % Sets the bottom left of the board blank again
                    drawScene(scn, layout)

            % ----------------------------------------------------
            % LAST DROPPED IN EMPTY?
                    if ((next.c ~= 9) && (layout(next.r, next.c) == num2sprite(1)))
                        pause(.5)
                        layout(3, 9) = nextPocket(3, 9, layout);
                        layout(next.r, next.c) = num2sprite(0);
                        % Add the value of the slot opposite
                        layout(3, 9) = num2pocket(pocket2num(layout(3, 9)) + click2num(getOpp(next.r),next.c, layout));
                        layout(getOpp(next.r), next.c) = 2;
                        drawScene(scn, layout)
                    end
        % ----------------------------------------------------
                else
                    invMove = true;
                end
    % PLAY AGAIN CONDITIONS
                % Breaks out of the turnGoing loop if the player cannot replay
                if (next.c ~= 9)
                    turnGoing = false;
                end
                if (invMove)
                    turnGoing = true;
                end

            end
            turnGoing = true;
            turn = turn + 1;
        end
    % ----------------------------------------------------
    % WIN CONDITIONS
        % PLAYER 1 WIN
        winCheck = rowCheck(2, layout);
        if (winCheck) % If the row on player 1's side is empty
            for f=3:8 % Adds the remaining stones to the other players pocket
                pause(.5)
                layout(3, 9) = num2pocket(pocket2num(layout(3, 9)) + click2num(3,f, layout));
                layout(3, f) = 2;
                drawScene(scn, layout)
            end
            win = true;
        end
    
        % PLAYER 2 WIN
        
        winCheck = rowCheck(3, layout);
        if (winCheck) % If the row on player 1's side is empty
            for g=3:8 % Adds the remaining stones to the other players pocket
                pause(.5)
                layout(3, 2) = num2pocket(pocket2num(layout(3, 2)) + click2num(3,g, layout));
                layout(3, g) = 2;
                drawScene(scn, layout)
            end
            win = true;
        end
         
    % ----------------------------------------------------
        
    end
    
    if (win)
        if (pocket2num(layout(3, 2)) > pocket2num(layout(3, 9))) % Player 1 wins
            delete(p1) % delete player text
            delete(p2)
            layout =[35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35];
            drawScene(scn, layout)
           won = text(w*10*(5/2), h*30*(1/5), 'Player 1 wins!', 'FontSize',100, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='g');
           playAgn = text(w*5*(5/2), h*75*(1/5), 'PLAY AGAIN', 'FontSize',30, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='k');
           playStp = text(w*15*(5/2), h*75*(1/5), 'QUIT', 'FontSize',30, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='k');
        elseif (pocket2num(layout(3, 2)) < pocket2num(layout(3, 9))) % Player 2 wins
            delete(p1) % delete player text
            delete(p2)
            layout =[35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35];
            drawScene(scn, layout)
           won = text(w*10*(5/2), h*30*(1/5), 'Player 2 wins!', 'FontSize',100, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='g');
           playAgn = text(w*5*(5/2), h*75*(1/5), 'PLAY AGAIN', 'FontSize',30, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='k');
           playStp = text(w*15*(5/2), h*75*(1/5), 'QUIT', 'FontSize',30, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='k');
        else % tie
            delete(p1) % delete player text
            delete(p2)
            layout =[35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                    35, 35, 35, 35, 35, 35, 35, 35, 35, 35];
            drawScene(scn, layout)
           won = text(w*10*(5/2), h*30*(1/5), 'Player 1 and Player 2 tied.', 'FontSize',60, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='g');
           playAgn = text(w*5*(5/2), h*75*(1/5), 'PLAY AGAIN', 'FontSize',30, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='k');
           playStp = text(w*15*(5/2), h*75*(1/5), 'QUIT', 'FontSize',30, 'FontWeight','bold', ...
        HorizontalAlignment='center', VerticalAlignment='middle', Color='k');
        end
        [click.r, click.c] = getMouseInput(scn);
        if (click.c <= 5) % Player wants to play again
            delete(won); % delete win screen text
            delete(playAgn);
            delete(playStp);
            layout =    [35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                        35, 1, 06, 06, 06, 06, 06, 06, 01, 35;
                        35, 10, 06, 06, 06, 06, 06, 06, 10, 35;
                        35, 35, 35, 35, 35, 35, 35, 35, 35, 35;
                        35, 35, 35, 35, 35, 35, 35, 35, 35, 35]; % Reset layout
            win = false;
        else
            quit; % Quits Matlab
        end
    end
end