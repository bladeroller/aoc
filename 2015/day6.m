%% https://adventofcode.com/2015/day/6
file = 'example.txt';
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1 and 2
lights1 = false(1000, 1000);
lights2 = uint16(lights1);

for i = 1:length(txt.noblanks)
  instructions = regexp(txt.noblanks{i}, '\s', 'split');
  switch instructions{2}
    case 'on'
      coords1 = get_coords(instructions{3});
      coords2 = get_coords(instructions{5});
      inds = coords2indices(coords1, coords2);
      lights1(inds) = true;
      lights2(inds) = lights2(inds) + 1;
    case 'off'
      coords1 = get_coords(instructions{3});
      coords2 = get_coords(instructions{5});
      inds = coords2indices(coords1, coords2);
      lights1(inds) = false;
      lights2(inds) = lights2(inds) - 1;
    otherwise  % toggle
      coords1 = get_coords(instructions{2});
      coords2 = get_coords(instructions{4});
      inds = coords2indices(coords1, coords2);
      lights1(inds) = ~lights1(inds);
      lights2(inds) = lights2(inds) + 2;
  end
end

part1 = sum(sum(lights1));
part2 = sum(sum(double(lights2)));

%% output
answer(part1)
answer(part2)


%% functions
function xy = get_coords(str)
  xy = regexp(str, ',', 'split');
  xy = str2double(xy);
end

function ind = coords2indices(xy1, xy2)
  [X, Y] = meshgrid(xy1(1):xy2(1), xy1(2):xy2(2));
  % X values are the columns, Y values are the rows (0-based)
  ind = sub2ind([1000, 1000], Y(:)+1, X(:)+1);
end
