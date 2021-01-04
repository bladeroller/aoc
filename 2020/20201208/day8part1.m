%% 2020-12-08 Advent of Code Day 8
% https://adventofcode.com/2020/day/8
commandwindow

%% inhale the file
% file = 'example.txt';
file = 'input.txt';
t = readtable(file, 'ReadVariableNames',false);
t.Properties.VariableNames = {'operations', 'arguments'};


%% part 1
accum = 0;
row = 1;
t.num_runs = zeros(size(t.operations));

while t.num_runs(row) < 2
  switch t.operations{row}
    case 'acc'
      accum = accum + t.arguments(row);
      row = row + 1;
    case 'jmp'
      row = row + t.arguments(row);
    case 'nop'
      row = row + 1;
  end
  t.num_runs(row) = t.num_runs(row) + 1;
end
