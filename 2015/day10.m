%% https://adventofcode.com/2015/day/10
%% part 1 or 2
num = [1 1 1 3 1 2 2 1 1 3];  % input

for step = 1:50
  values = num(1);
  counts = 1;
  for j = 2:length(num)
    if num(j) == values(end)
      counts(end) = counts(end) + 1;
    else
      values(end+1) = num(j);
      counts(end+1) = 1;
    end
  end
  num = [counts; values];
  num = num(:)';
end

part1 = length(num);

%% output
answer(part1)
