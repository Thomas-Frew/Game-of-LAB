function bufferedArray = appendBuffer(inputArray, bufferValue)
% APPENDBUFFER: Appends a row and column of some buffer value to a the
% input, 2D array.
% - inputArray:    The 2D array to be operated on.
% - bufferValue:   Some value the input array will be buffered with.
% - bufferedArray: Returns the input array, with its buffer row and column
% appended.

% Store the input array's number of rows and columns.
[inputArrayRows, inputArrayCols] = size(inputArray);

% Initialise an array made entirely of the buffer value, one row and column
% larger than the input array. The input values will later be placed into 
% this array, leaving one row and column as buffer space.
bufferedArray = zeros([inputArrayRows, inputArrayCols] + 1) + bufferValue;

% For each integer, iRow, between 1 and the number of rows in the input 
% array (such that every row is considered)...
for iRow = 1:inputArrayRows
    % For each integer, iCol, between 1 and the number of columns in the 
    % input array (such that every column is considered)...
    for iCol = 1:inputArrayCols
        % Place the element at (row,col) from the input array into the
        % buffer array, leaving 1 row and column as buffer space.
        bufferedArray(iRow,iCol) = inputArray(iRow,iCol);
    end
end