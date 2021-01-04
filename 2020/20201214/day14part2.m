%% 2020-12-14 Advent of Code Day 14
% https://adventofcode.com/2020/day/14
clear
% file = 'example2.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
diary on
datestr(now)
clc

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

    % alter the address
    address_bits = dec2bin(address, 36);
    tf_setbit = (mask == '1');
    address_bits(tf_setbit) = mask(tf_setbit);

    tf_setbit = (mask == 'X');
    address_bits(tf_setbit) = 'X';

    % floating
    num_x = sum(tf_setbit);
    number = bin2dec( repmat('1', 1, num_x) );
    changes = dec2bin( (0 : number)' );

    for j = 1:size(changes, 1)
      address_bits(tf_setbit) = changes(j, :);
      new_address = bin2dec(address_bits);
      
      fname = sprintf('a_%d', new_address);
      memory.(fname) = value;
    end
  else, pi;
  end
  
end
toc

%% sum the shit
answer= 0;
fnames = fieldnames(memory);
for i = 1:length(fnames)
  answer = answer + memory.(fnames{i});
end


%% results
fprintf('%d\n', answer)
commandwindow
clipboard('copy', answer)
save day14 answer
diary off
