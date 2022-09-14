function finalCellStates = computeNextGeneration(initialCellStates)
% COMPUTENEXTGENERATION: Returns the next generation of the Game of 
% Life, based on the initial states of cells given.
% - initialCellStates: The states of cells in the current generation.
% - finalCellStates:   Returns the states of cells in the next generation.

% Store the game board's length and width.
[length,width] = size(initialCellStates);

% Initialise a length × width, zero-array, to store the game's cell 
% states in the next generation.

% A matrix of the correct size is created in advance, to prevent
% size-changing operations from lagging the program.
finalCellStates = zeros(length,width);

% For every x-coordinate, x, in the input array...
for x = 1:length
    % For every y-coordinate, y, in the input array...
    for y = 1:width     
        % Determine the state of the cell at (x,y) in the next generation,
        % and store this in the (x,y) position of the final 2D array.
        finalCellStates(x,y) = computeNextCellState(initialCellStates, ...
                                                    length,width,x,y);
    end
end
end