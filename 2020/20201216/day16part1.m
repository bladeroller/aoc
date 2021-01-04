%% 2020-12-16 Advent of Code Day 16
% https://adventofcode.com/2020/day/16
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
all_valid_vals = [];
for i = 1:20
  a = regexp(txt.rawcell{i}, ':', 'split');

  vals = regexp(a{2}, '\s', 'split');
  vals = vals([2, 4]);
  vals = regexprep(vals, '-', ':');
  vals = union(eval(vals{1}), eval(vals{2}));
  
  all_valid_vals = [all_valid_vals, vals];
end

all_invalid = [];
for i = 26:263
  ticket_vals = eval(['[', txt.rawcell{i}, ']']);
  invalid = setdiff(ticket_vals, all_valid_vals);
  all_invalid = [all_invalid, invalid];
end


%% results
answer = sum(all_invalid)
