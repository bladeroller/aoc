%% 2020-12-25 Advent of Code Day 25
% https://adventofcode.com/2020/day/25

%% part 1
% card = 5764801;
% door = 17807724;
card = 8252394;
door = 6269621;

card_loops = calc_loops(7, card)

answer = transform(door, card_loops)

%% functions
function loop = calc_loops(subj, key)
  val = 1;
  loop = 0;
  while val ~= key
    val = do_math(val, subj);
    loop = loop + 1;
  end
end

function val = transform(num, nloops)
  val = 1;
  for i = 1:nloops
    val = do_math(val, num);
  end
end

function val = do_math(val, subj)
    val = val * subj;
    val = rem(val, 20201227);
end