%% 2020-12-01 Advent of Code Day 1
% https://adventofcode.com/2020/day/1
file = 'example.txt';
% file = 'input.txt';

%% inhale the file
tic
txt = read_lines(file);
toc

%% part 1 and 2
a = nchoosek(txt.nums, 3);
tf = sum(a, 2) == 2020;
a1 = prod( a(tf, :) );
answer(a1)
