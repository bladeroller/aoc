%% https://adventofcode.com/2015/day/23
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
instructions = regexprep(txt.noblanks, ',', '');
a = uint64(0);
b = uint64(0);

[~, b] = do(a, b, instructions);
part1 = b;

%% part 2
a = uint64(1);
b = uint64(0);
[~, b] = do(a, b, instructions);
part2 = b;

%% output
answer(part1)
answer(part2)


%% functions
function [a, b] = do(a, b, instructions)
  inst = 1;
  while inst <= size(instructions, 1)
    parts = regexp(instructions{inst}, '\s', 'split');
    switch parts{1}
      case 'hlf'
        eval([parts{2} '=' parts{2} '/ 2;']);
      case 'tpl'
        eval([parts{2} '=' parts{2} '* 3;']);
      case 'inc'
        eval([parts{2} '=' parts{2} '+ 1;']);
      case 'jmp'
        inst = inst + str2double(parts{2});
        continue
      case 'jie'
        if eval(['mod(' parts{2} ', 2) == 0'])
          inst = inst + str2double(parts{3});
          continue
        end
      case 'jio'
        if eval([parts{2} ' == 1'])
          inst = inst + str2double(parts{3});
          continue
        end
    end
    inst = inst + 1;
  end
end
