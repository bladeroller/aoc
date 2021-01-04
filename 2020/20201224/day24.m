%% 2020-12-24 Advent of Code Day 24
% https://adventofcode.com/2020/day/24
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
tiles = zeros(length(txt.noblanks), 2);
for i = 1:length(txt.noblanks)
  x = 0;  y = 0;  str = txt.noblanks{i};
  while str
    switch str(1)
      case 'e',  x = x + 1;  str(1) = [];
      case 'w',  x = x - 1;  str(1) = [];
      otherwise
        switch str(1:2)
          case 'ne',  x = x + .5; y = y + 1; str(1:2) = [];
          case 'se',  x = x + .5; y = y - 1; str(1:2) = [];
          case 'sw',  x = x - .5; y = y - 1; str(1:2) = [];
          case 'nw',  x = x - .5; y = y + 1; str(1:2) = [];
          otherwise, pi
        end
    end
  end
  tiles(i, :) = [x, y];
end

[tiles_that_flipped, num_flips] = histrows(tiles);
is_black_part1 = (mod(num_flips, 2) == 1);

%% results
answer1 = sum(is_black_part1)


%% part 2 make a big grid
xvals = -75: .5 : 75;
yvals = -75:  1 : 75;
grid = zeros(length(xvals) * length(yvals), 2);
i = 1;
for x = xvals
  for y = yvals
    grid(i,:) = [x, y];
    i = i + 1;
  end
end

%% define a TF vector
is_black_part2 = true(size(grid,1), 1);
[~, idx] = setdiff(grid, tiles_that_flipped(is_black_part1,:), 'rows');
is_black_part2(idx) = false;

%% tiles for DAYS
answers2 = zeros(100, 1);
for day = 1:100
  [local_grid, local_is_black] = small_grid(grid, is_black_part2);
  local_is_black_copy = local_is_black;

  for i = 1:size(local_grid, 1)
    tf = is_neighbor(local_grid, local_grid(i,:));
    num_black = sum(local_is_black_copy(tf));
    if local_is_black_copy(i)
      if num_black == 0 || num_black > 2
        local_is_black(i) = false;
      end
    else
      if num_black == 2
        local_is_black(i) = true;
      end
    end
  end
  tb = local_grid(local_is_black, :);
  is_black_part2(:) = false;
  tf = ismember(grid, tb, 'rows');
  is_black_part2(tf) = true;
  answers2(day) = sum(local_is_black);
  fprintf('day %d: %d finished at %s\n', day, answers2(day), datestr(now))
end


%% functions
function [U, counts] = histrows(A)
  % Unique Values By Row, Retaining Original Order
  [U, ~, ic] = unique(A, 'rows', 'stable');

  counts = accumarray(ic, 1); % Count Occurrences
end

function [g2, b2] = small_grid(g, b)
  tblack = g(b, :);
  xy_max = max(tblack);
  xy_min = min(tblack);
  tf1 = (g(:,1) <= xy_max(1)+1 & g(:,1) >= xy_min(1)-1);
  tf2 = (g(:,2) <= xy_max(2)+1 & g(:,2) >= xy_min(2)-1);
  tf = tf1 & tf2;
  
  g2 = g(tf, :);
  b2 = b(tf);
end

function tf = is_neighbor(grid, xy)
  dx = abs(grid(:,1) - xy(1));
  dy = abs(grid(:,2) - xy(2));
  tf1 = (dx == .5 & dy == 1);
  tf2 = (dx ==  1 & dy <= 0);
  tf = tf1 | tf2;
end
