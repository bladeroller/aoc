%% https://adventofcode.com/2015/day/1
begin
file = 'example.txt';
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
f = 0;
for i = 1:length(txt.rawchar)
  switch txt.rawchar(i)
    case '(',  f = f + 1;
    case ')',  f = f - 1;
  end
  
  % part 2:
%   if f == -1
%     pos = i;
%     break
%   end
end

a1 = f;
a2 = pos;

%% output
answer(a1)
answer(a2)


return

%% alt
tic
a = num2cell(txt.rawchar);
a = regexprep(a, '(', '1');
a = regexprep(a, ')', '-1');
a = str2double(a);
sum(a)
toc
