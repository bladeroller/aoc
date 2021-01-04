%% 2020-12-03 Advent of Code Day 3
% % % commandwindow

%% inhale the file method 1
% % % txt = fileread('example.txt');
% % % txt = fileread('input.txt');
% % % txt = regexp(txt, '\n', 'split')';

% convert from cell array to character array but ignore the last element,
% which is empty
% % % tf = cellfun(@isempty, txt);
% % % txt(tf) = [];
% % % map = vertcat(txt{:});


%% inhale the file method 2
% tbl = readtable('example.txt', 'ReadVariableNames', false);
tbl = readtable('input.txt', 'ReadVariableNames', false);

% convert to character array and get rid of newlines
map = vertcat(tbl.Var1{:});


%% part 1
[num_rows, num_cols] = size(map);

% build a master list of subscripts to use for extraction
% [1, 1] and [2, 4], then [3, 7] and so on, based on the slope.
slope = [1, 3];
ij = repmat([1,1], num_rows, 1) + repmat(slope, num_rows, 1) .* (0:num_rows-1)';

% expand the map out to the necessary width
num_copies = ceil( ij(end,2) / num_cols );

map = repmat(map, 1, num_copies);

% convert the subscripts to linear indices based on the full map
inds = sub2ind(size(map), ij(:,1), ij(:,2));

% extract the locations of interest, compare to '#' and sum!
sum(map(inds) == '#')


