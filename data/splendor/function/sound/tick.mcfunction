# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return run function splendor:sound/stop
execute unless score @s ct_state matches 1 run return run function splendor:sound/stop
execute unless score @s ct_game matches 22 run return run function splendor:sound/stop
execute unless score @s sp_music matches 1 run return run function splendor:sound/stop
execute if data entity @s data.splendor{phase:4} run return run function splendor:sound/stop
scoreboard players remove @s sp_bgm 1
execute unless score @s sp_bgm matches 1.. run function splendor:sound/start
