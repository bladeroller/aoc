%% https://adventofcode.com/2015/day/24
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% example
weights = [1:5, 7:11]';
weight = sum(weights) / 3;

qe = calc_qe(weights, weight)

%% part 1
weights = txt.nums;
weight = sum(weights) / 3;

part1 = calc_qe(weights, weight);
answer(part1)

%% part 2
weight2 = sum(weights) / 4;

part2 = calc_qe(weights, weight2);
answer(part2)


%% functions
function qe = calc_qe(nums, weight)
  for k = 2:length(nums)-2
    fprintf(2, 'k = %d\n', k);
    a = nchoosek(nums, k);
    tf = (sum(a,2) == weight);
    if any(tf)
      qe = min( prod(a(tf,:), 2) );
      break
    end
  end
end
