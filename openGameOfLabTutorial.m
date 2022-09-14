function openGameOfLabTutorial()
% OPENGAMEOFLABTUTORIAL: Executes an instance of the Game of LAB's
% tutorial.
% Copyright Thomas Frew, 2022, all rights reserved.

%% EXECUTED CODE: Script setup
% Clear all previous environment data.
clear all;
clc;

% Store the ID of the current page being viewed, beginning at 1
% ("The Game of Life").
currentPage = 1;

% Store the number of pages the tutorial contains.
PAGE_COUNT = 4;
%%

%% UI setup
% Initialise a UI figure to be used as the app's main window and 
% interface.
mainWindow = uifigure;

% Set the window's name to 'Game of LAB (Tutorial)'
set(mainWindow,'Name','Game of LAB (Tutorial)')

% Reposition the window to be 75 pixels away from the top-left corner 
% of the screen, in either direction. Also, make it 500x750 pixels, and
% non-resizable.
mainWindow.Position= [75 75 500 750];
set(mainWindow,'Resize','off')

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

%% Interface layout (grid)
% Initialise a grid layout, apply it to the UI, and color it the app's core
% dark color.
windowLayout = uigridlayout(mainWindow, ...
                              'BackgroundColor',CORE_DARK_COLOR);

% Split the page's UI into 2 rows.
% - 1x row fits the tutorial's content, occupying most of the page.
% - 70 row fits the tutorial's button navigation controls and page counter.
windowLayout.RowHeight = {'1x',70};

% Split the page's UI into 3, equally-sized columns.
% While the tutorial's content spans all three columns, each navigation
% button/page counter is placed in one column, each.
windowLayout.ColumnWidth = {'1x','1x','1x'};
%%  

%% UI elements: page core
% Initialise a frame to contain the elements of page 1, "The Game of Life".
page1Frame = uigridlayout(windowLayout,'BackgroundColor',CORE_DARK_COLOR);

% Split page 1's frame into 11 rows.
% - fit rows contain text content, which auto-resize to the correct height,
% and color it the app's dark color.
% - 70-pixel rows contain images, which auto-resize to a 70 pixel height.
page1Frame.RowHeight = {'fit','fit',70,'fit','fit',70,70,70,'fit',70};

% Split page 1's frame into 2, equally-sized columns.
page1Frame.ColumnWidth = {'1x', '1x'};

% Place page 1's frame in row 1 and columns 1-3 of the UI.
page1Frame.Layout.Row = 1;
page1Frame.Layout.Column = [1,3];


% Initialise a frame to contain the elements of page 2, "The Game of LAB 
% (Part 1)", and color it the app's dark color.
page2Frame = uigridlayout(windowLayout,'BackgroundColor',CORE_DARK_COLOR);

% Split page 2's frame into 8 rows.
% - fit rows contain text content, which auto-resize to the correct height.
% - 70-pixel rows contain images, which auto-resize to a 70 pixel height.
page2Frame.RowHeight = {'fit',70,70,70,70,70,70,70};

% Split page 2's frame into 2, equally-sized columns.
page2Frame.ColumnWidth = {'1x', '1x'};

% Place page 1's frame in row 1 and columns 1-3 of the UI.
page2Frame.Layout.Row = 1;
page2Frame.Layout.Column = [1,3];


% Initialise a frame to contain the elements of page 3, "The Game of LAB 
% (Part 2)", and color it the app's dark color.
page3Frame = uigridlayout(windowLayout,'BackgroundColor',CORE_DARK_COLOR);

% Split page 3's frame into 4 rows.
% - fit rows contain text content, which auto-resize to the correct height.
% - 70-pixel rows contain images, which auto-resize to a 70 pixel height.
page3Frame.RowHeight = {'fit',70,70,70};

% Split page 3's frame into 2, equally-sized columns.
page3Frame.ColumnWidth = {'1x', '1x'};

% Place page 3's frame in row 1 and columns 1-3 of the UI.
page3Frame.Layout.Row = 1;
page3Frame.Layout.Column = [1,3];


% Initialise a frame to contain the elements of page 4, "Interesting
% Patterns", and color it the app's dark color.
page4Frame = uigridlayout(windowLayout,'BackgroundColor',CORE_DARK_COLOR);

% Split page 4's frame into 11 rows.
% - fit rows contain text content, which auto-resize to the correct height.
% - 70-pixel rows contain images, which auto-resize to a 70 pixel height.
page4Frame.RowHeight = {'fit','fit','fit',70,'fit','fit',70,'fit','fit',...
                        140,'fit'};

% Split page 4's frame into 4, equally-sized columns.
page4Frame.ColumnWidth = {'1x', '1x', '1x', '1x'};

% Place page 4's frame in row 1 and columns 1-3 of the UI.
page4Frame.Layout.Row = 1;
page4Frame.Layout.Column = [1,3];


% Create a push button to navigate to the previous page of the tutorial.
previousButton = uibutton(windowLayout, ...
    'push',...
    'Text','️⬅️',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', {@previousPageCommand, PAGE_COUNT});

% Place the 'Back' button into row 2 and column 1 of the UI.
previousButton.Layout.Row = 2;
previousButton.Layout.Column = 1;


% Create a label displaying the game's current page number. 
pageNumberLabel = uilabel(windowLayout,...
                         'HorizontalAlignment','center',...
                         'FontName',HEAVY_FONT,...
                         'FontSize',REGULAR_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR);

% Place the page number label in row 2 and column 2 of the UI.
pageNumberLabel.Layout.Row = 2;
pageNumberLabel.Layout.Column = 2;


% Create a push button to navigate to the next page of the tutorial.
nextButton = uibutton(windowLayout, ...
    'push',...
    'Text','➡️',...
    'BackgroundColor',CORE_LIGHT_COLOR,...
    'FontName',LIGHT_FONT,...
    'FontSize',REGULAR_FONT_SIZE,...
    'ButtonPushedFcn', {@nextPageCommand, PAGE_COUNT});


% Place the 'Back' button into row 2 and column 3 of the UI.
nextButton.Layout.Row = 2;
nextButton.Layout.Column = 3;

%%

%% UI elements for page 1: The Game of Life
% Create and place the title for page 1 in the UI.
page1Title = uilabel(page1Frame,'Text','The Game of Life',...
                            'HorizontalAlignment','center',...
                             'FontName',HEAVY_FONT,...
                             'FontSize',TITLE_FONT_SIZE,...
                             'FontColor',CORE_LIGHT_COLOR);

page1Title.Layout.Row = 1;
page1Title.Layout.Column = [1,2];


% Create and place all body text for page 1 in the UI.
page1Intro = uilabel(page1Frame,'Text',"The Game of Life is a cellular automaton developed by Cambridge mathematician John Conway. While the system has practical physical and biological applications, it better demonstrates the beauty of emergence, with complex — almost alive — systems developing from simple rules.",...
                             'HorizontalAlignment','left',...
                             'VerticalAlignment','center',...
                             'FontName',LIGHT_FONT,...
                             'FontSize',SMALL_FONT_SIZE,...
                             'FontColor',CORE_LIGHT_COLOR,...
                             'WordWrap','on');

page1Intro.Layout.Row = 2;
page1Intro.Layout.Column = [1,2];

page1Body1 = uilabel(page1Frame,'Text',"The game's universe is a two-dimensional grid of cells — which are either alive (1) or dead (0).",...
                             'HorizontalAlignment','left',...
                             'VerticalAlignment','center',...
                             'FontName',LIGHT_FONT,...
                             'FontSize',SMALL_FONT_SIZE,...
                             'FontColor',CORE_LIGHT_COLOR,...
                             'WordWrap','on');

page1Body1.Layout.Row = 3;
page1Body1.Layout.Column = 2;

page1Body2 = uilabel(page1Frame,'Text',"In the next generation — the next step of a game — a cell's fate is determined by the following rules:",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',LIGHT_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR,...
                         'WordWrap','on');

page1Body2.Layout.Row = 4;
page1Body2.Layout.Column = [1,2];

page1Body3 = uilabel(page1Frame,'Text',"A cell that is alive...",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',HEAVY_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR);

page1Body3.Layout.Row = 5;
page1Body3.Layout.Column = [1,2];

page1Body4 = uilabel(page1Frame,'Text',"Will die if it is next to one or fewer alive cells — as if from loneliness.",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',LIGHT_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR,...
                         'WordWrap','on');

page1Body4.Layout.Row = 6;
page1Body4.Layout.Column = 2;

page1Body4 = uilabel(page1Frame,'Text',"Will die if it is next to four or more alive cells — as if from overpopulation.",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',LIGHT_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR,...
                         'WordWrap','on');

page1Body4.Layout.Row = 7;
page1Body4.Layout.Column = 2;

page1Body4 = uilabel(page1Frame,'Text',"Will survive if it is next to two or three alive cells.",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',LIGHT_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR,...
                         'WordWrap','on');

page1Body4.Layout.Row = 8;
page1Body4.Layout.Column = 2;

page1Body4 = uilabel(page1Frame,'Text',"Will survive if it is next to two or three alive cells.",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',LIGHT_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR,...
                         'WordWrap','on');

page1Body4.Layout.Row = 8;
page1Body4.Layout.Column = 2;

page1Body5 = uilabel(page1Frame,'Text',"A cell that is dead...",...
                         'HorizontalAlignment','left',...
                         'VerticalAlignment','center',...
                         'FontName',HEAVY_FONT,...
                         'FontSize',SMALL_FONT_SIZE,...
                         'FontColor',CORE_LIGHT_COLOR);

page1Body5.Layout.Row = 9;
page1Body5.Layout.Column = [1,2];

page1Body6 = uilabel(page1Frame,'Text',"Will become alive if it is next to precisely three alive cells, or remain dead otherwise.",...
                     'HorizontalAlignment','left',...
                     'VerticalAlignment','center',...
                     'FontName',LIGHT_FONT,...
                     'FontSize',SMALL_FONT_SIZE,...
                     'FontColor',CORE_LIGHT_COLOR,...
                     'WordWrap','on');

page1Body6.Layout.Row = 10;
page1Body6.Layout.Column = 2;


% Create and place all images for page 1 in the UI.
page1Image1 = uiimage(page1Frame,"ImageSource","./Assets/States.png");
page1Image1.Layout.Row = 3;
page1Image1.Layout.Column = 1;

page1Image2 = uiimage(page1Frame,"ImageSource","./Assets/Loneliness.png");
page1Image2.Layout.Row = 6;
page1Image2.Layout.Column = 1;

page1Image3 = uiimage(page1Frame,"ImageSource","./Assets/Overcrowd.png");
page1Image3.Layout.Row = 7;
page1Image3.Layout.Column = 1;

page1Image4 = uiimage(page1Frame,"ImageSource","./Assets/Survive.png");
page1Image4.Layout.Row = 8;
page1Image4.Layout.Column = 1;

page1Image5 = uiimage(page1Frame,"ImageSource","./Assets/Revive.png");
page1Image5.Layout.Row = 10;
page1Image5.Layout.Column = 1;
%%

%% UI elements for page 2: The Game of LAB (Part 1)
% Create and place the title for page 2 in the UI.
page2Title = uilabel(page2Frame,'Text','The Game of LAB (Part 1)',...
                                'HorizontalAlignment','center',...
                                'FontName',HEAVY_FONT,...
                                'FontSize',TITLE_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR);

page2Title.Layout.Row = 1;
page2Title.Layout.Column = [1,2];


% Create and place all body text for page 2 in the UI.
page2Body1 = uilabel(page2Frame,'Text',"The Game of LAB is a MATLAB implementation of the Game of Life, designed for speed and user-friendliness. The interface includes controls on the left and the Game of Life's universe on the right. The game should begin with a random configuration of alive and dead cells.",...                                    
                                'HorizontalAlignment','left',...
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body1.Layout.Row = 2;
page2Body1.Layout.Column = [1,2];

page2Body2 = uilabel(page2Frame,'Text',"To step to the next generation, press the 'Next Generation' button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body2.Layout.Row = 3;
page2Body2.Layout.Column = 2;

page2Body3 = uilabel(page2Frame,'Text',"To step through the game's generations automatically, press the 'Auto-Play' button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body3.Layout.Row = 4;
page2Body3.Layout.Column = 2;

page2Body4 = uilabel(page2Frame,'Text',"Adjust the 'Speed' slider to change the delay between generations (in ms) using 'Auto-Play'.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body4.Layout.Row = 5;
page2Body4.Layout.Column = 2;

page2Body5 = uilabel(page2Frame,'Text',"To reset the Game of LAB to its original cell configuration, press the 'Reset' button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body5.Layout.Row = 6;
page2Body5.Layout.Column = 2;

page2Body6 = uilabel(page2Frame,'Text',"To randomise the Game of LAB's cell configuration, press the 'Shuffle' button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body6.Layout.Row = 7;
page2Body6.Layout.Column = 2;

page2Body7 = uilabel(page2Frame,'Text',"To export the Game of LAB’s cell configuration as an image (PNG), press the 'Export' button.",...
                                'HorizontalAlignment','left',...
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page2Body7.Layout.Row = 8;
page2Body7.Layout.Column = 2;


% Create and place all images for page 2 in the UI.
page2Image1 = uiimage(page2Frame,"ImageSource","./Assets/Next Generation.png");
page2Image1.Layout.Row = 3;
page2Image1.Layout.Column = 1;

page2Image2 = uiimage(page2Frame,"ImageSource","./Assets/Auto-Play.png");
page2Image2.Layout.Row = 4;
page2Image2.Layout.Column = 1;

page2Image3 = uiimage(page2Frame,"ImageSource","./Assets/Speed Slider.png");
page2Image3.Layout.Row = 5;
page2Image3.Layout.Column = 1;

page2Image4 = uiimage(page2Frame,"ImageSource","./Assets/Reset Button.png");
page2Image4.Layout.Row = 6;
page2Image4.Layout.Column = 1;

page2Image5 = uiimage(page2Frame,"ImageSource","./Assets/Shuffle Button.png");
page2Image5.Layout.Row = 7;
page2Image5.Layout.Column = 1;

page2Image6 = uiimage(page2Frame,"ImageSource","./Assets/Save Button.png");
page2Image6.Layout.Row = 8;
page2Image6.Layout.Column = 1;

%%

%% UI elements for page 3: The Game of LAB (Part 2)
% Create and place the title for page 3 in the UI.
page3Title = uilabel(page3Frame,'Text','The Game of LAB (Part 2)',...
                                'HorizontalAlignment','center',...
                                'FontName',HEAVY_FONT,...
                                'FontSize',TITLE_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR);

page3Title.Layout.Row = 1;
page3Title.Layout.Column = [1,2];


% Create and place all body text for page 3 in the UI.
page3Body1 = uilabel(page3Frame,'Text',"To export the Game of LAB’s cell configuration as an text file, press the 'Save' button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page3Body1.Layout.Row = 2;
page3Body1.Layout.Column = 2;

page3Body2 = uilabel(page3Frame,'Text',"To import a saved cell configuration into the Game of LAB (from a text file), press the 'Load' button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page3Body2.Layout.Row = 3;
page3Body2.Layout.Column = 2;

page3Body3 = uilabel(page3Frame,'Text',"To view this tutorial again, press the “Tutorial” button.",...                                    
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page3Body3.Layout.Row = 4;
page3Body3.Layout.Column = 2;


% Create and place all images for page 3 in the UI.
page3Image1 = uiimage(page3Frame,"ImageSource","./Assets/Save Button.png");
page3Image1.Layout.Row = 2;
page3Image1.Layout.Column = 1;

page3Image2 = uiimage(page3Frame,"ImageSource","./Assets/Import Button.png");
page3Image2.Layout.Row = 3;
page3Image2.Layout.Column = 1;

page3Image3 = uiimage(page3Frame,"ImageSource","./Assets/Tutorial Button.png");
page3Image3.Layout.Row = 4;
page3Image3.Layout.Column = 1;
%%

%% UI elements for page 4: Interesting Patterns
% Create and place the title for page 4 in the UI.
page4Title = uilabel(page4Frame,'Text','Interesting Patterns',...
                                'HorizontalAlignment','center',...
                                'FontName',HEAVY_FONT,...
                                'FontSize',TITLE_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR);

page4Title.Layout.Row = 1;
page4Title.Layout.Column = [1,4];


% Create and place all body text for page 4 in the UI.
page4Body1 = uilabel(page4Frame,'Text',"While exploring the Game of Life, you may notice some recurring patterns. Many of these have been named and organised into three main categories based on their behaviours.",...
                                'HorizontalAlignment','left',...
                                'VerticalAlignment','center',...
                                'FontName',LIGHT_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page4Body1.Layout.Row = 2;
page4Body1.Layout.Column = [1,4];

page4Body2 = uilabel(page4Frame,'Text',"Still lifes are permanent, static patterns. For example...",...
                                'HorizontalAlignment','left',...
                                'VerticalAlignment','center',...
                                'FontName',HEAVY_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page4Body2.Layout.Row = 3;
page4Body2.Layout.Column = [1,4];

page4Body3 = uilabel(page4Frame,'Text',"Oscillators are patterns that switch between two or more states forever. For example...",...
                                'HorizontalAlignment','left',...
                                'VerticalAlignment','center',...
                                'FontName',HEAVY_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page4Body3.Layout.Row = 6;
page4Body3.Layout.Column = [1,4];

page4Body4 = uilabel(page4Frame,'Text',"Spaceships are patterns that translate themselves across the board. For example...",...
                                'HorizontalAlignment','left',...
                                'VerticalAlignment','center',...
                                'FontName',HEAVY_FONT,...
                                'FontSize',SMALL_FONT_SIZE,...
                                'FontColor',CORE_LIGHT_COLOR,...
                                'WordWrap','on');

page4Body4.Layout.Row = 9;
page4Body4.Layout.Column = [1,4];

% Captions for "Interesting Patterns"
page4Caption1 = uilabel(page4Frame,'Text',"Block",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption1.Layout.Row = 5;
page4Caption1.Layout.Column = 1;

page4Caption2 = uilabel(page4Frame,'Text',"Beehive",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption2.Layout.Row = 5;
page4Caption2.Layout.Column = 2;

page4Caption3 = uilabel(page4Frame,'Text',"Loaf",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption3.Layout.Row = 5;
page4Caption3.Layout.Column = 3;

page4Caption4 = uilabel(page4Frame,'Text',"Boat",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption4.Layout.Row = 5;
page4Caption4.Layout.Column = 4;

page4Caption5 = uilabel(page4Frame,'Text',"Spinner",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption5.Layout.Row = 8;
page4Caption5.Layout.Column = 1;

page4Caption6 = uilabel(page4Frame,'Text',"Toad",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption6.Layout.Row = 8;
page4Caption6.Layout.Column = 2;

page4Caption7 = uilabel(page4Frame,'Text',"Beacon",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption7.Layout.Row = 8;
page4Caption7.Layout.Column = 3;

page4Caption8 = uilabel(page4Frame,'Text',"Jam",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption8.Layout.Row = 8;
page4Caption8.Layout.Column = 4;

page4Caption9 = uilabel(page4Frame,'Text',"Glider",...
                                   'HorizontalAlignment','center',...
                                   'VerticalAlignment','center',...
                                   'FontName',LIGHT_FONT,...
                                   'FontSize',SMALL_FONT_SIZE,...
                                   'FontColor',CORE_LIGHT_COLOR);

page4Caption9.Layout.Row = 11;
page4Caption9.Layout.Column = [1,2];

page4Caption10 = uilabel(page4Frame,'Text',"Lightweight Spaceship",...
                                    'HorizontalAlignment','center',...
                                    'VerticalAlignment','center',...
                                    'FontName',LIGHT_FONT,...
                                    'FontSize',SMALL_FONT_SIZE,...
                                    'FontColor',CORE_LIGHT_COLOR);

page4Caption10.Layout.Row = 11;
page4Caption10.Layout.Column = [3,4];


% Create and place all images for page 4 in the UI.
page4Image1 = uiimage(page4Frame,"ImageSource","./Assets/Block.png");
page4Image1.Layout.Row = 4;
page4Image1.Layout.Column = 1;

page4Image2 = uiimage(page4Frame,"ImageSource","./Assets/Beehive.png");
page4Image2.Layout.Row = 4;
page4Image2.Layout.Column = 2;

page4Image3 = uiimage(page4Frame,"ImageSource","./Assets/Loaf.png");
page4Image3.Layout.Row = 4;
page4Image3.Layout.Column = 3;

page4Image4 = uiimage(page4Frame,"ImageSource","./Assets/Boat.png");
page4Image4.Layout.Row = 4;
page4Image4.Layout.Column = 4;

page1Image5 = uiimage(page4Frame,"ImageSource","./Assets/Spinner.gif");
page1Image5.Layout.Row = 7;
page1Image5.Layout.Column = 1;

page1Image6 = uiimage(page4Frame,"ImageSource","./Assets/Toad.gif");
page1Image6.Layout.Row = 7;
page1Image6.Layout.Column = 2;

page1Image7 = uiimage(page4Frame,"ImageSource","./Assets/Beacon.gif");
page1Image7.Layout.Row = 7;
page1Image7.Layout.Column = 3;

page1Image8 = uiimage(page4Frame,"ImageSource","./Assets/Jam.gif");
page1Image8.Layout.Row = 7;
page1Image8.Layout.Column = 4;

page1Image9 = uiimage(page4Frame,"ImageSource","./Assets/Glider.gif");
page1Image9.Layout.Row = 10;
page1Image9.Layout.Column = [1,2];

page1Image10 = uiimage(page4Frame,"ImageSource","./Assets/LWSS.gif");
page1Image10.Layout.Row = 10;
page1Image10.Layout.Column = [3,4];
%%

%% Button commands
function nextPageCommand(~,~,pageCount)
% NEXTPAGECOMMAND: Increments the tutorial's page ID, then refreshes
% the UI's content.
% ~: The source control's data (unused).
% ~: The event's data (unused).
% pageCount: The total number of pages in the tutorial.

% Increment the tutorial's page ID, looping around to the first page if
% appropriate.
currentPage = incrementPage(currentPage, pageCount);

% Update the UI's page visibilitiy properites, refreshing the page.
refreshTutorialPage(currentPage, pageCount);
end

function previousPageCommand(~,~,pageCount)
% PREVIOUSPAGECOMMAND: Decrements the tutorial's page ID, then
% refreshes the UI's content.

% Decrement the tutorial's page ID, looping around to the last page if
% appropriate.
currentPage = decrementPage(currentPage, pageCount);

% Update the UI's page visibilitiy properites, refreshing the page.
refreshTutorialPage(currentPage, pageCount);
end
%%

%% Helper functions
function refreshTutorialPage(page, count)
% REFRESHTUTORIALPAGE: Displays the appropriate page's content and number
% based on the passed page ID and total number of pages.

% Make all pages invisible, by default (this significantly simplifies code).
page1Frame.Visible = 'off';
page2Frame.Visible = 'off';            
page3Frame.Visible = 'off';
page4Frame.Visible = 'off';

% Comparing the page ID...
switch (page)
    % If the current page is page 1...
    case 1
        % Make page 1 visible.
        page1Frame.Visible = 'on';

    % If the current page is page 2...
    case 2
        % Make page 2 visible.
        page2Frame.Visible = 'on';

    % If the current page is page 3...           
    case 3
        % Make page 3 visible.
        page3Frame.Visible = 'on';  

    % If the current page is page 4...           
    case 4
        % Make page 4 visible.
        page4Frame.Visible = 'on';  

    % If something goes wrong, and the page ID is not found...
    otherwise
        % No display will be shown, making it obvious that an error has
        % occured.
        
        % Update the page number display to show that an error has occured.
        pageNumberLabel.Text = sprintf("Error");
end

% Update the page number label with the current page number and total
% number of pages.
pageNumberLabel.Text = sprintf("Page %i/%i",page,count);
end
%%

%% EXECUTED CODE: Runtime code
% Once the UI has built, begin by refreshing the display, so that the user
% can see the tutorial's first page.
refreshTutorialPage(currentPage, PAGE_COUNT);
%%
end