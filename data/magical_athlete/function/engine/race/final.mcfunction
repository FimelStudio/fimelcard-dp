data modify storage magical_athlete:engine s.phase set value 5
data modify storage magical_athlete:engine s.winners set value []
scoreboard players set #best ma_ctx -1
execute store result score #points1 ma_ctx run data get storage magical_athlete:engine s.p1.points
execute if score #n ma_ctx matches 1.. if score #points1 ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points1 ma_ctx
execute store result score #points2 ma_ctx run data get storage magical_athlete:engine s.p2.points
execute if score #n ma_ctx matches 2.. if score #points2 ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points2 ma_ctx
execute store result score #points3 ma_ctx run data get storage magical_athlete:engine s.p3.points
execute if score #n ma_ctx matches 3.. if score #points3 ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points3 ma_ctx
execute store result score #points4 ma_ctx run data get storage magical_athlete:engine s.p4.points
execute if score #n ma_ctx matches 4.. if score #points4 ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points4 ma_ctx
execute store result score #points5 ma_ctx run data get storage magical_athlete:engine s.p5.points
execute if score #n ma_ctx matches 5.. if score #points5 ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points5 ma_ctx
execute store result score #points6 ma_ctx run data get storage magical_athlete:engine s.p6.points
execute if score #n ma_ctx matches 6.. if score #points6 ma_ctx > #best ma_ctx run scoreboard players operation #best ma_ctx = #points6 ma_ctx
execute if score #n ma_ctx matches 1.. if score #points1 ma_ctx = #best ma_ctx run data modify storage magical_athlete:engine s.winners append value 1
execute if score #n ma_ctx matches 2.. if score #points2 ma_ctx = #best ma_ctx run data modify storage magical_athlete:engine s.winners append value 2
execute if score #n ma_ctx matches 3.. if score #points3 ma_ctx = #best ma_ctx run data modify storage magical_athlete:engine s.winners append value 3
execute if score #n ma_ctx matches 4.. if score #points4 ma_ctx = #best ma_ctx run data modify storage magical_athlete:engine s.winners append value 4
execute if score #n ma_ctx matches 5.. if score #points5 ma_ctx = #best ma_ctx run data modify storage magical_athlete:engine s.winners append value 5
execute if score #n ma_ctx matches 6.. if score #points6 ma_ctx = #best ma_ctx run data modify storage magical_athlete:engine s.winners append value 6
