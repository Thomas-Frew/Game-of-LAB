% A function driver for computeNextGeneration.

% Clear all environment data.
clear all; %#ok<*CLALL> (suppress any warnings)
clc;


% Display that we are performing accuracy tests.
disp("ACCURACY TESTS")

% Initialise a matrix of 3x3 Game of Life boards, to test the Game of LAB's 
% engine on. 
testBoards = cat(3, [0,0,0;0,0,0;0,0,0], ... % Dead board (all 0s)
                    [0,0,0;0,1,0;0,0,0], ... % Single alive center
                    [0,1,0;0,1,0;0,1,0], ... % Spinner
                    [1,1,0;1,1,0;0,0,0], ... % Block
                    [0,1,0;1,0,1;0,1,0], ... % Tub
                    [1,0,1;0,1,0;1,0,1], ... % Checkerboard
                    [1,1,1;0,0,0;1,1,1], ... % Parallel bars
                    [0,1,0;0,0,1;1,1,1], ... % Glider
                    [1,1,1;1,0,1;1,1,1], ... % Donut
                    [1,1,1;1,1,1;1,1,1]);    % Dense board (all 1s)

% Store the expected results for each test case.
expectedResults = cat(3, [0,0,0;0,0,0;0,0,0], ... % Dead board (all 0s)
                         [0,0,0;0,0,0;0,0,0], ... % Single alive center
                         [0,0,0;1,1,1;0,0,0], ... % Spinner
                         [1,1,0;1,1,0;0,0,0], ... % Block
                         [0,1,0;1,0,1;0,1,0], ... % Tub
                         [0,1,0;1,0,1;0,1,0], ... % Checkerboard
                         [0,1,0;0,0,0;0,1,0], ... % Parallel bars
                         [0,0,0;1,0,1;0,1,1], ... % Glider
                         [1,0,1;0,0,0;1,0,1], ... % Donut
                         [1,0,1;0,0,0;1,0,1]);    % Dense board (all 1s)

% For each index, i, between 1 and the number of test cases (such that
% every case is considered...
for i = 1:length(testBoards)
    % Display the test case number, to help visually distinguish cases
    fprintf("TEST CASE NUMBER %i/%i:\n",i,length(testBoards))

    % Display the engine's input.
    disp("Input state:");
    disp(testBoards(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResults(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoards(:,:,i)));
end


% Display that we are performing extensibility tests.
disp("EXTENSBILITY TESTS")

% Initialise a matrix of 3x3 Game of Life boards, to test the Game of LAB's 
% engine on. 
testBoards = cat(3, [1,0,1;0,0,0;1,0,1], ... % Corner board (dies next turn)
                    [1,1,0;1,0,1;0,1,0], ... % Boat (still-life)
                    [0,1,0;0,1,0;0,1,0]);    % Spinner (oscillator)

% Initialise a matrix of 4x4 Game of Life boards, to test these game
% boards' output after being padded with zeros on all edges.
testBoards1Pad = cat(3, appendBuffer(testBoards(:,:,1),0), ...
                        appendBuffer(testBoards(:,:,2),0), ...
                        appendBuffer(testBoards(:,:,3),0));

% Initialise a matrix of 5x5 Game of Life boards, to test these game
% boards' output after being padded with zeros on all edges.
testBoards2Pad = cat(3, appendBuffer(testBoards1Pad(:,:,1),0), ...
                        appendBuffer(testBoards1Pad(:,:,2),0), ...
                        appendBuffer(testBoards1Pad(:,:,3),0));

% Initialise a matrix of 6x6 Game of Life boards, to test these game
% boards' output after being padded with zeros on all edges.
testBoards3Pad = cat(3, appendBuffer(testBoards2Pad(:,:,1),0), ...
                        appendBuffer(testBoards2Pad(:,:,2),0), ...
                        appendBuffer(testBoards2Pad(:,:,3),0));

% Store the expected results for each 3x3 test case.
expectedResults = cat(3, [0,0,0;0,0,0;0,0,0], ... % Corner board (dies next turn)
                         [1,1,0;1,0,1;0,1,0], ... % Boat (still-life)
                         [0,0,0;1,1,1;0,0,0]);    % Spinner (oscillator)

% When given the same input, padded with zeros on all edges, the game
% engine should create the same output.

% Store the expected results for each 4x4 test case.
expectedResults1Pad = cat(3, appendBuffer(expectedResults(:,:,1),0), ...
                             appendBuffer(expectedResults(:,:,2),0), ...
                             appendBuffer(expectedResults(:,:,3),0));

% Store the expected results for each 5x5 test case.
expectedResults2Pad = cat(3, appendBuffer(expectedResults1Pad(:,:,1),0), ...
                             appendBuffer(expectedResults1Pad(:,:,2),0), ...
                             appendBuffer(expectedResults1Pad(:,:,3),0));

% Store the expected results for each 6x6 test case.
expectedResults3Pad = cat(3, appendBuffer(expectedResults2Pad(:,:,1),0), ...
                             appendBuffer(expectedResults2Pad(:,:,2),0), ...
                             appendBuffer(expectedResults2Pad(:,:,3),0));

% For each index, i, between 1 and the number of test cases (such that
% every case is considered...
for i = 1:length(testBoards)
    % Display the test case number, to help visually distinguish cases
    fprintf("TEST CASE NUMBER %i/%i:\n",i,length(testBoards))


    % Display the engine's input.
    disp("Input state (no padding):");
    disp(testBoards(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResults(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoards(:,:,i)));


    % Display the engine's input.
    disp("Input state (one layer of padding):");
    disp(testBoards1Pad(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResults1Pad(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoards1Pad(:,:,i)));


    % Display the engine's input.
    disp("Input state (two layers of padding):");
    disp(testBoards2Pad(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResults2Pad(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoards2Pad(:,:,i)));


    % Display the engine's input.
    disp("Input state (three layers of padding):");
    disp(testBoards3Pad(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResults3Pad(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoards3Pad(:,:,i)));
end


% Display that we are performing symmetry tests.
disp("SYMMETRY TESTS")

% Initialise a matrix of 3x3 Game of Life boards, to test the Game of LAB's 
% engine on. 
testBoards = cat(3, [1,1,0;1,0,1;0,0,0], ... % Decaying board
                    [1,1,0;1,1,0;0,0,0], ... % Block (still-life)
                    [0,1,0;0,1,0;0,1,0]);    % Spinner (oscillator)

% Intiailise a matrix of mirrored copies of each test board.
testBoardsMirrored = cat(3, [0,1,1;1,0,1;0,0,0], ... % Decaying board
                            [0,1,1;0,1,1;0,0,0], ... % Block (still-life)
                            [0,1,0;0,1,0;0,1,0]);    % Spinner (oscillator)

% Intiailise a matrix of each test board, rotated 90° clockwise.
testBoardsRotated = cat(3, [0,1,1;0,0,1;0,1,0], ... % Decaying board
                           [0,1,1;0,1,1;0,0,0], ... % Block (still-life)
                           [0,0,0;1,1,1;0,0,0]);    % Spinner (oscillator)


% Store the expected results for each 3x3 test case.
expectedResults = cat(3, [1,1,0;1,0,0;0,0,0], ... % Decaying board
                         [1,1,0;1,1,0;0,0,0], ... % Block (still-life)
                         [0,0,0;1,1,1;0,0,0]);    % Spinner (oscillator)

% Store the expected results for each 3x3 mirrored test case.
expectedResultsMirrored= cat(3, [0,1,1;0,0,1;0,0,0], ... % Decaying board
                                [0,1,1;0,1,1;0,0,0], ... % Block (still-life)
                                [0,0,0;1,1,1;0,0,0]);    % Spinner (oscillator)

% Store the expected results for each 3x3 rotated test case.
expectedResultsRotated = cat(3, [0,1,1;0,0,1;0,0,0], ... % Decaying board
                                [0,1,1;0,1,1;0,0,0], ... % Block (still-life)
                                [0,1,0;0,1,0;0,1,0]);    % Spinner (oscillator)


% For each index, i, between 1 and the number of test cases (such that
% every case is considered...
for i = 1:length(testBoards)
    % Display the test case number, to help visually distinguish cases
    fprintf("TEST CASE NUMBER %i/%i:\n",i,length(testBoards))


    % Display the engine's input.
    disp("Input state (no transformation):");
    disp(testBoards(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResults(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoards(:,:,i)));


    % Display the engine's input.
    disp("Input state (mirrored):");
    disp(testBoardsMirrored(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResultsMirrored(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoardsMirrored(:,:,i)));


    % Display the engine's input.
    disp("Input state (rotated):");
    disp(testBoardsRotated(:,:,i));
    
    % Display the expected output, for the next generation of this state.
    disp("Expected output:");
    disp(expectedResultsRotated(:,:,i));
    
    % Display the engine's output, its calculated state for the game's 
    % next generation.
    disp("Output:");
    disp(computeNextGeneration(testBoardsRotated(:,:,i)));
end
