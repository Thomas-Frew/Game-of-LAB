function finalPage = incrementPage(currentPage, pageCount)
% INCREMENTPAGE: Increments the page ID of an ordered set of pages, looping
% the first page if the current page is the last one.
% - currentPage: The current page ID.
% - pageCount:   The total number of pages in the set.
% - finalPage:   Returns the new page ID, after being incremented.

% If the current page is not the last one...
if currentPage ~= pageCount
    % Return the current page ID, plus one.
    finalPage = currentPage + 1;

% Otherwise...
else
    % Return the first page's ID. 
    finalPage = 1;
end
end