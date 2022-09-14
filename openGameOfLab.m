function openGameOfLab
% OPENGAMEOFLAB: Executes an instance of the Game of LAB.
% Copyright Thomas Frew, 2022, all rights reserved.

%% EXECUTED CODE: Pre-UI setup
% Clear all previous environment data.
clear all;
clc;

% Shuffle the random number generator, so unique cell configurations
% are created when pressing the "Shuffle" button.
rng('shuffle');

% Force the user to enter a positive integer, for the length of the
% Game of Life's board. This will also be the board's width.
boardLength = forcePositiveIntegerInput( ...
    "Please enter the Game of Life's length (in cells). \n>> ");
boardWidth = boardLength;

% Display that the game of LAB is now loading, with the user's specified
% dimensions.
fprintf("Loading the Game of LAB with a %i×%i board...\n", ...
    boardLength,boardLength);

% Initialise an random 2D array of binary values, with dimensions equal
% to the game board's dimensions. This will represent the configuration
% of alive (1) and dead (0) cells in the app's Game of Life.
cellStates = randi([0,1], boardLength, boardWidth);

% Initialise the game's initial state, as its current cell states, to
% be fallen back to when the "Reset" button is pressed.
initialCellStates = cellStates;

% Intialise a counter for the current number, starting at generation 1.
generationNumber = 1;

% Initialise a boolean sentinel to store whether the Game of Life is in
% auto-play mode. This is off, by default.
autoplayState = false;
%%

%% UI setup
% Initialise a UI figure to be used as the app's main window and 
% interface.
mainWindow = uifigure;

% Set the window's name to 'The Game of LAB'.
set(mainWindow,'Name','The Game of LAB')

% Reposition the window to be 75 pixels away from the top-left corner 
% of the screen, in either direction. Also, make it 700x500 pixels
% (though this is resizable).
mainWindow.Position= [75 75 700 500];

% Set the app's icon to the official Game of LAB logo.
mainWindow.Icon = "./Assets/Logo.png";
%%

%% Styles (see 'Design Planning' document)
% Initialise constants to store the light and dark colors present
% throughout the application.
[CORE_LIGHT_COLOR, CORE_DARK_COLOR] = loadColors();

% Initialise constants to store the heavy (semibold) and light fonts
% used throughout the application.
[HEAVY_FONT, LIGHT_FONT] = loadFontWeights();

% Initialise constants to store the three font sizes used throughout
% the application.
[TITLE_FONT_SIZE, REGULAR_FONT_SIZE, SMALL_FONT_SIZE] = loadFontSizes();
%%

%% UI layout (grid)
% Initialise a grid layout, apply it to the UI, and color it the app's core
% dark color.
interfaceLayout = uigridlayout(mainWindow, ...
                              'BackgroundColor',CORE_DARK_COLOR);

% Split the app's UI into 9 rows.
% - 1x rows store subtitles and sliders.
% - 2x rows store titles and buttons.
% - 10-pixel rows are used for white space.
interfaceLayout.RowHeight = {'2x', '1x', 10, '1x', '2x', ... 
                             '2x', '2x', '2x', '2x'};

% Split the app's UI into 4 columns.
% - 1x columns store the three columns of the UI.
% - 3x column stores the game board.
interfaceLayout.ColumnWidth = {'1x', '1x', '1x', '3x',};
%%  

%% UI Controls
% Create an empty set of axes, which will be used to display the Game
% of Life's current state.
gameBoard = uiaxes(interfaceLayout);

% Setup the game board with the appropriate size and layout.
gameBoard = createBinaryGridPlot(gameBoard, boardLength, boardWidth);

% Place the game board in rows 1-9 and column 4 of the UI.
gameBoard.Layout.Row = [1,9];
gameBoard.Layout.Column = 4;


% Create a label displaying the app's title.
titleLabel = uilabel(interfaceLayout, ...
                    'Text','Game of LAB',...
                    'HorizontalAlignment','center',...
                    'FontName',HEAVY_FONT,...
                    'FontSize',TITLE_FONT_SIZE,...
                    'FontColor',CORE_LIGHT_COLOR);

% Place this label in row 1 and columns 1-3 of the UI.
titleLabel.Layout.Row = 1;
titleLabel.Layout.Column = [1,3];


% Create a label displaying the app's developer.
authorLabel = uilabel(interfaceLayout, ...
                     'Text','Developed by Thomas Frew',...
                     'HorizontalAlignment','center',...
                     'FontName',LIGHT_FONT,...
                     'FontSize',REGULAR_FONT_SIZE,...
                     'FontColor',CORE_LIGHT_COLOR);

% Place this label in row 2 and columns 1-3 of the UI.
authorLabel.Layout.Row = 2;
authorLabel.Layout.Column = [1,3];


% Create a label displaying the game's current generation number. 
% This has no text when defined, but is given text when the refreshDisplay
% function is first executed.
generationLabel = uilabel(interfaceLayout,...
                         'HorizontalAlignment','center',...
                         'FontName',HEAVY_FONT,...
                         'FontSize',REGULAR_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR);

% Place the generation number label in row 4 and columns 1-3 of the UI.
generationLabel.Layout.Row = 4;
generationLabel.Layout.Column = [1,3];


% Create a label indicating that the slider next to it controls the delay
% between auto-play generations.
autoplayDelayLabel = uilabel(interfaceLayout, ...
                    'Text','Delay',...
                    'HorizontalAlignment','center',...
                    'FontName',HEAVY_FONT,...
                    'FontSize',REGULAR_FONT_SIZE,...
                    'FontColor',CORE_LIGHT_COLOR);


% Place the auto-play delay label in row 7 and column 1 of the UI.
autoplayDelayLabel.Layout.Row = 7;
autoplayDelayLabel.Layout.Column = 1;


% Create a push button to progress the Game of Life to the next generation,
% when pressed.
nextGenerationButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','Next Generation',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @displayNextGeneration);

% Place the 'Next Generation' button into row 5 and columns 1-3 of the UI.
nextGenerationButton.Layout.Row = 5;
nextGenerationButton.Layout.Column = [1,3];


% Create a push button to automatically step through the Game of Life's
% generations, when pressed.
autoplayButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','Auto-Play',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @invertAutoplayState);

% Place the 'Auto-Play' button into row 6 and columns 1-3 of the UI.
autoplayButton.Layout.Row = 6;
autoplayButton.Layout.Column = [1,3];


% Create a slider for the user to intuitively control the delay between 
% generations, when running auto-play. Make its value 50 milliseconds by
% default, with a lower limit of 0 and an upper limit of 2000.
autoplayDelaySlider = uislider(interfaceLayout, ...
                              'Value',50,...
                              'Limits',[0 2000],...
                              'MajorTicks',[0,500,1000,1500,2000],...
                              'FontSize',SMALL_FONT_SIZE,...
                              'FontColor',CORE_LIGHT_COLOR);

% Place the autoplay speed slider into row 7 and columns 2-3 of the UI.
autoplayDelaySlider.Layout.Row = 7;
autoplayDelaySlider.Layout.Column = [2,3];


% Create a push button to reset the states of cells in the Game of Life to
% their original (generation 1) configuration.
resetButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','🔃',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @resetCellStates);


% Place the 'Reset' button into row 8 and column 1 of the UI.
resetButton.Layout.Row = 8;
resetButton.Layout.Column = 1;


% Create a push button to randomise the states of cells in the Game of
% Life.
randomiseButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','🔀',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @shuffleCellStates);

% Place the 'Shuffle' button into row 8 and column 2 of the UI.
randomiseButton.Layout.Row = 8;
randomiseButton.Layout.Column = 2;


% Create a push button to export the game's current state as an image.
exportButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','💾',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @(btn,event) savePlotImage(gameBoard));

% Place the 'Export' button into row 8 and column 3 of the UI.
exportButton.Layout.Row = 8;
exportButton.Layout.Column = 3;


% Create a push button to save the game's state as a compact, 1-dimensional
% text file.
saveButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','⏫',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @savePlotText);

% Place the 'Save' button into row 9 and column 1 of the UI.
saveButton.Layout.Row = 9;
saveButton.Layout.Column = 1;


% Create a push button to load the game's state from GOL-created save data.
saveButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','⏬',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @loadPlot);

% Place the 'Load' button into row 9 and column 2 of the UI.
saveButton.Layout.Row = 9;
saveButton.Layout.Column = 2;


% Create a button to open the Game of LAB's tutorial window.
% Its button command is not a call-back, as it is a stand-alone, external
% script.
tutorialButton = uibutton(interfaceLayout, ...
    'push',...
    'Text','❓',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', @(btn,evt) openGameOfLabTutorial());

% Place the 'Tutorial' button into row 9 and column 3 of the UI.
tutorialButton.Layout.Row = 9;
tutorialButton.Layout.Column = 3;
%%

%% Button commands
function displayNextGeneration(~,~)
% DISPLAYNEXTGENERATION: Computes and displays the Game of Life's
% next generation and generation number, based on the game's current 
% state.
% ~: The source control's data (unused).
% ~: The event's data (unused).

% Determine the cell states of the Game of Life's next generation.
cellStates = computeNextGeneration(cellStates);

% Increment the current generation number.
generationNumber = generationNumber + 1;

% Refresh the UI, displaying the Game of Life's state and generation
% number.
refreshDisplay(cellStates);
end

function invertAutoplayState(~,~)
% INVERTAUTOPLAYSTATE: Inverts whether the Game of LAB should or
% shouldn't be running automatically, then executes this.
% ~: The source control's data (unused).
% ~: The event's data (unused).

% Set the auto-play state to not itself (inverting its value).
% This should terminate any existing auto-play instances.
autoplayState = ~autoplayState;

% Run auto-play, if appropriate.
if autoplayState
    runAutoPlay();
end
end

function shuffleCellStates(~,~)
% SHUFFLECELLSTATES: Randomises the Game of Life's cell states,
% (maintaining its current board dimensions) and resets the generation
% counter, displaying this on the UI.
% ~: The source control's data (unused).
% ~: The event's data (unused).

% Store the length and width of the game's board.
[length,width] = size(cellStates);

% Set the Game of Life's cell states to a random 2D binary array, with
% dimensions equal to the game board's dimensions.
cellStates = randi([0,1], length, width);

% Redefine the game's inital cell states to the states that have been 
% randomly generated.
initialCellStates = cellStates;

% Reset the Game of Life, with the randomised cell states as the new 
% default.
resetCellStates(cellStates);
end

function resetCellStates(~,~)
% RESETCELLSTATES: Resets the game board to its saved, 'initial state'
% and resets the generation counter, displaying this on the UI.
% ~: The source control's data (unused).
% ~: The event's data (unused).

% Set the game's cell states to their 'initial state'.
cellStates = initialCellStates;

% Reset the generation counter.
generationNumber = 1;

% Refresh the UI, displaying the Game of Life's state and generation
% number.
refreshDisplay(cellStates);
end

function savePlotImage(figure)
% SAVEPLOTIMAGE: From a passed MATLAB uifigure, allow the user to select a
% directory and save the figure as various image types.
% ~: The source control's data (unused).
% ~: The event's data (unused).
% figure: The passed MATLAB ui figure to be saved.

% Define a cell array of image file extensions the user can save their 
% figure as.
extensionFilters = {'*.png';'*.jpg';'*.jpeg';'*.tff'};

% Force the user to select valid name and file extension to save their 
% figure as.
filePath = selectFilePath(extensionFilters, false);

% Export the passed figure as an image file with the selected path.
exportgraphics(figure,filePath)
end

function savePlotText(~,~)
% SAVEPLOTTEXT: Saves cell states from the Game of Life as a 1D text file,
% to later be loaded using loadPlot.
% ~: The source control's data (unused).
% ~: The event's data (unused).

% This function uses a comma-element, colon-line encoding scheme, where:
% a, b, c       =>      a,b,c,:d,e,f:
% d, e, f

% Force the user to select valid name and file extension (text file) to 
% save their figure as.
filePath = selectFilePath("*.txt",false);

% Open (or create) the user's selected text file, with write permissions. 
% Store this session's ID.
fileID = fopen(filePath,'wt');

% Store the number of rows and columns in the passed plot data.
[plotDataRows,plotDataCols] = size(cellStates);

% For every integer, iRow, between 1 and the plot data's number of rows
% (such that every row is iterated through)...
for iRow = 1:plotDataRows

    % For every integer, iCol, between 1 and the plot data's number of
    % columns (such that every column is iterated through)...
    for iCol = 1:plotDataCols
        % Export the data point at (iRow, iCol) to the user's selected text
        % file.
        fprintf(fileID,'%i',cellStates(iRow,iCol));

        % Delimit each data point with a comma.
        fprintf(fileID,',');
    end

    % Delimit each row of data points with a colon.
    fprintf(fileID,':');
end
end

function loadPlot(~,~)
% LOADPLOT: Loads cell states for the Game of Life, from plot data
% saved using savePlotText.
% ~: The source control's data (unused).
% ~: The event's data (unused).

% Force the user to select valid name and file extension (text file) to 
% save their figure as.
filePath = selectFilePath("*.txt", true);  

% Open the user's selected file, with read permissions. 
% Store this session's ID.
fileID = fopen(filePath,'rt');

% Read the content of the user's selected file to a string variable.
fileData = fscanf(fileID,'%s');

% Split the file's data at colons, transforming it into a 1D array. 
% Each element represents one row of game data.
fileData = string(cell2mat(strip(split(fileData,':'),',')));

% Clear the game board's cell states, as they are about to be overwritten
% via an appending loop.
cellStates = [];

% For each integer, iRow, between 1 and the number of rows in the
% selected file's data...
for iRow = 1:length(fileData)
    % Append the current row of file data to the Game of Life's cell 
    % states, splitting elements in the row by their commas.
    cellStates = [cellStates; str2double(split(fileData(iRow),',').')];
end

% Redefine the Game of Life's length and width based on the size of the 
% game that was just imported.
boardLength = length(cellStates);
boardWidth = width(cellStates);

% Recreate the UI's game board based on its new dimensions, so the Game of
% Life can continue to be displayed correctly.
gameBoard = createBinaryGridPlot(gameBoard,boardLength,boardWidth);

% Redefine the game's inital cell states to the states that have been 
% loaded.
initialCellStates = cellStates;

% Reset the Game of Life, with the loaded cell states as the new default.
resetCellStates(cellStates);
end
%%

%% Helper functions
function refreshDisplay(states)
    % REFRESHDISPLAY: Refreshes the UI by updating the game board and
    % generation counter.
    % states: The Game of Life's current cell states.

    % The values of cells on the game board are really based on the
    % intersections of the plot, not values inside the squares. Hence, to
    % display our cell states, we must first buffer this data with a row
    % and column of 'dummy information' (in this case, 0s).
    paddedStates = appendBuffer(states,0);

    % Display the game's cell states in the UI.
    pcolor(gameBoard,1:length(paddedStates),1:width(paddedStates), ...
           paddedStates);

    % Update the generation counter's text with the appopriate number.
    generationLabel.Text = sprintf("Generation %.0f",generationNumber);
end

function runAutoPlay()
    % RUNAUTOPLAY: Steps through Game of LAB generations automatically,
    % as long as autoplayState remains true. 
    % As soon as autoplayState becomes false, this instance is terminated,
    % so the UI doesn't lag from sustained while loops.

    % While auto-play should still be running...
    while autoplayState
        % Display the Game of Life's next generation.
        displayNextGeneration();

        % Calculate the delay between generations by converting the 
        % delay slider's value into seconds. This is recalculated every
        % iteration so the delay can be adjusted while the game runs.
        delay = get(autoplayDelaySlider,'value')/1000;

        % Wait for the appropriate delay.
        pause(delay)
    end  
end
%%

%% EXECUTED CODE: Runtime code
% Display that the game of LAB has loaded.
fprintf("Application built successfully.\n")

% Once the UI has built, begin by refreshing the display, so that the user
% can see the Game of Life's initial state.
refreshDisplay(cellStates);
%%
end