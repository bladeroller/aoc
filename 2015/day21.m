%% https://adventofcode.com/2015/day/21

%% example
% % % boss.hitpoints = 12;
% % % boss.damage = 7;
% % % boss.armor = 2;
% % % 
% % % player.hitpoints = 8;
% % % player.damage = 5;
% % % player.armor = 5;
% % % 
% % % [player, boss] = play(player, boss);

%% part 1
weapons = 4:8;
armor   = 0:5;
rings_damage  = 0:3;
rings_defense = 0:3;

weapons_cost = [8,10,25,40,74];
armor_cost   = [0,13,31,53,75,102];
rings_damage_cost  = [0,25,50,100];
rings_defense_cost = [0,20,40,80];

weapons_cost = containers.Map(weapons, weapons_cost);
armor_cost   = containers.Map(armor,   armor_cost);
rings_damage_cost  = containers.Map(rings_damage,  rings_damage_cost);
rings_defense_cost = containers.Map(rings_defense, rings_defense_cost);

gold = [];
winners = {};

for w = 4:8
  boss   = init_boss;
  player = init_player;
  for a = 0:5
    fprintf('wep: %d, arm: %d ------------\n', w, a)
    % either 1 ring or 2 different rings
    for rdam = 0:3
      for rdef = 0:3
        player.damage = w + rdam;
        player.armor  = a + rdef;
        [p, b, winner] = play(player, boss);
        gold(end+1) = weapons_cost(w) + armor_cost(a) + rings_damage_cost(rdam) + rings_defense_cost(rdef);
        winners{end+1} = winner;
        fprintf('rdam: %d, rdef: %d || p.hit:%3d, b.hit=%3d || gold: %3d\n', ...
          rdam, rdef, p.hitpoints, b.hitpoints, gold(end))
      end
    end

    % two of the same rings
    same_rings = [1,2; 1,3; 2,3];
    player.armor  = a;
    for i = 1:size(same_rings, 1)
      player.damage = w + sum(same_rings(i,:));
      [p, b, winner] = play(player, boss);
      gold(end+1) = weapons_cost(w) + armor_cost(a) + rings_damage_cost(same_rings(i,1)) + rings_damage_cost(same_rings(i,2));
      winners{end+1} = winner;
      fprintf('rdam1: %d, rdam2: %d || p.hit:%3d, b.hit=%3d || gold: %3d\n', ...
        same_rings(i,1), same_rings(i,2), p.hitpoints, b.hitpoints, gold(end))
    end

    player.damage = w;
    for i = 1:size(same_rings, 1)
      player.armor = a + sum(same_rings(i,:));
      [p, b, winner] = play(player, boss);
      gold(end+1) = weapons_cost(w) + armor_cost(a) + rings_defense_cost(same_rings(i,1)) + rings_defense_cost(same_rings(i,2));
      winners{end+1} = winner;
      fprintf('rdef1: %d, rdef2: %d || p.hit:%3d, b.hit=%3d || gold: %3d\n', ...
        same_rings(i,1), same_rings(i,2), p.hitpoints, b.hitpoints, gold(end))
    end
  end
end


tf  = ismember(winners, 'p');
tf2 = ismember(winners, 'b');

%% output
part1 = min(gold(tf));
part2 = max(gold(tf2));
answer(part1)
answer(part2)


%% functions
function b = init_boss()
  b.hitpoints = 100;
  b.damage = 8;
  b.armor = 2;
end

function p = init_player()
  p.hitpoints = 100;
  p.damage = 0;
  p.armor = 0;
end

function [p, b, winnner] = play(p, b)
  while (p.hitpoints > 0) && (b.hitpoints > 0)
    pdeals = max([1, p.damage - b.armor]);
    bdeals = max([1, b.damage - p.armor]);

    b.hitpoints = b.hitpoints - pdeals;
    if b.hitpoints <= 0
      break
    end
    p.hitpoints = p.hitpoints - bdeals;
  end
  
  if b.hitpoints <= 0,  winnner = 'p';
  else,                 winnner = 'b';
  end
end
