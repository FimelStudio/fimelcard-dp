tag @s add gd.controller
execute unless score @s gd_pair matches 0..1 run scoreboard players set @s gd_pair 1
execute unless score @s gd_startlevel matches 2..14 run scoreboard players set @s gd_startlevel 2
execute unless score @s gd_mode matches 0..1 run scoreboard players set @s gd_mode 0
execute unless score @s gd_rounds matches 1..32 run scoreboard players set @s gd_rounds 8
execute unless score @s gd_show matches 0..1 run scoreboard players set @s gd_show 1
execute unless score @s gd_limit matches 0..120 run scoreboard players set @s gd_limit 0
execute if score @s ct_state matches 1 run return 0
scoreboard players set @s gd_state 0
function guandan:visual/setup
