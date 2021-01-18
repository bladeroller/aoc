%% https://adventofcode.com/2015/day/18
file = 'input.txt';
txt = read_lines(file);  % inhale the file

% part 2 rules:
txt.chars(1,1) = '#';
txt.chars(1,end) = '#';
txt.chars(end,1) = '#';
txt.chars(end,end) = '#';

%% part 1 or 2
[nrows, ncols] = size(txt.chars);

% make a grid with extra top, bottom and sides
grid = repmat('.', nrows + 2, ncols + 2);
grid(2:nrows+1, 2:nrows+1) = txt.chars;

new_grid = grid;
for step = 1:100
  current = new_grid;
  for r = 2:nrows+1
    for c = 2:ncols+1
      % part 2:
      if (r == 2 && c == 2) ...
          || (r == 2 && c == ncols +1) ...
          || (r == nrows + 1 && c == 2) ...
          || (r == nrows + 1 && c == ncols + 1)
        continue
      end
      
      n = get_neighbors(current, r, c);

      num_on = sum(n == '#');
      switch current(r, c)
        case '.'
          if num_on == 3, new_grid(r, c) = '#';  end
        case '#'
          if num_on ~= 2 && num_on ~= 3, new_grid(r, c) = '.';  end
      end
    end
  end
end

part1 = sum(sum(new_grid == '#'));

%% output
answer(part1)


%% functions
function n = get_neighbors(a, r, c)
 n = a(r-1:r+1, c-1:c+1);
 n = n([1:4, 6:end]);
end
