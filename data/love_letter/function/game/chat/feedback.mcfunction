scoreboard players operation #kill_seat ll_ctx = #log_actor ll_ctx
execute if score #log_card ll_ctx matches 3 if score #log_dead ll_ctx = #log_actor ll_ctx run scoreboard players operation #kill_seat ll_ctx = #log_target ll_ctx
data modify storage love_letter:chat feedback set value {killer:{text:"未知玩家"},victim:{text:"未知玩家"},role:{text:"卡牌"}}
data modify storage love_letter:chat feedback.victim set from entity @s data.ll_name
data modify storage love_letter:chat feedback.role set from storage love_letter:chat role
execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #kill_seat ll_ctx run data modify storage love_letter:chat feedback.killer set from entity @s data.ll_name
execute as @a[tag=ll.audience] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_dead ll_ctx run function love_letter:game/chat/subtitle_victim with storage love_letter:chat feedback
execute unless score #kill_seat ll_ctx = #log_dead ll_ctx as @a[tag=ll.audience] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #kill_seat ll_ctx run function love_letter:game/chat/subtitle_killer with storage love_letter:chat feedback
