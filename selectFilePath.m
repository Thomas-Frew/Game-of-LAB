function filePath = selectFilePath(extensions, mustExist)
% SELECTFILEPATH: Opens a dialog box for the user to select a file's name
% and directory, then returns to full file path to access this location.
% - extensions: A whitelist of file extentions the user can select.
% - mustExist:  Whether or not the file being selected must exist.
% - filePath:   Returns the path to the user's selected file.

% Initialise a sentinel, storing whether a valid file path is selected.
% This allows the user to be continually prompted with dialog boxes, until
% they select a valid file name and location.
validPathSelected = false;

% While the user has not selected a file with a valid path...
while ~validPathSelected

    % If the file being selected must exist...  
    if mustExist
        % Open a dialog box for the user to select their file. 
        % uigetfile forces the user to select an existing file.
        [fileName,fileDir] = uigetfile(extensions);
    else
        % Open a dialog box for the user to select their file. 
        % uiputfile does not force the user to select an existing file, and
        % warns them if they do so, since this file may be overwritten.
        [fileName,fileDir] = uiputfile(extensions);
    end

    % Combine the file's name and directory into its complete file path.
    filePath = fullfile(fileDir, fileName);
    
    % If the user's selected file path contains any string from whitelist 
    % of file extensions (so it is a valid path of the correct type)...
    if (contains(filePath, eraseBetween(string(extensions),1,1)))
        % Store that the user has selected a valid file path.
        validPathSelected = true;
    end
end
end