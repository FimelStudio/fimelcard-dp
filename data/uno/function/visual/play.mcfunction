# 调用者为桌心控制器；#card是0..53牌型，#seat为真实座号。
scoreboard players operation #vis_table un_ctx = @s ct_id
scoreboard players operation #vis_seat un_ctx = #seat un_ctx
function uno:visual/resolve_model
execute store result storage uno:visual seat int 1 run scoreboard players get #vis_seat un_ctx
execute as @e[type=minecraft:item_display,tag=un.face] if score @s ct_id = #vis_table un_ctx run data merge entity @s {Glowing:0b}
execute as @e[type=minecraft:item_display,tag=un.face] if score @s ct_id = #vis_table un_ctx if score @s un_seat = #vis_seat un_ctx run kill @s
# 第一张真人出牌替换起始数字牌展示；其他座位保留最近一张。
execute unless score #vis_seat un_ctx matches 0 as @e[type=minecraft:item_display,tag=un.face,scores={un_seat=0}] if score @s ct_id = #vis_table un_ctx run kill @s
execute if score #vis_seat un_ctx matches 0 positioned ~0.60 ~1.04 ~0.18 summon minecraft:item_display run function uno:visual/seat0 with storage uno:visual
execute if score @s ct_capacity matches 4 if score #vis_seat un_ctx matches 1 positioned ~0 ~1.04 ~-0.94 summon minecraft:item_display run function uno:visual/seat1_4 with storage uno:visual
execute if score @s ct_capacity matches 4 if score #vis_seat un_ctx matches 2 positioned ~0.94 ~1.04 ~0 summon minecraft:item_display run function uno:visual/seat2_4 with storage uno:visual
execute if score @s ct_capacity matches 4 if score #vis_seat un_ctx matches 3 positioned ~0 ~1.04 ~0.94 summon minecraft:item_display run function uno:visual/seat3_4 with storage uno:visual
execute if score @s ct_capacity matches 4 if score #vis_seat un_ctx matches 4 positioned ~-0.94 ~1.04 ~0 summon minecraft:item_display run function uno:visual/seat4_4 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 1 positioned ~-0.85 ~1.04 ~-1.42 summon minecraft:item_display run function uno:visual/seat1_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 2 positioned ~0.85 ~1.04 ~-1.42 summon minecraft:item_display run function uno:visual/seat2_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 3 positioned ~1.42 ~1.04 ~-0.85 summon minecraft:item_display run function uno:visual/seat3_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 4 positioned ~1.42 ~1.04 ~0.85 summon minecraft:item_display run function uno:visual/seat4_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 5 positioned ~0.85 ~1.04 ~1.42 summon minecraft:item_display run function uno:visual/seat5_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 6 positioned ~-0.85 ~1.04 ~1.42 summon minecraft:item_display run function uno:visual/seat6_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 7 positioned ~-1.42 ~1.04 ~0.85 summon minecraft:item_display run function uno:visual/seat7_8 with storage uno:visual
execute if score @s ct_capacity matches 8 if score #vis_seat un_ctx matches 8 positioned ~-1.42 ~1.04 ~-0.85 summon minecraft:item_display run function uno:visual/seat8_8 with storage uno:visual
function uno:visual/status
