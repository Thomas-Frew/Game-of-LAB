function finalPage = decrementPage(currentPage, pageCount)
% DECREMENTPAGE: Decrements the page ID of an ordered set of pages, looping
% forward to the final page if the current page is the first one.
% - currentPage: The current page ID.
% - pageCount:   The total number of pages in the set.
% - finalPage:   Returns the new page ID, after being decremented.

% If the current page is not the first one...
if currentPage ~= 1
    % Return the current page ID, minus one.
    finalPage = currentPage - 1;

% Otherwise...
else
    % Return the last page's ID (equal to the number of pages in the
    % ordered set).
    finalPage = pageCount;
end
end