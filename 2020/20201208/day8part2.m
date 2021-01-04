%% 2020-12-08 Advent of Code Day 8
% https://adventofcode.com/2020/day/8

commandwindow

%% inhale the file method
% t = readtable('example.txt', 'ReadVariableNames',false);
t = readtable('input.txt', 'ReadVariableNames',false);
t.Properties.VariableNames = {'operations', 'arguments'};


%% part 2
% find all the nop and jmp operations
tf = ismember(t.operations, {'nop', 'jmp'});
idx_nop_jmp = find(tf);

% create a vector to store all the rows when the while loop ends
end_rows = zeros(size(idx_nop_jmp));


%% outer loop changing each of the nop and jmp
for i = 1:length(idx_nop_jmp)
  operations = t.operations;
  
  % toggle the operation
  operations(idx_nop_jmp(i)) = setdiff({'nop', 'jmp'}, operations{idx_nop_jmp(i)});
  
  accum = 0;
  row = 1;
  t.num_runs = zeros(size(t.operations));

  while t.num_runs(row) < 2
    switch operations{row}
      case 'acc'
        accum = accum + t.arguments(row);
        row = row + 1;
      case 'jmp'
        row = row + t.arguments(row);
      case 'nop'
        row = row + 1;
    end
    if row <= length(t.num_runs)
      t.num_runs(row) = t.num_runs(row) + 1;
    else
      end_rows(i) = row;
      break
    end
  end
  end_rows(i) = row;
end


%% change the operation
idx_row_to_change = find(end_rows > length(t.operations));

t.operations(idx_nop_jmp(idx_row_to_change)) = setdiff({'nop', 'jmp'}, t.operations{idx_nop_jmp(i)});
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
  end
