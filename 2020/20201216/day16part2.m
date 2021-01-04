%% 2020-12-16 Advent of Code Day 16
% https://adventofcode.com/2020/day/16
clear
file = 'example2.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
all_valid_vals = [];
% for i = 1:3
for i = 1:20
  a = regexp(txt.rawcell{i}, ':', 'split');
  a{1} = regexprep(a{1}, '\s', '_');
  vals = regexp(a{2}, '\s', 'split');
  vals = vals([2, 4]);
  vals = regexprep(vals, '-', ':');
  vals = union(eval(vals{1}), eval(vals{2}));
  
  all_valid_vals = [all_valid_vals, vals];
  rules.(a{1}).vals = vals;
end

%% get all the valid tickets
is_valid = false(size(txt.rawcell));
all_invalid = [];
% for i = 9:11
for i = 26:263
  ticket_vals = eval(['[', txt.rawcell{i}, ']']);
  invalid = setdiff(ticket_vals, all_valid_vals);
  if isempty(invalid)
    is_valid(i) = true;
  end
  all_invalid = [all_invalid, invalid];
end

valid_tickets = txt.rawcell(is_valid)

% convert to numeric array
tix = cellfun(@str2num, valid_tickets, 'UniformOutput', false);
tix = vertcat(tix{:})

% get all of the ticket field name
fields = fieldnames(rules);

% make a big true/false table
% the rows represent each ticket
% the cols represent the ticket field names
tf = false(size(tix, 2), length(fields));

% determine whether a given column of actual ticket numbers is valid for
% each ticket field.
for col = 1:size(tix, 2)
  for j = 1:length(fields)
    sd = setdiff(tix(:,col), rules.(fields{j}).vals);
    if isempty(sd)
      tf(j, col) = true;
    end
  end
end

%% go through the true/false table
% process of elimination
while any(any(tf))
  sums = sum(tf)
  c = find(sums == 1)
  r = find(tf(:,c))
  
  rules.(fields{r}).col = c
  
  % eliminate the field from all the other columns
  tf(r, :) = false
end

%% my ticket
my_ticket = str2num(txt.rawcell{23});

%% six fields that start with departure
col_departures = nan(1,6);
for f = 1:6
  col_departures(f) = rules.(fields{f}).col;
end

%% results
answer = prod(my_ticket(col_departures))
fprintf('%d\n', answer)
commandwindow
clipboard('copy', answer)
save day16part2 answer
