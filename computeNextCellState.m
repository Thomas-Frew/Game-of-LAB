function state = computeNextCellState(cellStates, length, width, ...
                                      cellX, cellY)
% COMPUTENEXTCELLSTATE: Returns whether a cell will be alive (1) or 
% dead (0) in the next generation of Game of Life, assuming standard rules.
% - cellStates: The state of all cells on the game board.
% - length:     The game board's length (in cells).
% - width:      The game board's width (in cells)
% - cellX:      The analysed cell's x value.
% - cellY:      The analysed cell's y value.
% - state:      Returns either alive (1) or dead (0).

% Count the number of alive cells neighbouring the analysed cell.
aliveNeighbours = countAliveNeighbours(cellStates,length,width, ...
                                       cellX,cellY);

% If the analysed cell is currently alive (logical 1)...
if (cellStates(cellX,cellY) == 1)

    % If the cell does not have ≤ 1 or ≥ 4 alive neighbours, it will live.
    if ~(aliveNeighbours <= 1 || aliveNeighbours >= 4)
        state = 1;
    % Otherwise, it will die from loneliness or overcrowding.
    else
        state = 0;
    end   
    
% If the cell is not alive, it is dead (logical 0). Hence...
else
    
    % If the cell has exactly three alive neighbours, it is revived.
    if (aliveNeighbours == 3)
        state = 1;
    % Otherwise, the cell remains dead.
    else
        state = 0;
    end
end
end