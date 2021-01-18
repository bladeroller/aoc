%% https://adventofcode.com/2015/day/20
puzzle = 29000000;

%% part 1
house = 665000;
num_presents = calc_presents1(house);

while num_presents < puzzle
  house = house + 1;
  num_presents = calc_presents1(house);
end

part1 = house;
answer(part1)


%% part 2
house = 705e3
num_presents2 = calc_presents2(house)

while num_presents2 < puzzle
  house = house + 1;
  num_presents2 = calc_presents2(house);
end

part2 = house;
answer(part2)


%% functions
function n = calc_presents1(h)
  n = sum(find(mod(h, 1:h) == 0) * 10);
end

function n = calc_presents2(h)
  houses = find(mod(h, 1:h) == 0);
  tf = houses < (h / 50);
  houses(tf) = [];
  n = sum(houses * 11);
end
