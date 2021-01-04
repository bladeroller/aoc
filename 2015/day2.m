%% https://adventofcode.com/2015/day/2
begin
file = 'example.txt';
% file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1 and 2
sqft = zeros(size(txt.noblanks));
ribbons = sqft;

for i = 1:length(sqft)
% for i = 1
  a = regexp(txt.noblanks{i}, 'x', 'split');  % LxWxH
  a = str2double(a);
  areas = prod(nchoosek(a, 2), 2);
  sqft(i) = 2 * sum(areas) + min(areas);
  
  b = sort(a);
  perim = sum(b(1:2)) * 2;
  vol = prod(a);
  
  ribbons(i) = perim + vol;
end

a1 = sum(sqft);
a2 = sum(ribbons);

%% output
answer(a1)
answer(a2)