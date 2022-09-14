function plot = createBinaryGridPlot(plot, length, width)
% CREATEBINARYGRIDPLOT: Sets up a plot which can display binary values from
% a 2D array as a grid of white (0) and blue (1) squares.
% - plot: The plot to be set up. This should begin as empty UI axes and be
% returned as a complete, binary grid plot.
% - length: The binary grid plot's length.
% - width: The binary grid plot's width.

% Define a 1:1:1 aspect ratio for the plot, forcing it to be square.
plot.PlotBoxAspectRatio = [1,1,1];

% Rotate the plot -90 degrees in the Y direction, so its values are
% displayed from left-to-right and top-to-bottom (in the same direction as 
% a 2D array).
plot.View = [0,-90];

% Set the X and Y limits of the plot to the passed length and width, plus 
% one. This is because x+1 lines enclose x boxes.
plot.XLim = [1 length+1];
plot.YLim = [1 width+1];

% Hide the plot's axes, as they are irrelevant.
axis(plot, 'off')

% Create a two-color map for the plot's squares.
% Map zeros to a white squares (#f5f5f5, or R=0.960, G=0.960, B=0.960).
% Map ones to a blue squares (#53acff, or R=0.325, G=0.675, B=1.000).
plotColorMap = [0.96 0.96 0.96; 0.325 0.675 1];

% Apply the color map to the plot.
set(plot,'Colormap',plotColorMap)
 
% Specify that the color map applies to binary values, by defining the
% color axis from 0 to 1.
caxis(plot,[0,1])
end