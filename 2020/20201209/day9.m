%% 2020-12-09 Advent of Code Day 9
% https://adventofcode.com/2020/day/9/

commandwindow

%% inhale the file
% t = readtable('example.txt', 'ReadVariableNames',false);
t = readtable('input.txt', 'ReadVariableNames',false);
t.Properties.VariableNames = {'numbers'};


%% part 1
preamble = 25;

for i = preamble+1:length(t.numbers)
  previous = t.numbers(i-preamble : i-1);
  
  sum2 = sum(nchoosek(previous, 2), 2);
  
  if ismember(t.numbers(i), sum2)
    % then it's valid, keep going
  else
    break
  end
end

invalid = t.numbers(i)


%% part 2
% remove the invalid number from the list
is_valid = (t.numbers ~= invalid);
contiguous_set = t.numbers(is_valid);

% for i = 2:length(t.numbers)-1
stop = false;
tic
for k = 2:length(contiguous_set)
  for i = 1:length(contiguous_set)-k
    if invalid == sum(contiguous_set(i:i+k-1))
      stop = true;
      break
    end
  end
  if stop, break; end
end
toc

weakness_combo = contiguous_set(i:i+k-1)

weakness = min(weakness_combo) + max(weakness_combo)

