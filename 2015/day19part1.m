%% https://adventofcode.com/2015/day/19
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
replacements = regexp(txt.sections{1}, '\n', 'split')';
medicine = txt.sections{2}(1:end-1);

molecules = {};
for i = 1:length(replacements)
  tokens = regexp(replacements{i}, ' => ', 'split');
  idx    = regexp(txt.sections(2), tokens{1});

  for j = 1:length(idx{1})
    molecules{end+1} = regexprep(medicine, tokens{1}, tokens{2}, j);
  end
end

part1 = length(unique(molecules));

%% output
answer(part1)
