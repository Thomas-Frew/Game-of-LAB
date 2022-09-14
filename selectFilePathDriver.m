% A function driver for the function selectFilePath.


% Testing the equivalence class: selecting a .txt file, 
% does not have to exist.
extensionFilters1 = {'*.txt'};
filePath1 = selectFilePath(extensionFilters1,false);

% Display the input filters and the full file path (no expected output 
% exists, as the file directory is contextual).
fprintf("Input filters: %s\t Output: %s\n", ...
        string(extensionFilters1),filePath1);


% Testing the equivalence class: selecting any image file, must exist.
extensionFilters2 = {'*.png';'*.jpg';'*.jpeg';'*.tff'};
filePath2 = selectFilePath(extensionFilters2, true);

% Display the input filters and the full file path (no expected output 
% exists, as the file directory is contextual).
fprintf("Input filters: %s,%s,%s,%s\t Output: %s\n", ...
        string(extensionFilters2),filePath2);


% Testing the equivalence class: selecting any Word file, must exist.
extensionFilters3 = {'*.doc';'*.docx'};
filePath3 = selectFilePath(extensionFilters3, true);

% Display the input filters and the full file path (no expected output 
% exists, as the file directory is contextual).
fprintf("Input filters: %s,%s,%s,%s\t Output: %s\n", ...
        string(extensionFilters3),filePath3);