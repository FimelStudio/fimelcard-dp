# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players add @s ma_music 1
execute if score @s ma_music matches 2.. run scoreboard players set @s ma_music 0
function magical_athlete:sound/stop
execute if score @s ma_music matches 1 run function magical_athlete:sound/start
