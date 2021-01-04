%% https://adventofcode.com/2015/day/3
begin
file = 'example3.txt';
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
h1 = goto_house(txt.rawchar);
part1 = length(unique(h1, 'rows'));

%% part 2
h2a = goto_house(txt.rawchar(1:2:end));
h2b = goto_house(txt.rawchar(2:2:end));

part2 = length( unique([h2a; h2b], 'rows') );

%% output
answer(part1)
answer(part2)


%% functions
function h = goto_house(nsew)
  h = [nan(length(nsew), 2); [0,0]];
  x = 0;  y = 0;

  for i = 1:length(nsew)
    [x, y] = movexy(x, y, nsew(i));
    h(i,:) = [x, y];
  end
end

function [x, y] = movexy(x,y, str)
  switch str
    case '^', y = y + 1;
    case 'v', y = y - 1;
    case '>', x = x + 1;
    case '<', x = x - 1;
  end
end
