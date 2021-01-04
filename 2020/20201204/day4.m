%% 2020-12-04 Advent of Code Day 4
% https://adventofcode.com/2020/day/4
clear; clc
file = 'example_valid.txt';
file = 'input.txt';

%% inhale the file
txt = read_lines(file);
txt.rawchar = regexprep(txt.rawchar, '\n$', '');

%% part 1 and 2
expected_fields = {'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'};

passports = regexp(txt.rawchar, '\n\n', 'split');

pp = struct();
tic
for i = 1:length(passports)
% for i = 1:10
  kv_pairs = regexp(passports{i}, '\s', 'split');
  current_fields = cell(size(kv_pairs));
  for j = 1:length(kv_pairs)
    kv_pair = regexp(kv_pairs{j}, ':', 'split');
    current_fields{j} = kv_pair{1};
    pp(i).(kv_pair{1}) = kv_pair{2};
  end
  
  % make sure none of the expected fields are missing from the passport
  if isempty(setdiff(expected_fields, current_fields))
    pp(i).is_present = true;
    pp(i).is_valid = validate_fields(pp(i));
  else
    pp(i).is_present = false;
    pp(i).is_valid = false;
  end
end
toc


%% results
answer1 = sum([pp.is_present])
answer2 = sum([pp.is_present] & [pp.is_valid])
% % % commandwindow
% % % clipboard('copy', answer)
% % % save day4 answer


function tf = validate_fields(s)
  s.hgt
  is_valid_field = false(7,1);
  % - byr (Birth Year) - four digits; at least 1920 and at most 2002.
  byr = str2double(s.byr);
  if byr >= 1920 && byr <= 2002,  is_valid_field(1) = true;  end

  % - iyr (Issue Year) - four digits; at least 2010 and at most 2020.
  iyr = str2double(s.iyr);
  if iyr >= 2010 && iyr <= 2020,  is_valid_field(2) = true;  end

  % - eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
  eyr = str2double(s.eyr);
  if eyr >= 2020 && eyr <= 2030,  is_valid_field(3) = true;  end

  % - hgt (Height) - a number followed by either cm or in:
  % - If cm, the number must be at least 150 and at most 193.
  % - If in, the number must be at least 59 and at most 76.
  tokens = regexp(s.hgt, '^(\d+)(cm)$|^(\d+)(in)$', 'tokens', 'once');
  if length(tokens) == 2
    hgt = str2double(tokens{1});
    switch tokens{2}
      case 'cm',  if hgt >= 150 && hgt <= 193,  is_valid_field(4) = true;  end
      case 'in',  if hgt >= 59  && hgt <= 76,   is_valid_field(4) = true;  end
    end
  end
  
  % - hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
  if regexp(s.hcl, '^#[0-9a-f]{6}$'),  is_valid_field(5) = true;  end

  % - ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
  if ismember(s.ecl, {'amb' 'blu' 'brn' 'gry' 'grn' 'hzl' 'oth'}), is_valid_field(6) = true;  end

  % - pid (Passport ID) - a nine-digit number, including leading zeroes.
  if regexp(s.pid, '^\d{9}$'),  is_valid_field(7) = true;  end
  tf = all(is_valid_field);
end
