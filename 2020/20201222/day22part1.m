%% 2020-12-22 Advent of Code Day 22
% https://adventofcode.com/2020/day/22
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
idx_player2 = regexp(txt.noblanks, 'Player 2');
idx_player2 = find(~cellfun(@isempty, idx_player2));

player1 = str2double(txt.noblanks(2:idx_player2-1));
player2 = str2double(txt.noblanks(idx_player2+1:end));

while ~isempty(player1) && ~isempty(player2)
  if player1(1) > player2(1)
    player1 = [player1(2:end); player1(1); player2(1)];
    player2 = player2(2:end);
  else
    player2 = [player2(2:end); player2(1); player1(1)];
    player1 = player1(2:end);
  end
end
  

%% results
answer = sum(player2 .* flipud((1:length(player2))'))

