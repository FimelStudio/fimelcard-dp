# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 当前控制器，仅同步同桌玩家；紧张模式本局保持至结算。
scoreboard players operation #music_table dd_ctx = @s dd_id
execute if score @s dd_audio matches 0 as @a[tag=dd.player] if score @s dd_id = #music_table dd_ctx unless score @s dd_music matches 0 run function doudizhu:music/stop
execute if score @s dd_audio matches 0 run return 0
execute unless entity @s[tag=dd.music_exciting] as @a[tag=dd.player] if score @s dd_id = #music_table dd_ctx unless score @s dd_music matches 1 run function doudizhu:music/start_normal
execute if entity @s[tag=dd.music_exciting] as @a[tag=dd.player] if score @s dd_id = #music_table dd_ctx unless score @s dd_music matches 2 run function doudizhu:music/start_exciting
