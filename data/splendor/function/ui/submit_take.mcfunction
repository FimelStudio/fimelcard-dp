# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage splendor:action input set value {actor:0,code:1,target:0,epoch:0,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0]}
execute store result storage splendor:action input.actor int 1 run scoreboard players get @s sp_side
execute store result storage splendor:action input.target int 1 run scoreboard players get @s sp_target
execute store result storage splendor:action input.epoch int 1 run scoreboard players get @s sp_seen
execute store result storage splendor:action input.take[0] int 1 run scoreboard players get @s sp_pick0
execute store result storage splendor:action input.take[1] int 1 run scoreboard players get @s sp_pick1
execute store result storage splendor:action input.take[2] int 1 run scoreboard players get @s sp_pick2
execute store result storage splendor:action input.take[3] int 1 run scoreboard players get @s sp_pick3
execute store result storage splendor:action input.take[4] int 1 run scoreboard players get @s sp_pick4
execute store result storage splendor:action input.take[5] int 1 run scoreboard players get @s sp_pick5
execute as @e[tag=sp.current,limit=1] at @s run function splendor:game/action
