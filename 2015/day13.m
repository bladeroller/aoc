%% https://adventofcode.com/2015/day/13
file = 'input.txt';
txt = read_lines(file);  % inhale the file
txt.rawtbl.Properties.VariableNames = {'name1', 'would', 'gainlose', 'amount', 'happiness', 'units', 'by', 'sitting', 'next', 'to', 'name2'};

%% part 1
txt.rawtbl.name2 = regexprep(txt.rawtbl.name2, '\.', '');
tf = ismember(txt.rawtbl.gainlose, 'lose');
txt.rawtbl.amount(tf) = -txt.rawtbl.amount(tf);

happiness = table2cell(txt.rawtbl(:, {'name1', 'name2', 'amount'}));

names = unique(txt.rawtbl.name1);
seating = perms(names);
seating = [seating, seating(:,1)];  % complete tbe circle

total_happiness1a = calc_happiness(seating, happiness);
total_happiness1b = calc_happiness(fliplr(seating), happiness);

part1 = max(total_happiness1a + total_happiness1b);

answer(part1)

%% part 2
new_pairs = [repmat({'me'}, length(names), 1), names];
new_pairs = [new_pairs; fliplr(new_pairs)];
new_pairs = [new_pairs, repmat({0}, size(new_pairs,1), 1)];

happiness2 = [happiness; new_pairs];

seating2 = ([names; 'me']);
seating2 = perms(seating2);
seating2 = [seating2, seating2(:,1)];  % complete tbe circle

total_happiness2a = calc_happiness(seating2, happiness2);
total_happiness2b = calc_happiness(fliplr(seating2), happiness2);

part2 = max(total_happiness2a + total_happiness2b);

answer(part2)


%% functions
function totals = calc_happiness(seating, happiness)
  each_happiness1 = zeros(size(seating));
  tic
  for i = 1:size(seating, 1)
    for j = 1:size(seating, 2)-1
      tf1 = ismember(happiness(:,1), seating(i,j));
      tf2 = ismember(happiness(:,2), seating(i,j+1));
      each_happiness1(i, j) = happiness{tf1 & tf2, 3};
    end
  end
  toc

  totals = sum(each_happiness1, 2);
end
