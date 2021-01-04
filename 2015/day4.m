%% https://adventofcode.com/2015/day/4
key = 'abcdef';
% key = 'pqrstuv';
key = 'yzbqklnj';  % your input

%% part 1 or 2
% Create hash using Java Security Message Digest Object
md = java.security.MessageDigest.getInstance('MD5');

icheck = 500e3:500e3:10e6;
tic
for i = 1:10e6
  k = [key, sprintf('%d', i)];
  k = uint8(k);

  % the .digest method will return signed integers (int8) as a column matrix
  h = md.digest(k);

  if all(h(1:2) == 0) && h(3) > -1 && h(3) < 16  % part 1 0x00000
% % %   if all(h(1:3) == 0) % part 2 0x000000
    part1 = i;
    break
  end
  
  if any(i == icheck)
    fprintf('i = %d finished at %s\n', i, datestr(now))
  end
end
toc

%% output
answer(part1)
