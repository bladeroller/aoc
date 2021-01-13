%% https://adventofcode.com/2015/day/17
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1 and 2
num_combos = 0;
min_combos = 0;

for i = 2:9  % no need to choose too many numbers in the combo
  a = nchoosek(txt.nums, i);
  tf = sum(a, 2) == 150;
  num_combos = num_combos + sum(tf);

  if min_combos == 0
    min_combos = num_combos;  % part 2
  end
end

%% output
answer(num_combos)
answer(min_combos)
