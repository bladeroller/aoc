%% 2020-12-11 Advent of Code Day 11
% https://adventofcode.com/2020/day/11
% commandwindow

% file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = fileread(file);
txt = regexp(txt, '\n', 'split')';

% convert from cell array to character array but ignore the last element,
% which is empty
tf = cellfun(@isempty, txt);
txt(tf) = [];
layout = vertcat(txt{:});

%% loop until death
num_occupied = nan(1000,1);
num_occupied(1) = sum(sum(layout == '#'));

for i = 2:length(num_occupied)
  layout = update_layout(layout);
  num_occupied(i) = sum(sum(layout == '#'));
  if num_occupied(i) == num_occupied(i-1)
    break
  end
end


%% change the seats based on the rules
function new_layout = update_layout(old_layout)
new_layout = old_layout;

num_rows = size(old_layout, 1);
num_cols = size(old_layout, 2);

for row = 1:num_rows
  for col = 1:num_cols
    ij_adjacent = adjacent([row, col]);
    
    % remove any outside the layout
    is_out = ij_adjacent(:,1) < 1 | ij_adjacent(:,1) > num_rows ...
           | ij_adjacent(:,2) < 1 | ij_adjacent(:,2) > num_cols;
    ij_adjacent(is_out, :) = [];

    idx = sub2ind(size(old_layout), ij_adjacent(:,1), ij_adjacent(:,2));
    switch old_layout(row, col)
      case 'L'
        if all(old_layout(idx) == '.' | old_layout(idx) == 'L')
          new_layout(row, col) = '#';
        end
      case '#'
        if sum(old_layout(idx) == '#') >= 4
          new_layout(row, col) = 'L';
        end
    end
    
  end
end

end


%% create indices for adjacent seats
function ija = adjacent(ij)
  row = ij(1);
  col = ij(2);
  ija = [row-1, col-1
         row-1, col
         row-1, col+1
         row, col-1
         row, col+1
         row+1, col-1
         row+1, col
         row+1, col+1];
end
