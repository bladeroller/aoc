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

tic
for i = 2:length(num_occupied)
  layout = update_layout(layout);
  num_occupied(i) = sum(sum(layout == '#'));
  if num_occupied(i) == num_occupied(i-1)
    break
  end
end
toc

num_occupied(i) 


%% change the seats based on the rules
function new_layout = update_layout(old_layout)
new_layout = old_layout;

num_rows = size(old_layout, 1);
num_cols = size(old_layout, 2);

for row = 1:num_rows
  for col = 1:num_cols
    current_seat = old_layout(row, col);
    
    old_layout(row, col) = 'x';  % mark the spot

    % slice the array but remove any indices outside the layout
    rows_adjacent = row-1:row+1;
    rows_adjacent(rows_adjacent < 1 | rows_adjacent > num_rows) = [];

    cols_adjacent = col-1:col+1;
    cols_adjacent(cols_adjacent < 1 | cols_adjacent > num_rows) = [];
    
    % get the adjacent seats
    adjacent_seats = old_layout(rows_adjacent, cols_adjacent);
    adjacent_seats = adjacent_seats(:);
    adjacent_seats(adjacent_seats == 'x') = [];

    switch current_seat
      case 'L'
        if all(adjacent_seats == '.' | adjacent_seats == 'L')
          new_layout(row, col) = '#';
        end
      case '#'
        if sum(adjacent_seats == '#') >= 4
          new_layout(row, col) = 'L';
        end
    end
    
    old_layout(row, col) = current_seat;  % unmark the spot
  end
end

end
