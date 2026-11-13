# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return 0
execute unless score @s ma_music matches 1 run return 0
execute if data entity @s data.magical_athlete{track:1} unless data entity @s data.ma_sound{track:1} run return run function magical_athlete:sound/start
execute unless data entity @s data.magical_athlete{track:1} unless data entity @s data.ma_sound{track:0} run return run function magical_athlete:sound/start
scoreboard players remove @s ma_music_tick 1
execute if score @s ma_music_tick matches ..0 run function magical_athlete:sound/play
