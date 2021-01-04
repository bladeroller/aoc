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
  fprintf('i = %d finished at %s\n', i, datestr(now));
end
toc

num_occupied(i) 


%% loop like an idiot
% % % clc
% % % layout2 = update_layout(layout)
% % % layout3 = update_layout(layout2)
% % % layout4 = update_layout(layout3)

function new_layout = update_layout(old_layout)
new_layout = old_layout;

num_rows = size(old_layout, 1);
num_cols = size(old_layout, 2);

for row = 1:num_rows
  for col = 1:num_cols
    directions = {'up', 'down', 'left', 'right', ...
      'diag_up_left', 'diag_up_right', 'diag_dn_right', 'diag_dn_left'};
    
    num_seats_empty = 0;
    num_seats_occupied = 0;
    for d = 1:length(directions)
      ij_adjacent = adjacent([row, col], num_rows, num_cols, directions{d});
      if isempty(ij_adjacent)
        % we're at the edge, do nothing
        continue
      end
      idx = sub2ind(size(old_layout), ij_adjacent(:,1), ij_adjacent(:,2));
      
      if is_empty_seat_next(old_layout(idx))
        num_seats_empty = num_seats_empty + 1;
      else
        num_seats_occupied = num_seats_occupied + 1;
      end
    end
      switch old_layout(row, col)
        case 'L'
          if ismember([row, col], [[1, 1]; [1,num_cols]; [num_rows,1]; [num_rows,num_cols]], 'rows')
            % we're at the corner
            if num_seats_empty == 3
              new_layout(row, col) = '#';
            end
          elseif row == 1 || col == 1 || row == num_rows || col == num_cols
            if num_seats_empty == 5
              new_layout(row, col) = '#';
            end
          else
            if num_seats_empty == 8
              new_layout(row, col) = '#';
            end
          end
        case '#'
          if num_seats_occupied >= 5
            new_layout(row, col) = 'L';
          end
      end
  end
end

end


%% look for empty or occupied seat
function tf = is_empty_seat_next(seats)
seats(seats == '.') = [];
  if isempty(seats)
    tf = true;
  else
    switch seats(1)
      case 'L'
        tf = true;
      case '#'
        tf = false;
    end
  end
end


%% define indices for adjacent seats
function ija = adjacent(ij, num_rows, num_cols, direction)
row = ij(1);
col = ij(2);

switch direction
  case 'up'
    rows = (row-1:-1:1)';
    ija = [rows, repmat(col, length(rows), 1)];
    
  case 'down'
    rows = (row+1:num_rows)';
    ija = [rows, repmat(col, length(rows), 1)];
    
  case 'left'
    cols = (col-1:-1:1)';
    ija = [repmat(row, length(cols), 1), cols];
    
  case  'right'
    cols = (col+1:num_cols)';
    ija = [repmat(row, length(cols), 1), cols];
    
  case 'diag_up_left'
    rows = (row-1:-1:1)';
    cols = (col-1:-1:1)';
    len = min([length(rows), length(cols)]);
    rows = rows(1:len);
    cols = cols(1:len);
    ija = [rows, cols];

  case 'diag_up_right'
    rows = (row-1:-1:1)';
    cols = (col+1:num_cols)';
    len = min([length(rows), length(cols)]);
    rows = rows(1:len);
    cols = cols(1:len);
    ija = [rows, cols];

  case 'diag_dn_right'
    rows = (row+1:num_rows)';
    cols = (col+1:num_cols)';
    len = min([length(rows), length(cols)]);
    rows = rows(1:len);
    cols = cols(1:len);
    ija = [rows, cols];

  case 'diag_dn_left'
    rows = (row+1:num_rows)';
    cols = (col-1:-1:1)';
    len = min([length(rows), length(cols)]);
    rows = rows(1:len);
    cols = cols(1:len);
    ija = [rows, cols];
  otherwise
    pi
end
end
