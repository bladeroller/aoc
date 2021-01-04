%% https://adventofcode.com/2015/day/5
file = 'example.txt';
file = 'example2.txt';
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
tf1 = check_3vowels(txt.noblanks);
tf2 = check_2x(txt.noblanks);
tf3 = check_strings(txt.noblanks);

part1 = sum(tf1 & tf2 & tf3);

%% part 2
tf4 = check_pair_repeats(txt.noblanks);
tf5 = check_repeat(txt.noblanks);

part2 = sum(tf4 & tf5);

%% output
answer(part1)
answer(part2)


%% functions
function tf = check_3vowels(mycell)
  idx = regexp(mycell, '[aeiou]');
  tf = cellfun(@length, idx) >= 3;
end

function tf = check_2x(mycell)
  tf = false(size(mycell));
  for i = 1:length(tf)
    tf(i) = any(diff(mycell{i}) == 0);
  end
end

function tf = check_strings(mycell)
  idx = regexp(mycell, 'ab|cd|pq|xy');
  tf = ~cellfun(@any, idx);
end

function tf = check_pair_repeats(mycell)
  idx = regexp(mycell, '(\w\w).*\1');
  tf = cellfun(@any, idx);
end

function tf = check_repeat(mycell)
  idx = regexp(mycell, '(\w)\w{1}\1');
  tf = cellfun(@any, idx);
end
