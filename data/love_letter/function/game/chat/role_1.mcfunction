execute unless score #log_target ll_ctx matches 1..8 run return run function love_letter:game/chat/no_target
data modify storage love_letter:chat message append value {"text":"，猜测目标手牌为 ","color":"white"}
execute store result score #public_role ll_ctx run data get storage love_letter:chat event.guess
function love_letter:game/role_name
data modify storage love_letter:chat message append from storage love_letter:runtime role
execute if data storage love_letter:chat event.eliminated[0] run data modify storage love_letter:chat message append value {"text":"，猜中了","color":"green"}
execute unless data storage love_letter:chat event.eliminated[0] run data modify storage love_letter:chat message append value {"text":"，未猜中","color":"gray"}
