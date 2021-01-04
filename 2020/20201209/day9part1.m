%% 2020-12-09 Advent of Code Day 9
% https://adventofcode.com/2020/day/9/

commandwindow

%% inhale the file
% t = readtable('example.txt', 'ReadVariableNames',false);
t = readtable('input.txt', 'ReadVariableNames',false);
t.Properties.VariableNames = {'numbers'};


%% do it
preamble = 25;

for i = preamble+1:length(t.numbers)
  previous = t.numbers(i-25:i-1);
  
  sum2 = sum(nchoosek(previous, 2), 2);
  
  if ismember(t.numbers(i), sum2)
    % then it's valid, keep going
  else
    break
  end
end

invalid = t.numbers(i)