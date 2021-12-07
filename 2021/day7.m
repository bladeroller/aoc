%% https://adventofcode.com/2021/day/7
nums = csvread('input.txt');  % inhale the file

%% part 1 and 2
fuels = zeros(max(nums) + 1, 2);  % fuel as a function of position

for pos = 0:max(nums)  % loop through each possible final position
  fuel = abs(nums - pos);
  fuels(pos+1, 1) = sum(fuel);

  for i = 1:length(nums)
    fuels(pos+1, 2) = fuels(pos+1, 2) + sum(1:fuel(i));
  end
end

%% output
part1 = min(fuels(:,1));
part2 = min(fuels(:,2));