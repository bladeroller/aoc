%% 2020-12-05 Advent of Code Day 5

boarding_passes = {
  'BFFFBBFRRR'
  'FFFBBBFRRR'
  'BBFFBBFRLL'
  };

% initialize results
seat_ids = zeros(size(boarding_passes));

% loop through each boarding pass
for i = 1:length(boarding_passes)
  seat_ids(i) = calc_seat_id(boarding_passes{i});
end

max(seat_ids)
