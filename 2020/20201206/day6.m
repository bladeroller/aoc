%% 2020-12-06 Advent of Code Day 6
% https://adventofcode.com/2020/day/6

answers = fileread('input.txt');

%% part 1
a = regexp(answers, '\n\n', 'split');

num_yes = zeros(size(a));

for i = 1:length(a)
  b = regexprep(a{i}, '\n', '');
  num_yes(i) = length(unique(b));
end

sum(num_yes)


%% part 2
num_intersects = zeros(size(a));

for i = 1:length(a)
  b = regexp(a{i}, '\n', 'split');
  tf = cellfun(@isempty, b);
  b(tf) = [];

  intsct = b{1};
  for j = 2:length(b)
    intsct = intersect(intsct, b{j});
  end
  num_intersects(i) = length(intsct);
end

sum(num_intersects)
