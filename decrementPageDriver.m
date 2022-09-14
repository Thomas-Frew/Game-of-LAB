% A function driver for decrementPage.


% Testing the equivalence class: non-final page.
currentPage1 = 4;
totalPages1 = 8;

% Store the expected and true outputs for this test case.
expectedOutput1 = 3;
output1 = decrementPage(currentPage1,totalPages1);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i \t Total pages: %i \t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage1,totalPages1,expectedOutput1,output1);


% Testing the equivalence class: final page.
currentPage2 = 20;
totalPages2 = 20;

% Store the expected and true outputs for this test case.
expectedOutput2 = 19;
output2 = decrementPage(currentPage2,totalPages2);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i\t Total pages: %i\t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage2,totalPages2,expectedOutput2,output2);


% Testing the equivalence class: first page.
currentPage3 = 1;
totalPages3 = 5;

% Store the expected and true outputs for this test case.
expectedOutput3 = 5;
output3 = decrementPage(currentPage3,totalPages3);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i \t Total pages: %i \t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage3,totalPages3,expectedOutput3,output3);


% Testing the equivalence class: only page.
currentPage4 = 1;
totalPages4 = 1;

% Store the expected and true outputs for this test case.
expectedOutput4 = 1;
output4 = decrementPage(currentPage4,totalPages4);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i \t Total pages: %i \t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage4,totalPages4,expectedOutput4,output4);

