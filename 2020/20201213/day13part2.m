%% 2020-12-13 Advent of Code Day 13
% https://adventofcode.com/2020/day/13

file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 2
diary on
ids = regexp(txt.noblanks(2), ',', 'split')
ids = ids{1}

is_x = ismember(ids, 'x')

buses = str2double(ids(~is_x))
numbuses = length(buses)

offsets = 0:length(ids)-1
offsets = offsets(~is_x)

bignum = 1e8;
times = (0:(bignum-1))' + 100e12;

tf = false(length(times), numbuses);

idx = [];
tic
while isempty(idx)
  for i = 1:numbuses
    tf(:,i) = (mod(times, buses(i))==0);
    if i>1
      tf(:,i) = circshift(tf(:,i), -offsets(i));
    end
  end
  idx = find(all(tf,2));
  fprintf('%d finished at %s\n', times(end), datestr(now));
  if isempty(idx)
    times = times+bignum;
  end
end
toc

idx(1)

answer = sprintf('%d', times(idx(1)))
clipboard('copy', answer)
commandwindow
diary off
