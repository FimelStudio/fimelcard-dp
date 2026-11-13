data modify storage splendor:action input set value {actor:0,code:0,target:0,epoch:0,take:[0,0,0,0,0,0],pay:[0,0,0,0,0,0]}
execute store result storage splendor:action input.actor int 1 run scoreboard players get @s sp_side
execute store result storage splendor:action input.code int 1 run scoreboard players get #action_code sp_ctx
execute store result storage splendor:action input.target int 1 run scoreboard players get @s sp_target
data modify storage splendor:action input.epoch set from entity @e[tag=sp.current,limit=1] data.splendor.epoch
execute store result storage splendor:action input.take[0] int 1 run scoreboard players get @s sp_pick0
execute store result storage splendor:action input.take[1] int 1 run scoreboard players get @s sp_pick1
execute store result storage splendor:action input.take[2] int 1 run scoreboard players get @s sp_pick2
execute store result storage splendor:action input.take[3] int 1 run scoreboard players get @s sp_pick3
execute store result storage splendor:action input.take[4] int 1 run scoreboard players get @s sp_pick4
execute store result storage splendor:action input.take[5] int 1 run scoreboard players get @s sp_pick5
execute if score #action_code sp_ctx matches 3 run data modify storage splendor:action input.pay set from storage splendor:direct pay
execute as @e[tag=sp.current,limit=1] at @s run function splendor:game/action
