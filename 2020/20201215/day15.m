%% 2020-12-15 Advent of Code Day 15
% https://adventofcode.com/2020/day/15
clear

%% part 1 and 2
clc
diary on
datestr(now)

% start_nums = [0 3 6]';
% start_nums = [1 3 2]';
% start_nums = [2 1 3]';
% start_nums = [1 2 3]';
% start_nums = [2 3 1]';
% start_nums = [3 2 1]';
% start_nums = [3 1 2]';
start_nums = [17,1,3,16,19,0]';

stats = [];
final = 30000000;
number_spoken = nan(final, 1);
for i = 1:length(start_nums)
  key = sprintf('a%d', start_nums(i));
  stats.(key).turn  = i;
  number_spoken(i) = start_nums(i);
end

timer = tic;
for i = length(start_nums)+1 : final
  last_num = number_spoken(i-1);
  last_key = sprintf('a%d', last_num);
  if isfield(stats, last_key)
    % then we've spoken the number before
    if length(stats.(last_key).turn) >= 2
      % then we've spoken the number at least twice
      number_spoken(i) = stats.(last_key).turn(end) - stats.(last_key).turn(end-1); % age
      new_key = sprintf('a%d', number_spoken(i));
      if isfield(stats, new_key)
        stats.(new_key).turn(end+1) = i;
      else
        stats.(new_key).turn = i;
      end
    else
      number_spoken(i) = 0;
      if isfield(stats, 'a0')
        stats.a0.turn(end+1) = i;
      else
        stats.a0.turn = i;
      end
    end
  else
    number_spoken(i) = 0;
    stats.a0.turn(end+1) = i;
  end
  if ismember(i, 1e6:1e6:30e6)
    fprintf('%d finished at %s\n', i, datestr(now));
  end
end
toc(timer)

%% results
answer = number_spoken(end)
commandwindow
clipboard('copy', answer)
save day15 answer
diary off
