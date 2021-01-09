%% https://adventofcode.com/2015/day/7
file = 'input.txt';
txt = read_lines(file);  % inhale the file

% replace the 'if' with iif or else it will always evalute as a logical IF
% (and that statement is true, which causes an infinite loop!!!)
txt.noblanks = regexprep(txt.noblanks, 'if', 'iif');

%% part 1
instructions = parse_instructions(txt);
i1 = gates(instructions);
part1 = a;

%% part 2
clearvars -except a i1 part1 instructions txt
instructions2 = regexprep(instructions, '^b=uint16\(\d+\);', ['b=uint16(', num2str(a), ');']);
clear a
i2 = gates(instructions2);
part2 = a;

%% output
answer(part1)
answer(part2)


%% functions
function eqns = parse_instructions(mycell)
  eqns = cell(mycell.numlines, 1);

  for i = 1:mycell.numlines
    eqns{i} = parse_line(mycell.noblanks{i});
  end

  eqns = sort(eqns);  % makes the while loop much faster!!
end

function eqn = parse_line(str)
  strparts = regexp(str, ' -> ', 'split');
  if regexp(strparts{1}, '^\d+$')  % then the source is just a num
    RHS = ['uint16(', strparts{1}, ')'];
  else
    source_parts = regexp(strparts{1}, '\s', 'split');
    if length(source_parts) == 3
      switch source_parts{2}
        case 'AND',    RHS = ['bitand(', source_parts{1}, ',' source_parts{3} ')'];
        case 'OR' ,    RHS = ['bitor(', source_parts{1}, ',' source_parts{3} ')'];
        case 'LSHIFT', RHS = ['bitshift(', source_parts{1}, ',' source_parts{3} ')'];
        case 'RSHIFT', RHS = ['bitshift(', source_parts{1}, ',-' source_parts{3} ')'];
      end
    elseif length(source_parts) == 2  % NOT
      RHS = ['bitcmp(', source_parts{2} ')'];
    else  % just a single source to wire, such as 'lx -> a'
      RHS = source_parts{1};
    end
  end
  eqn = [strparts{2} '=' RHS ';'];
end

function instructions = gates(instructions)
  while ~isempty(instructions) || ~a_exists
    for iter = 1:length(instructions)
      try
        evalin('base', instructions{iter});
        instructions(iter) = [];
        break  % start over from the beginning of the instructions
      catch
      end
    end
    if evalin('base', 'exist(''a'', ''var'')')
      break % skip any unnecessary instructions!
    end
  end
end
