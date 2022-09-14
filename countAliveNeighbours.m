function neighbours = countAliveNeighbours(cellStates, length, width, ...
                                           cellX, cellY)
% COUNTALIVENEIGHBOURS: Finds every alive cell adjacent to a cell in 
% the Game of Life.
% - cellStates: The states of all cells on the game board.
% - length:     The game board's length (in cells).
% - width:      The game board's width (in cells)
% - cellX:      The analysed cell's x value.
% - cellY:      The analysed cell's y value.
% - neighbours: Returns the number of alive neighbours next to a cell.

% Initialise neighbours to store the number of alive cells neighbouring
% the current cell. This begins at 0 and is incremented later.
neighbours = 0; 

% In the nested loop below, relX and relY are store the relative position
% between (cellX,cellY) and the cell in the current iteration.
% - relX: The current cell's x value, relative to (cellX, cellY).
% - relY: The current cell's y value, relative to (cellX, cellY).

% relX and relY range from -1 to 1. Hence, every cell surrounding
% (cellX, cellY) is tested, with a unique combination of relX and relY.

% This is visusalied below:
%              relX = -1             relX = 0            relX = 1
%  relY = -1   (cellX-1, cellY-1)    (cellX, cellY-1)    (cellX+1, cellY-1) 
%  relY = 0    (cellX-1, cellY)      (cellX, cellY)      (cellX+1, cellY) 
%  relY = 1    (cellX-1, cellY+1)    (cellX, cellY+1)    (cellX+1, cellY+1) 

% For each cell tested that is alive (1), increment the analysed cell's
% count of alive neighbours. The cell at relX = 0, relY = 0 is not counted,
% as this is the analysed cell itself.

% For each integer, relX, between -1 and 1...
for relX = -1:1

    % For each integer, relY, between -1 and 1...
    for relY = -1:1

        % The x and y values of the cell being tested equals the analysed
        % cell's coordinates, plus the test cell's relative x and y values.
        testX = cellX + relX;
        testY = cellY + relY;

        % We cannot analyse a cell that is outside the game board, more
        % specifically, if the test cell has an x or y value below one or
        % above the game board's length/width.

        % If this is the case, the cell is considered dead. 
        % This is equivalent to if the game board had a border of permanent 
        % dead cells around it.

        % If the cell being tested is not outside the game board...
        if (testX >= 1 && testX <= length && testY >= 1 && testY <= width)
        
            % If the current cell being tested is alive, and is not
            % the central cell...
            if (cellStates(testX,testY) == 1)
                
                % If the cell being tested is not the analysed cell
                % itself...
                if ~(relX == 0 && relY == 0)
    
                    % Increment the analysed cell's alive neighbour count.
                    neighbours = neighbours + 1;
                end         % Self-similarity test.
            end             % Alive/dead test.
        end                 % Within-bounds test.
    end                     % Iterating through all relative y values.
end                         % Iterating through all relative x values.
end