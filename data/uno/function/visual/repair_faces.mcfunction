# /reload时以控制器为执行者，只迁移本桌尚未翻面的旧展示牌。
scoreboard players operation #vis_table un_ctx = @s ct_id
execute as @e[type=minecraft:item_display,tag=un.face,tag=!un.face_up_v2] if score @s ct_id = #vis_table un_ctx run function uno:visual/repair_face
