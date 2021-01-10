%% https://adventofcode.com/2015/day/11
% pword = 'hijklmmn';  % meets 1st requirement but fails 2nd
% pword = 'abbceffg';  % meets 3rd requirement but fails 1st
% pword = 'abbcegjk';  % fails 3rd requirement
% pword = 'abcdefgh';  % next password is abcdffaa
% pword = 'ghijklmn';  % next password is ghjaabcc
pword = 'hxbxwxba';  % your nput

%% part 1
part1 = new_password(pword)

%% part 2
part2 = new_password(part1)


%% functions
function pw2 = new_password(pw1)
  pw1 = uint8(pw1) - 97;  % convert from a-z to 0-25

  pw2 = increment(pw1);
  pw2 = skip_oil(pw2);
  is_valid = reqmt1(pw2) && reqmt3(pw2);

  while ~is_valid
    pw2 = increment(pw2);  % char(pw2 + 97);
    pw2 = skip_oil(pw2);
    is_valid = reqmt1(pw2) && reqmt3(pw2);
  end
  pw2 = char(pw2 + 97);
end

function p2 = skip_oil(p1)
  % Passwords may not contain the letters i, o, or l,
  c = char(p1 + 97);
  idx = regexp(c, '[iol]');
  if idx
    c(idx(1)) = char(c(idx(1)) + 1);
    c(idx(1)+1:end) = 'a';
    p2 = uint8(c) - 97;
  else
    p2 = p1;
  end
end

function pw = increment(pw)
  j = 8;
  while 1
    pw(j) = mod(pw(j) + 1, 26);
    if pw(j) == 0
      j = j - 1 ;
    else
      break
    end
  end
end

function tf = reqmt1(pw)
  % Passwords must include one increasing straight of at least three letters,
  % like abc, bcd, cde, and so on, up to xyz
  d = diff(pw);
  tf = any(pattern_find(d, [1,1]));
end

function tf = reqmt3(pw)
  % Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
  c = char(pw + 97);
  m = regexp(c, '(\w)\1', 'match');
  tf = length(unique(m)) >= 2;
end

function tf = pattern_find(data, pattern)
  tf = (data == pattern(1));
  
  for p = 2:length(pattern)
    tf = tf & [data(p:end) == pattern(p), false(1, p-1)];
  end
end
