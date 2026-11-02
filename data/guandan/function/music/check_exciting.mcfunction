execute if score @s gd_kind matches 8..10 run tag @s add gd.music_exciting
execute if entity @e[tag=gd.board,scores={gd_count=1..2}] run tag @s add gd.music_exciting
