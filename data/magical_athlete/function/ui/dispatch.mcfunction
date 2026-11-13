# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score #code ma_ctx matches 1 run return run function magical_athlete:ui/open
execute if score #code ma_ctx matches 6 run return run function magical_athlete:ui/myteam
execute if score #code ma_ctx matches 7 run return run function magical_athlete:ui/public
execute if score #code ma_ctx matches 8 run return run function magical_athlete:ui/rules
execute if score #code ma_ctx matches 9 run return run function magical_athlete:ui/music
execute if entity @e[tag=ma.current,scores={ma_anim=1..},limit=1] run return run function magical_athlete:ui/open
scoreboard players set #action_code ma_ctx 0
scoreboard players set #target ma_ctx 0
execute if score #code ma_ctx matches 5 run scoreboard players set #action_code ma_ctx 5
execute if score #code ma_ctx matches 100..135 run scoreboard players set #action_code ma_ctx 1
execute if score #code ma_ctx matches 100..135 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 100..135 run scoreboard players remove #target ma_ctx 100
execute if score #code ma_ctx matches 200..235 run scoreboard players set #action_code ma_ctx 2
execute if score #code ma_ctx matches 200..235 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 200..235 run scoreboard players remove #target ma_ctx 200
execute if score #code ma_ctx matches 300..305 run scoreboard players set #action_code ma_ctx 3
execute if score #code ma_ctx matches 300..305 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 300..305 run scoreboard players remove #target ma_ctx 300
execute if score #code ma_ctx matches 2099..2135 run scoreboard players set #action_code ma_ctx 4
execute if score #code ma_ctx matches 2099..2135 run scoreboard players operation #target ma_ctx = #code ma_ctx
execute if score #code ma_ctx matches 2099..2135 run scoreboard players remove #target ma_ctx 2100
execute if score #action_code ma_ctx matches 0 run return run function magical_athlete:ui/open
data modify storage magical_athlete:action input set value {actor:0,code:0,target:0,epoch:0}
execute store result storage magical_athlete:action input.actor int 1 run scoreboard players get @s ma_side
execute store result storage magical_athlete:action input.code int 1 run scoreboard players get #action_code ma_ctx
execute store result storage magical_athlete:action input.target int 1 run scoreboard players get #target ma_ctx
execute store result storage magical_athlete:action input.epoch int 1 run scoreboard players get @s ma_seen
execute as @e[tag=ma.current,limit=1] at @s run function magical_athlete:game/action
