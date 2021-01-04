%% 2020-12-02 Advent of Code Day 2
file = 'gistfile1.txt';
file = 'input.txt';

t = readtable(file, 'ReadVariableNames',false);

t.is_valid = false(size(t, 1), 1);

tic
for i = 1:size(t, 1)
% for i = 1
  min_max = str2double( regexp(t.Var1{i}, '-', 'split') );
  letter = t.Var2{i}(1);
  num_matches = sum(t.Var3{i} == letter);
  t.is_valid(i) = (num_matches >= min_max(1)) && (num_matches <= min_max(end));
end
toc

sum(t.is_valid)
