execute unless score #log_target ll_ctx matches 1..8 run return run function love_letter:game/chat/no_target
data modify storage love_letter:chat message append value {"text":"，令目标弃掉 ","color":"white"}
execute store result score #public_role ll_ctx run data get storage love_letter:chat event.forced
function love_letter:game/role_name
data modify storage love_letter:chat message append from storage love_letter:runtime role
execute unless score #public_role ll_ctx matches 9 run data modify storage love_letter:chat message append value {"text":" 并重新摸一张牌","color":"white"}
