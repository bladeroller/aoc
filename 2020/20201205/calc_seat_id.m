%% 2020-12-04 Advent of Code Day 5

function seat_id = calc_seat_id(boarding_pass)

% define the total number of seat rows and columns
seat_rows = 0:127;
seat_cols = 0:7;

% calculate the seat row
seat_row = seat_rows;
for i = 1:7
  ind = which_half(boarding_pass(i), seat_row);
  seat_row = seat_row(ind);
end

% calculate seat col
seat_col = seat_cols;
for i = 8:10
  ind = which_half(boarding_pass(i), seat_col);
  seat_col = seat_col(ind);
end

seat_id = seat_row * 8 + seat_col;
