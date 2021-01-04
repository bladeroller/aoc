%% 2020-12-14 Advent of Code Day 14
% https://adventofcode.com/2020/day/14
clear
file = 'example.txt';
% file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
value = 0;
memory = [];
tic
for i = 1:length(txt.noblanks)
  a = txt.noblanks{i};
  if isequal(a(1:2), 'ma')
    mask = a(8:end);
  elseif isequal(a(1:2), 'me')
    address = regexp(a, '\[(\d+)\]', 'tokens');
    address = str2double(address{1});
    value = regexp(a, '= (\d+)$', 'tokens');
    value = str2double(value{1});

    tf_setbit = (mask == '1' | mask == '0');
    bits = dec2bin(value, 36);
    bits(tf_setbit) = mask(tf_setbit);
    result = bin2dec(bits);
    
    memory(address) = result;
  else, pi
  end
  
end
toc

%% results
answer = sum(memory);
fprintf('%d\n', answer)
