% A function driver for incrementPage.


% Testing the equivalence class: non-final page.
currentPage1 = 2;
totalPages1 = 5;

% Store the expected and true outputs for this test case.
expectedOutput1 = 3;
output1 = incrementPage(currentPage1,totalPages1);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i \t Total pages: %i \t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage1,totalPages1,expectedOutput1,output1);


% Testing the equivalence class: final page.
currentPage2 = 10;
totalPages2 = 10;

% Store the expected and true outputs for this test case.
expectedOutput2 = 1;
output2 = incrementPage(currentPage2,totalPages2);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i\t Total pages: %i\t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage2,totalPages2,expectedOutput2,output2);


% Testing the equivalence class: first page.
currentPage3 = 1;
totalPages3 = 7;

% Store the expected and true outputs for this test case.
expectedOutput3 = 2;
output3 = incrementPage(currentPage3,totalPages3);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i \t Total pages: %i \t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage3,totalPages3,expectedOutput3,output3);


% Testing the equivalence class: only page.
currentPage4 = 1;
totalPages4 = 1;

% Store the expected and true outputs for this test case.
expectedOutput4 = 1;
output4 = incrementPage(currentPage4,totalPages4);

% Display the expected and true outputs for this test case.
fprintf("Current page: %i \t Total pages: %i \t " + ...
        "Expected output: %i \t Output: %i\t\n", ...
        currentPage4,totalPages4,expectedOutput4,output4);

