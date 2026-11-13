# 同桌唯一常驻牌盒；旧版本盒原位迁至桌心，重载不换实体或重置牌局。
scoreboard players operation #vis_table un_ctx = @s ct_id
scoreboard players set #vis_boxes un_ctx 0
execute as @e[type=minecraft:item_display,tag=un.box] if score @s ct_id = #vis_table un_ctx run scoreboard players add #vis_boxes un_ctx 1
execute if score #vis_boxes un_ctx matches 0 positioned ~ ~1.095 ~ summon minecraft:item_display run function uno:visual/box
execute as @e[type=minecraft:item_display,tag=un.box] if score @s ct_id = #vis_table un_ctx run tp @s ~ ~1.095 ~
execute as @e[type=minecraft:item_display,tag=un.box] if score @s ct_id = #vis_table un_ctx run function uno:visual/box
