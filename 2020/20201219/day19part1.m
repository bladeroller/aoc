%% 2020-12-19 Advent of Code Day 19
% https://adventofcode.com/2020/day/19
file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);
txt.rawchar = regexprep(txt.rawchar, '\n$', '');

% massage the rules
sections = regexp(txt.rawchar, '\n\n', 'split');
section1 = regexp(sections{1}, '\n', 'split')';
num_rules = size(section1, 1);

section1 = regexp(section1, ': ', 'split', 'once');
section1 = vertcat(section1{:});  % m-by-2

rules = cell(num_rules, 1);
for i = 1:num_rules
  rules{str2double(section1{i,1}) + 1} = section1{i,2};
end
rules = regexprep(rules, '"', '');

%% build the mega pattern
pattern = '{0}';

while regexp(pattern, '\d')
  [digit, idx] = regexp(pattern, '(\d+)', 'tokens', 'tokenExtents', 'once');
  pattern = [pattern(1:idx(1)-1), '{', rules{str2double(digit)+ 1}, '}', pattern(idx(2)+1:end)];
end

pattern = regexprep(pattern, '\s', '');
pattern = regexprep(pattern, '{', '(');
pattern = regexprep(pattern, '}', ')');
pattern = ['^', pattern, '$'];


%% messages
messages = regexp(sections{2}, '\n', 'split')';
startIndex = regexp(messages, pattern);  % look for matches!

%% results
answer = sum(vertcat(startIndex{:}))
