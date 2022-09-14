function cleanInput = forcePositiveIntegerInput(message)
% FORCEPOSITIVEINTEGERINPUT: Force the user to input a positive integer 
% value, by repeatedly prompting them with the same message and pointing
% out there mistake if they make an invalid input.
% - message:    The prompt for the user's input.
% - cleanInput: The user's input, converted to an integer.

% Initialise the user's input, as false (logical zero) by default. 
% This should allow the user to fall into the loop, as it is not a positive
% integer.
userInput = false;

% Initialise a variable storing whether this is the user's first input 
% attempt.
firstInput = true;

% Initialise a sentinel to store whether the user has entered a valid, 
% positive integer yet.
validInput = false;

% Check if the user's input is not an integer (if its value and its
% floor are not equal), or not a valid double.

% While a valid input has not been entered...
while (~validInput)
    % If the user has already attempted an input, point out that their 
    % previous input not a valid, positive integer.
    if ~firstInput
        disp("Your input was not a positive integer. ")
    end

    % Using the passed prompt, ask the user to input a value.
    userInput = input(message, 's');

    % If the user's input is:
    % - Not, 'Not a Number', when converted to a double.
    % - Equal to the floor of its value (so it is an integer).
    % - Greater than 0 (so it is positive).
    % then a valid input has been given, and validInput is true.
    % Otherwise, it continues to be false.
    validInput = ~isnan(str2double(userInput)) && ...
            floor(str2double(userInput)) == str2double(userInput) && ...
            str2double(userInput) > 0;

    % After any attempt, set firstInput to no longer be true.
    firstInput = false;
end

% Return the user's input, converted to a double value.
cleanInput = str2double(userInput);
end