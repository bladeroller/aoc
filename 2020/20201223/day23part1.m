%% 2020-12-23 Advent of Code Day 23
% https://adventofcode.com/2020/day/23
% cups = num2digits(389125467);
cups = num2digits(598162734);

for move = 1:100
  destination_cup = cups(1) - 1;
  idx_destination = find(cups == destination_cup);

  if isempty(idx_destination) || any(idx_destination == 2:4)
    while isempty(idx_destination) || any(idx_destination == 2:4)
      destination_cup = destination_cup - 1;
      if destination_cup < min(cups(5:end))
        [destination_cup, idx_destination] = max(cups(5:end));
        idx_destination = idx_destination + 4;
      else
        idx_destination = find(cups(5:end) == destination_cup);
        idx_destination = idx_destination + 4;
      end
    end
  end
  cups = cups([1, 5:idx_destination-1, idx_destination, 2:4, idx_destination+1:num_cups]);
  cups = circshift(cups, -1);
end

%% results
idx1 = find(cups == 1)
answer = circshift(cups, -(idx1-1))
fprintf('%d', answer(2:end));
fprintf('\n')
