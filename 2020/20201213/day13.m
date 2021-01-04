%% 2020-12-13 Advent of Code Day 13
% https://adventofcode.com/2020/day/13
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
earliest = str2double(txt.noblanks{1});
ids = regexp(txt.noblanks(2), ',', 'split');
ids = ids{1};

is_x = ismember(ids, 'x');
ids = ids(~is_x);
ids = str2double(ids);

nearest = nan(size(ids));
big_num = 2e7;
for i = 1:length(ids)
  depart = (0:ids(i):big_num);
  idx = find(depart - earliest >= 0, 1, 'first');
  nearest(i) = depart(idx)
end

[a, b] = min(nearest)

minutes = a - earliest
id = ids(b)

answer = id * minutes
clipboard('copy', answer)
