%% https://adventofcode.com/2015/day/9
file = 'input.txt';
txt = read_lines(file);  % inhale the file
txt.rawtbl.Properties.VariableNames = {'loc1', 'to', 'loc2', 'equal', 'distance'};

%% part 1 and 2
distances = table2cell(txt.rawtbl(:, [1,3,5]));
distances = [distances; distances(:, [2,1,3])];

routes = table2cell(txt.rawtbl(:, [1,3]));
routes = unique(routes(:));
routes = perms(routes);

leg_lengths = zeros(size(routes));

for i = 1:size(routes, 1)
  for j = 1:size(routes, 2)-1
    tf1 = ismember(distances(:,1), routes(i,j));
    tf2 = ismember(distances(:,2), routes(i,j+1));
    leg_lengths(i, j) = distances{tf1 & tf2, 3};
  end
end

total_lengths = sum(leg_lengths, 2);

part1 = min(total_lengths);
part2 = max(total_lengths);

%% output
answer(part1)
answer(part2)
