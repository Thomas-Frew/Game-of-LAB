% A function driver for appendBuffer.

% Clear all environment data.
clear all; %#ok<*CLALL> (suppress any warnings)
clc;


% Testing the equivalence class: single-element array.
input1 = 0;

% Store the expected and actual outputs for this function.
expectedOutput1 = [0,1;1,1];
output1 = appendBuffer(input1, 1);

% Flatten the expected and actual outputs into a string using sprintf, 
% delimited by spaces.
input1String = strtrim(sprintf('%.0f ', input1));
expectedOutput1String = strtrim(sprintf('%.0f ', expectedOutput1));
output1String = strtrim(sprintf('%.0f ', output1));

% Display the input and coutput for this test case.
fprintf("Input: %s\t Expected Output: %s\t Output: %s\n", ...
        input1String, expectedOutput1String, output1String);


% Testing the equivalence class: a square array.
input2 = [1,2;3,4];

% Store the expected and actual outputs for this function.
expectedOutput2 = [1,2,0;3,4,0;0,0,0];
output2 = appendBuffer(input2, 0);

% Flatten the input, expected output and actual output to a string using 
% sprintf, delimited by spaces.
input2String = strtrim(sprintf('%.0f ', input2));
expectedOutput2String = strtrim(sprintf('%.0f ', expectedOutput2));
output2String = strtrim(sprintf('%.0f ', output2));

% Display the input and coutput for this test case.
fprintf("Input: %s\t Expected Output: %s\t Output: %s\n", ...
        input2String, expectedOutput2String, output2String);


% Testing the equivalence class: a non-square array.
input3 = [1,1,1;1,1,1];

% Store the expected and actual outputs for this function.
expectedOutput3 = [1,1,1,2;1,1,1,2;2,2,2,2];
output3 = appendBuffer(input3, 2);

% Flatten the input, expected output and actual output to a string using 
% sprintf, delimited by spaces.
input3String = strtrim(sprintf('%.0f ', input3));
expectedOutput3String = strtrim(sprintf('%.0f ', expectedOutput3));
output3String = strtrim(sprintf('%.0f ', output3));

% Display the input and coutput for this test case.
fprintf("Input: %s\t Expected Output: %s\t Output: %s\n", ...
        input3String, expectedOutput3String, output3String);


% Testing the equivalence class: an empty array.
input4 = [];

% Store the expected and actual outputs for this function.
expectedOutput4 = 9;
output4 = appendBuffer(input4, 9);

% Flatten the input, expected output and actual output to a string using 
% sprintf, delimited by spaces.
input4String = strtrim(sprintf('%.0f ', input4));
expectedOutput4String = strtrim(sprintf('%.0f ', expectedOutput4));
output4String = strtrim(sprintf('%.0f ', output4));

% Display the input and coutput for this test case.
fprintf("Input: %s\t Expected Output: %s\t Output: %s\n", ...
        input4String, expectedOutput4String, output4String);


% Testing the equivalence class: a large array (relatively).
input5 = [2,2,2,2,2,2,2;2,2,2,2,2,2,2;2,2,2,2,2,2,2;2,2,2,2,2,2,2;];

% Store the expected and actual outputs for this function.
expectedOutput5 = [2,2,2,2,2,2,2,3;2,2,2,2,2,2,2,3;2,2,2,2,2,2,2,3;
                   2,2,2,2,2,2,2,3;3,3,3,3,3,3,3,3];
output5 = appendBuffer(input5, 3);

% Flatten the input, expected output and actual output to a string using 
% sprintf, delimited by spaces.
input5String = strtrim(sprintf('%.0f ', input5));
expectedOutput5String = strtrim(sprintf('%.0f ', expectedOutput5));
output5String = strtrim(sprintf('%.0f ', output5));

% Display the input and coutput for this test case.
fprintf("Input: %s\t Expected Output: %s\t Output: %s\n", ...
        input5String, expectedOutput5String, output5String);