%% 2020-12-22 Advent of Code Day 22
% https://adventofcode.com/2020/day/22
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 2
idx_player2 = regexp(txt.noblanks, 'Player 2');
idx_player2 = find(~cellfun(@isempty, idx_player2));

player1 = str2double(txt.noblanks(2:idx_player2-1));
player2 = str2double(txt.noblanks(idx_player2+1:end));

[p1post, p2post] = realgame(uint8(player1), uint8(player2));

%% results
answer = sum(flipud(double(p2post)) .* (1:length(p2post))')

%% functions
function [p1, p2] = realgame(p1, p2)
  h1 = zeros(1000, length(p1) + length(p2), 'uint8');
  h2 = h1;
  round = 1;

  while ~isempty(p1) && ~isempty(p2)
    %if ismember(round, 2000:2000:1e6)
    %fprintf('-- Round %d -- %s\n', round, datestr(now));
    %disp(p1');
    %disp(p2');
    %end
    if any(ismember(h1, [p1', zeros(1, size(h1,2) - length(p1))], 'rows')) ...
        || any(ismember(h2, [p2', zeros(1, size(h2,2) - length(p2))], 'rows'))
      break
    end
    h1(round, 1:length(p1)) = p1';
    h2(round, 1:length(p2)) = p2';
    if p1(1) <= length(p1)-1 && p2(1) <= length(p2)-1
      winner = subgame(p1, p2);
      switch winner
        case 1
          p1 = [p1([2:end, 1]); p2(1)];
          p2 = p2(2:end);
        case 2
          p2 = [p2([2:end, 1]); p1(1)];
          p1 = p1(2:end);
      end
    elseif p1(1) > p2(1)
      p1 = [p1(2:end); p1(1); p2(1)];
      p2 = p2(2:end);
    else
      p2 = [p2(2:end); p2(1); p1(1)];
      p1 = p1(2:end);
    end
    round = round + 1;
  end
end

function winner = subgame(p1, p2)
  % sub-game
  copy1 = p1(2:p1(1)+1);
  copy2 = p2(2:p2(1)+1);
  [p1, ~] = realgame(copy1, copy2);
  if isempty(p1), winner = 2;
  else          , winner = 1;
  end
end
