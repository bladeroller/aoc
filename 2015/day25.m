%% https://adventofcode.com/2015/day/25
% generate a matrix with the order that codes are filled in (by diagonals)
row = 3010;
col = 3019;

a = ones(row, col);
row_inc = 1;

for r = 2:row
  a(r, 1) = a(r-1, 1) + row_inc;
  row_inc = row_inc + 1;
end
for c = 2:col
  a(:, c) = a(:, c-1) + c + (0:size(a,1)-1)';
end

%% part 1
code_num = a(3010, 3019)
code = 20151125;

for i = 2:code_num
  code = rem(code * 252533, 33554393);
end

part1 = code;
answer(part1)
