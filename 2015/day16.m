%% https://adventofcode.com/2015/day/16
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1 and 2
tape = read_lines('ticker_tape.txt');
tape.rawtbl.Properties.VariableNames = {'compounds', 'amounts'};
tape.rawtbl.compounds = regexprep(tape.rawtbl.compounds, ':', '');
map = containers.Map(tape.rawtbl.compounds, tape.rawtbl.amounts);

lines = regexprep(txt.noblanks, '^Sue \d{1,3}: ', '');
tf1 = false(500, 3);
tf2 = tf1;

for i = 1:length(lines)
  a = regexp(lines{i}, ', ', 'split');
  for j = 1:length(a)
    b = regexp(a{j}, ': ', 'split');
    cmpnd = b{1};
    num = str2double(b{2});

    % part 1
    if str2double(num) == map(cmpnd)
      tf1(i, j) = true;
    end
    
    % part 2
    switch cmpnd
      case {'cats', 'trees'}
        if num > map(cmpnd),  tf2(i, j) = true;  end
      case {'pomeranians', 'goldfish'}
        if num < map(cmpnd),  tf2(i, j) = true;  end
      otherwise
        if num == map(cmpnd), tf2(i, j) = true;  end
    end
  end
end

part1 = find(all(tf1, 2));
part2 = find(all(tf2, 2));

answer(part1)
answer(part2)
