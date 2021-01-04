%% 2020-12-12 Advent of Code Day 12
% https://adventofcode.com/2020/day/12
% commandwindow

% file = 'example.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);

%% part 1
heading = 90;
easting = 0;
northing = 0;

for i = 1:length(txt.noblanks)
  action = txt.noblanks{i}(1);
  value  = str2double(txt.noblanks{i}(2:end));
  
  switch action
    case 'N',  northing = northing + value;
    case 'S',  northing = northing - value;
    case 'E',  easting  = easting + value;
    case 'W',  easting  = easting - value;
    case 'F'
      switch heading
        case 0,   northing = northing + value;
        case 90,  easting  = easting + value;
        case 180, northing = northing - value;
        case 270, easting  = easting - value;
        otherwise, pi; break
      end
    case 'R',  heading = mod(heading + value, 360);
    case 'L',  heading = mod(heading - value, 360);
    otherwise, pi; break
  end
end

answer = abs(easting) + abs(northing)
clipboard('copy', answer)
commandwindow
