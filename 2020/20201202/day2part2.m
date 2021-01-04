%% 2020-12-02 Advent of Code Day 2
file = 'gistfile1.txt';
file = 'input.txt';

t = readtable(file, 'ReadVariableNames',false);
t.Properties.VariableNames = {'positions', 'letter', 'pword'};

t.is_valid = false(size(t, 1), 1);

tic
for i = 1:size(t, 1)
% for i = 2
  positions = str2double( regexp(t.positions{i}, '-', 'split') );
  letter = t.letter{i}(1);
  is_pos1 = t.pword{i}(positions(1)) == letter;
  is_pos2 = t.pword{i}(positions(2)) == letter;
  t.is_valid(i) = xor(is_pos1, is_pos2);
end
toc

sum(t.is_valid)
