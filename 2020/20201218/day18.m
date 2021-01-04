%% 2020-12-18 Advent of Code Day 18
% https://adventofcode.com/2020/day/18
% file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1 & 2
% loop
answers = zeros(size(txt.noblanks));
for i = 1:length(answers)
  expr = txt.noblanks{i};
  idx_close = min(regexp(expr, ')'));
  while idx_close
    idx_open = max( regexp(expr(1:idx_close), '(') );
    idx_substr = idx_open+1 : (idx_close-1);
    a = new_math2(expr(idx_open+1 : idx_close-1));
    
    expr = [expr(1:idx_open-1), num2str(a), expr(idx_close+1:end)];
    idx_close = min(regexp(expr, ')'));
  end
  answers(i) = new_math2(expr);
end

%% results
answer = sum(answers)
fprintf('%d\n', answer)

%% functions
function num = new_math(str)  % for part 1
  str = regexp(str, '\s', 'split');
  
  while length(str) >= 3
    num = eval([str{1:3}]);
    str(1:3) = [];
    str = [num2str(num), str];
  end
end

function num = new_math2(str)  % for part 2
  % addition is evaluated BEFORE multiplication
  str = regexp(str, '\s', 'split');
  idx_plus = find(ismember(str, '+'), 1, 'first');
  while idx_plus
    a = eval([str{idx_plus-1:idx_plus+1}]);
    str = [str(1:idx_plus-2), num2str(a), str(idx_plus+2:end)];
    idx_plus = find(ismember(str, '+'), 1, 'first');
  end
  
  while length(str) >= 3
    num = eval([str{1:3}]);
    str(1:3) = [];
    str = [num2str(num), str];
  end
  
  if ~exist('num', 'var'),  num = str2double(str);  end
end
