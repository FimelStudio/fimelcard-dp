execute unless data entity @s data.love_letter.action.actor run return 0
scoreboard players operation #log_table ll_ctx = @s ct_id
data modify storage love_letter:chat event set from entity @s data.love_letter.action
execute store result score #log_actor ll_ctx run data get storage love_letter:chat event.actor
execute store result score #log_target ll_ctx run data get storage love_letter:chat event.target
execute store result score #log_card ll_ctx run data get storage love_letter:chat event.card
data modify storage love_letter:chat actor set value {text:"未知玩家"}
data modify storage love_letter:chat target set value {text:"未知玩家"}
execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_actor ll_ctx run data modify storage love_letter:chat actor set from entity @s data.ll_name
execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_target ll_ctx run data modify storage love_letter:chat target set from entity @s data.ll_name
data modify storage love_letter:chat message set value [{text:"[情书] ",color:"gold"}]
data modify storage love_letter:chat message append from storage love_letter:chat actor
execute if score #log_target ll_ctx matches 1..8 run function love_letter:game/chat/target
data modify storage love_letter:chat message append value {"text":" 使用 ","color":"white"}
scoreboard players operation #public_role ll_ctx = #log_card ll_ctx
function love_letter:game/role_name
data modify storage love_letter:chat role set from storage love_letter:runtime role
data modify storage love_letter:chat message append from storage love_letter:runtime role
execute if score #log_card ll_ctx matches 0 run function love_letter:game/chat/role_0
execute if score #log_card ll_ctx matches 1 run function love_letter:game/chat/role_1
execute if score #log_card ll_ctx matches 2 run function love_letter:game/chat/role_2
execute if score #log_card ll_ctx matches 3 run function love_letter:game/chat/role_3
execute if score #log_card ll_ctx matches 4 run function love_letter:game/chat/role_4
execute if score #log_card ll_ctx matches 5 run function love_letter:game/chat/role_5
execute if score #log_card ll_ctx matches 6 run function love_letter:game/chat/role_6
execute if score #log_card ll_ctx matches 7 run function love_letter:game/chat/role_7
execute if score #log_card ll_ctx matches 8 run function love_letter:game/chat/role_8
execute if score #log_card ll_ctx matches 9 run function love_letter:game/chat/role_9
execute if data storage love_letter:chat event.eliminated[0] run function love_letter:game/chat/eliminated
data modify storage love_letter:chat message append value {"text":"。","color":"white"}
function love_letter:game/chat/send with storage love_letter:chat
function love_letter:sound/play
