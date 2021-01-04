%% 2020-12-17 Advent of Code Day 17
% https://adventofcode.com/2020/day/17
% file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

% convert . and # to 0 and 1 because ASCII is stupid. also we can do easy math later
initial = regexprep(txt.rawcell, '\.', '0');
initial = regexprep(initial, '#', '1');

initial = cell2mat(initial);
initial = mat2cell(initial, ones(size(txt.chars, 1),1), ones(size(txt.chars, 2),1));
initial = str2double(initial);

[num_initial_rows, num_initial_cols] = size(initial);

%% part 1
num_cycles = 6;

% initialize THE BORG MATRIX
  nrows = num_initial_rows + num_cycles*2;
  ncols = num_initial_cols + num_cycles*2;
  nslices = num_cycles*2+1;
  n4d = num_cycles*2+1;
matrix = zeros(nrows, ncols, nslices, n4d);

% set the initial state
matrix(num_cycles+1:num_cycles + num_initial_rows, ...
  num_cycles+1:num_cycles+num_initial_cols, ...
  num_cycles + 1, num_cycles + 1) = initial;

% loop, loop, loop, loop, loop
for n = 1:num_cycles
  snapshot = matrix;
  for w = 1:n4d
    w_to_check = w-1:w+1;
    w_to_check(w_to_check < 1 | w_to_check > size(snapshot,4)) = [];
    if all(all(all(all( snapshot(:,:,:, w_to_check) == 0 ))))
      continue  % skip this chunk to save time
    end
    for z = 1:nslices
      z_to_check = z-1:z+1;
      z_to_check(z_to_check < 1 | z_to_check > size(snapshot,3)) = [];
      if all(all(all( snapshot(:,:,z_to_check, w_to_check) == 0 )))
        continue  % skip this slice to save time
      end
      
      for r = 1:nrows
        for c = 1:ncols
          cube = snapshot(r, c, z, w);
          snapshot(r, c, z, w) = 255;  % mark the original cube
          
          row_to_check = r-1:r+1;
          row_to_check(row_to_check < 1 | row_to_check > size(snapshot,1)) = [];
          col_to_check = c-1:c+1;
          col_to_check(col_to_check < 1 | col_to_check > size(snapshot,2)) = [];
          
          neighbors = snapshot(row_to_check, col_to_check, z_to_check, w_to_check);
          
          num_active_neighbors = sum(sum(sum(sum( neighbors == 1 ))));
          if cube == 1
            if num_active_neighbors == 2 || num_active_neighbors == 3
              matrix(r, c, z, w) = 1;
            else
              matrix(r, c, z, w) = 0;
            end
          else
            if num_active_neighbors == 3,  matrix(r, c, z, w) = 1;
            else                        ,  matrix(r, c, z, w) = 0;
            end
          end
          snapshot(r, c, z, w) = cube;  % reset the origial cube
        end
      end
    end
  end
  fprintf('%d finished at %s\n', n, datestr(now));
end

%% results
answer = sum(sum(sum(sum( matrix ))))
