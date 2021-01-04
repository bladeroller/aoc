%% 2020-12-05 Advent of Code Day 5

boarding_passes = {
  'BFFFBBFRRR'
  'FFFBBBFRRR'
  'BBFFBBFRLL'
  };

boarding_passes = regexprep(boarding_passes, '[FL]', '0');
boarding_passes = regexprep(boarding_passes, '[BR]', '1');
boarding_passes = cell2mat(boarding_passes);

seat_id = bin2dec(boarding_passes(:, 1:7)) * 8 + bin2dec(boarding_passes(:, 8:10));
