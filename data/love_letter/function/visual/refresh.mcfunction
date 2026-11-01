function love_letter:system/context
function love_letter:visual/context
function love_letter:visual/clear_static
scoreboard players set #box_found ll_ctx 0
execute as @e[tag=ll.box] if score @s ct_id = #vis_table ll_ctx run scoreboard players set #box_found ll_ctx 1
execute if score #box_found ll_ctx matches 0 positioned ~ ~1.04 ~ summon minecraft:item_display run function love_letter:visual/box
execute as @e[type=minecraft:marker,tag=ll.board] run function love_letter:visual/participant
# 牌库相关字段仅展示双人局公开移出的三张牌。
data modify storage love_letter:visual public set value []
data modify storage love_letter:visual public set from entity @s data.love_letter.public
execute if data storage love_letter:visual public[0] run function love_letter:visual/public
