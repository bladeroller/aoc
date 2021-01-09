%% https://adventofcode.com/2015/day/8
file = 'input.txt';
txt = read_lines(file);  % inhale the file

%% part 1
lengths1a = cellfun(@length, txt.noblanks);

txt = decode_strings(txt);
lengths1b = cellfun(@length, txt.decoded);

part1 = sum(lengths1a) - sum(lengths1b);

%% part 2
txt = encode_strings(txt);
lengths2 = cellfun(@length, txt.encoded);

part2 = sum(lengths2) - sum(lengths1a);

%% output
answer(part1)
answer(part2)


%% functions
function t = encode_strings(t)
  t.encoded = regexprep(t.noblanks, '\\', '\\\\');
  t.encoded = regexprep(t.encoded, '"', '\\"');
  t.encoded = regexprep(t.encoded, '(.*)', '"$1"');
end

function t = decode_strings(t)  % removes escape sequences
  t.decoded = t.noblanks;
  for i = 1:t.numlines
    str = t.noblanks{i}(2:end-1);
    [tokens, tokenExtents] = regexp(str, '(\\.{1})', 'tokens', 'tokenExtents');
    tokens = [tokens{:}];
    for j = length(tokens):-1:1  % go backwards through each token
      if tokens{j}(2) == 'x'
        chr = hex2char(str(tokenExtents{j}(end)+(1:2)));
        str = [str(1:tokenExtents{j}(1)-1), chr, str(tokenExtents{j}(end)+3:end)];
      else
        str(tokenExtents{j}(1)) = [];  % kill the backslash
      end
    end
    t.decoded{i} = str;
  end
end

function c = hex2char(s)
  c = char(hex2dec((s)));
end
