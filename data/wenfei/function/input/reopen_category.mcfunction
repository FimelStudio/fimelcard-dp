scoreboard players set #menu_epoch wq_ctx -1
execute store result score #menu_epoch wq_ctx run data get entity @e[tag=wq.drop,limit=1] Item.components."minecraft:custom_data".wenfei.epoch
kill @e[tag=wq.drop,limit=1]
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = @s wq_id run return 0
execute unless score @s wq_guess matches 1 run return 0
scoreboard players operation #ctx wq_ctx = @s wq_id
scoreboard players set #menu_valid wq_ctx 0
execute as @e[type=minecraft:marker,tag=wq.controller,scores={wq_state=1}] if score @s wq_id = #ctx wq_ctx if score @s wq_epoch = #menu_epoch wq_ctx run scoreboard players set #menu_valid wq_ctx 1
execute if score #menu_valid wq_ctx matches 1 run function wenfei:ui/open
