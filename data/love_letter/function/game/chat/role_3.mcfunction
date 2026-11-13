execute unless score #log_target ll_ctx matches 1..8 run return run function love_letter:game/chat/no_target
data modify storage love_letter:chat message append value {"text":"，比较双方手牌","color":"white"}
execute unless data storage love_letter:chat event.eliminated[0] run data modify storage love_letter:chat message append value {"text":"，双方点数相同，无人出局","color":"white"}
