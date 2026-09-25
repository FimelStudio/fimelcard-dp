execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s wq_id run return 0
execute unless score @s wq_guess matches 1 run return 0
scoreboard players operation #ctx wq_ctx = @s wq_id
tag @e[tag=wq.current] remove wq.current
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=3}] if score @s wq_id = #ctx wq_ctx run tag @s add wq.current
execute unless entity @e[tag=wq.current,limit=1] run return 0
scoreboard players set #item_epoch wq_ctx -1
scoreboard players set #points wq_ctx -1
execute store result score #item_epoch wq_ctx run data get entity @e[tag=wq.drop,limit=1] Item.components."minecraft:custom_data".wenfei.epoch
execute store result score #points wq_ctx run data get entity @e[tag=wq.drop,limit=1] Item.components."minecraft:custom_data".wenfei.points
kill @e[tag=wq.drop,limit=1]
execute if score #points wq_ctx matches 0..4 as @e[tag=wq.current,limit=1] at @s if score @s wq_epoch = #item_epoch wq_ctx run function wenfei:input/score_submit
tag @e[tag=wq.current] remove wq.current
