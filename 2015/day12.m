%% https://adventofcode.com/2015/day/12
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
a = regexprep(txt.rawchar, '[^\d,-]', '');
a = regexprep(a, ',,+', ',');
b = regexp(a, ',', 'split');
c = str2double(b);

part1 = sum(c);

%% part 2
% json arrays [...] become cell arrays
% json objects {...} become structure arrays
jsn = jsondecode(txt.rawchar);

part2 = add_cell(jsn);

%% output
answer(part1)
answer(part2)


%% functions
function sm = add_struct(s)
% json objects {...} become structure arrays
% Ignore any object (and all of its children) which has any property with the "red" value.
  sm = 0;
  values = struct2cell(s);
  for i = 1:length(values)
    if isequal(values{i}, 'red')
      return
    end
  end
  sm = add_cell(values);
end

function sm = add_cell(c)
% json arrays [...] become cell arrays
  sm = 0;
  for i = 1:length(c)
    val = c{i};
    if isnumeric(val) % value might be a vector! like [109,57]
      sm = sm + sum(val);
    elseif isstruct(val)
      sm = sm + add_struct(val);
    elseif iscell(val)
      sm = sm + add_cell(val);
    end
  end
end
