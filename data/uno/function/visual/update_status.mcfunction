# 控制器在自身位置执行；仅事件触发，原位更新同一个文字实体。
scoreboard players operation #vis_table un_ctx = @s ct_id
scoreboard players set #vis_turn un_ctx 0
execute if score @s un_turn matches 1..8 run scoreboard players operation #vis_turn un_ctx = @s un_turn
data modify storage uno:visual roster set value {text:"",extra:[{text:"UNO",color:"gold",bold:true}]}
function uno:visual/status_seat {seat:1}
function uno:visual/status_seat {seat:2}
function uno:visual/status_seat {seat:3}
function uno:visual/status_seat {seat:4}
function uno:visual/status_seat {seat:5}
function uno:visual/status_seat {seat:6}
function uno:visual/status_seat {seat:7}
function uno:visual/status_seat {seat:8}
scoreboard players set #vis_status un_ctx 0
execute as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run scoreboard players add #vis_status un_ctx 1
# 兼容旧存档残留的重复标签；正常刷新不删除或重新召唤文字。
execute if score #vis_status un_ctx matches 2.. as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run kill @s
execute if score #vis_status un_ctx matches 2.. run scoreboard players set #vis_status un_ctx 0
execute if score #vis_status un_ctx matches 0 positioned ~ ~1.90 ~ summon minecraft:text_display run function uno:visual/status_entity
execute as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run tp @s ~ ~1.90 ~
execute as @e[type=minecraft:text_display,tag=un.status] if score @s ct_id = #vis_table un_ctx run function uno:visual/status_entity
