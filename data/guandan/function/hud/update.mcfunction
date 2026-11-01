execute unless entity @s[type=minecraft:player,tag=gd.player,tag=ct.player] run return 0
execute unless score @s ct_id = @s gd_table run return 0
execute unless entity @e[tag=gd.current,scores={ct_game=18,gd_state=1..5},limit=1] run return 0
scoreboard players operation #hud_table gd_ctx = @s gd_table
execute unless score @e[tag=gd.current,limit=1] ct_id = #hud_table gd_ctx run return 0
function guandan:hud/build
