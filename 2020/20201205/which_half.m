%% 2020-12-05 Advent of Code Day 5

function idx = which_half(ForB, current_range)
  switch ForB
    case {'F', 'L'}
      % take the lower half
      idx = 1:length(current_range) / 2 ;
    case {'B', 'R'}
      % take the upper half
      idx = length(current_range) / 2 + 1: length(current_range);
  end
