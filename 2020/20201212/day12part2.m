%% 2020-12-12 Advent of Code Day 12
% https://adventofcode.com/2020/day/12

% file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 2
easting  = 0;
northing = 0;

way_east  = 10;
way_north = 1;

for i = 1:length(txt.noblanks)
  action = txt.noblanks{i}(1);
  value  = str2double(txt.noblanks{i}(2:end));
  
  switch action
    case 'N',  way_north = way_north + value;
    case 'S',  way_north = way_north - value;
    case 'E',  way_east  = way_east + value;
    case 'W',  way_east  = way_east - value;
    case 'F'
      northing = northing + way_north * value;
      easting  = easting  + way_east  * value;
    case {'R', 'L'}
      if action == 'L', value = -value;  end
      dcm = [cosd(value), sind(value); -sind(value), cosd(value)];
      way_vec   = dcm * [way_east; way_north];
      way_east  = way_vec(1);
      way_north = way_vec(2);
    otherwise
      pi; break
  end
end

answer = abs(easting) + abs(northing)
clipboard('copy', answer)
