%% https://adventofcode.com/2015/day/15
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
c = table2cell(txt.rawtbl(:, 1:end-1));
c = regexprep(c, ',', '');

properties = [str2double(c(:, 3:2:end)), txt.rawtbl.Var11];
num_props = size(properties, 2);

%% make a big list of teaspoon proportions
num_ingredients = size(txt.rawtbl, 1);
teaspoons = zeros(num_ingredients, 1e5);
num = 1;

for i = 0:100
  for j = 0:100 - i
    for k = 0:100 - i - j
      h = 100 - i - j - k;
      teaspoons(:, num) = [i; j; k; h];
      num = num + 1;
    end
  end
end

%% calculate the scores
props = zeros(size(teaspoons, 2), num_props);  % weighted properties

for i = 1:size(teaspoons, 2)
  p = repmat(teaspoons(:,i), 1, num_props) .* properties;
  props(i, :) = sum(p, 1);
end

props(props < 0) = 0;

scores = prod(props(:, 1:4), 2);  % ignoring calories

part1 = max(scores);

%% part2
props2 = props(props(:,5) == 500, :);

scores2 = prod(props2(:, 1:4), 2);

part2 = max(scores2);

%% output
answer(part1)
answer(part2)
