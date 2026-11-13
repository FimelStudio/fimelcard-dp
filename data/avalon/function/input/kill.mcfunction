# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
scoreboard players operation #target av_ctx = @a[tag=av.actor,limit=1] av_target
tag @a[tag=av.target] remove av.target
execute as @a[tag=av.audience,scores={av_role=1..3}] if score @s av_seat = #target av_ctx run tag @s add av.target
execute unless entity @a[tag=av.target,limit=1] run return 0
tellraw @a[tag=av.audience] [{text:"刺客选择刺杀：",color:"red"},{selector:"@a[tag=av.target]"}]
execute if score @a[tag=av.target,limit=1] av_role matches 1 run return run function avalon:game/evil_win
function avalon:game/good_win
