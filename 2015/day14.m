%% https://adventofcode.com/2015/day/14
file = 'input.txt';
txt = read_lines(file);  % inhale the file
txt.rawtbl.Properties.VariableNames([1,4,7,14]) = {'reindeer', 'speed', 'tfly', 'trest'};

%% part 1
t = 2503;

d = calc_distances(t, txt.rawtbl);

part1 = max(d);

%% part 2
points = zeros(size(txt.rawtbl, 1), t);

for i = 1:t
  d2 = calc_distances(i, txt.rawtbl);
  [~, idx] = max(d2);
  points(idx, i) = 1;
end

total_points = sum(points, 2);

part2 = max(total_points);

%% output
answer(part1)
answer(part2)

%% functions
function d = calc_distances(t, tbl)
  time = tbl.tfly + tbl.trest;

  num_intervals = floor(t ./ time);

  remainder = t - time .* num_intervals;

  tfly_remaining = min([tbl.tfly, remainder], [], 2);

  d = tbl.speed .* (tbl.tfly .* num_intervals + tfly_remaining);
end
