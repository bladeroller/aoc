%% 2020-12-20 Advent of Code Day 20
% https://adventofcode.com/2020/day/20
%% 2020-12-19 Advent of Code Day 19
% https://adventofcode.com/2020/day/19
clear
clc
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);
txt.rawchar = regexprep(txt.rawchar, '\n$', '');
% txt.rawtbl.Properties.VariableNames = {'operations', 'arguments'};

%% part 1
sections = regexp(txt.rawchar, '\n\n', 'split');

tiles = struct();
for i = 1:length(sections)
  tiles(i).raw = regexp(sections{i}, '\n', 'split')';
  tiles(i).id  = str2double(regexp(tiles(i).raw{1}, '(\d+)', 'tokens', 'once'));
  tiles(i).dat = (vertcat(tiles(i).raw{2:end}));
  tiles(i).edges = [tiles(i).dat(1,:); tiles(i).dat(end,:)
                    tiles(i).dat(:,1)'; tiles(i).dat(:,end)'];
  tiles(i).names = ('TBLR')';
  tiles(i).nums  = repmat(num2str(i, '%03d'), 4, 1);
  tiles(i).tags  =  [tiles(i).nums, tiles(i).names, ('nnnn')'];
end
%%
edges = vertcat(tiles.edges);
[sorted_edges, idx_sort] =  sortrows(edges);

sorted_names = vertcat(tiles.names);
sorted_names = sorted_names(idx_sort);
sorted_nums = vertcat(tiles.nums);
sorted_nums = sorted_nums(idx_sort, :);
sorted_tags = vertcat(tiles.tags);
sorted_tags = sorted_tags(idx_sort, :);

diffs = diff(sorted_edges, 1);
idx_diffs = find(all(diffs == 0, 2));

% % % matches = cell(length(idx_diffs), 4);
% % % for i = 1:length(idx_diffs)
% % %   matches(i, :) = {sorted_nums(idx_diffs(i), :), sorted_names(idx_diffs(i)), ...
% % %     sorted_nums(idx_diffs(i)+1, :), sorted_names(idx_diffs(i)+1)};
% % % end

matches = cell(length(idx_diffs), 2);
for i = 1:length(idx_diffs)
  matches(i, :) = {sorted_tags(idx_diffs(i),:), sorted_tags(idx_diffs(i)+1,:)};
end


tags = vertcat(tiles.tags);

while ~isempty(edges)
% for i = 1:length(tiles)*4
% % % edges = vertcat(tiles.edges);
edges(1,:) = fliplr(edges(1,:));
[sorted_edges, idx_sort] =  sortrows(edges);

% % % sorted_names = vertcat(tiles.names);
% % % % sorted_names(i) = 'F';
% % % sorted_names = sorted_names(idx_sort);
% % % sorted_nums = vertcat(tiles.nums);
% % % sorted_nums = sorted_nums(idx_sort, :);

% % % sorted_tags = vertcat(tiles.tags);
tags(1,end) = 'f';
sorted_tags = tags(idx_sort, :);

diffs = diff(sorted_edges, 1);
idx_diffs = find(all(diffs == 0, 2));

% % % matches2 = cell(length(idx_diffs), 4);
% % % for i = 1:length(idx_diffs)
% % %   matches2(i, :) = {sorted_nums(idx_diffs(i), :), sorted_names(idx_diffs(i)), ...
% % %     sorted_nums(idx_diffs(i)+1, :), sorted_names(idx_diffs(i)+1)};
% % % end

matches2 = cell(length(idx_diffs), 2);
for j = 1:length(idx_diffs)
% % %   side1 = sorted_tags(idx_diffs(j),:);
% % %   side2 = sorted_tags(idx_diffs(j)+1,:);
% % %   % check for dupe
% % %   if side1(end) == 'f' && side2(end) == 'n'
% % %     check_side1 = [side1(1:end-1), 'n'];
% % %     check_side2 = [side2(1:end-1), 'f'];
% % %     [~, loc1] = ismember(matches(:,1), check_side1);
% % %     [~, loc2] = ismember(matches(:,2), check_side2);
% % %     continue
% % %   end
  matches2(j, :) = {sorted_tags(idx_diffs(j),:), sorted_tags(idx_diffs(j)+1,:)};
end

matches = [matches; matches2];

edges(1,:) = [];
tags(1,:) = [];

end

t = cell2table(matches)
u = unique(t, 'rows')


%% counting
a = [u.matches1; u.matches2]
% a = regexprep(a, '[^\d]', '')
% a = cellfun(@str2double, a)
a = vertcat(a{:})
a = a(:, 1:3)
a = str2num(a)

N = histcounts(a, 'BinMethod', 'integers')

ids = [tiles(find(N==2)).id]


%% results
answer = prod(ids);
fprintf('%d\n', answer)
isequal(answer, 20899048083289)

