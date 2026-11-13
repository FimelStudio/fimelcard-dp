execute store result score #log_dead ll_ctx run data get storage love_letter:chat event.eliminated[0]
data remove storage love_letter:chat event.eliminated[0]
execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_dead ll_ctx run function love_letter:game/chat/eliminated_player
execute if data storage love_letter:chat event.eliminated[0] run function love_letter:game/chat/eliminated
