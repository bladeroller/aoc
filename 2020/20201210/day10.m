%% 2020-12-10 Advent of Code Day 10
% https://adventofcode.com/2020/day/10
% commandwindow

% file = 'example1.txt';
file = 'example2.txt';
% file = 'input.txt';

%% inhale the file
t = readtable(file, 'ReadVariableNames',false);
t.Properties.VariableNames = {'numbers'};


%% part 1
diffs = diff(sort(t.numbers));

is1 = diffs == 1;
is3 = diffs == 3;

(sum(is1) + 1) * (sum(is3) + 1)


%% part 2
big_is_valid = [];
sorted = sort(t.numbers);

datestr(now)
tic
for i = 2:length(sorted)
% for i = 2:9
  combos = nchoosek(sorted, i);
  combos = [zeros(size(combos,1), 1), combos, repmat(sorted(end)+3, size(combos,1), 1)];
  
  diffs = diff(combos, 1, 2);
  
  is_invalid = diffs(:,1) > 3 | diffs(:,end) > 3;
  diffs(is_invalid, :) = [];

  is_valid = all(diffs >= 1 & diffs <= 3, 2);

  big_is_valid = [big_is_valid; is_valid];
  
  fprintf('i = %d finished at %s\n', i, datestr(now));
end
toc

num_combos = sum(big_is_valid)


save(datestr(now, 'yyyymmddHHMMSS'))

