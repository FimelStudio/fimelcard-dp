scoreboard players operation #public_actor ll_ctx = @s ll_actor
scoreboard players operation #public_role ll_ctx = @s ll_card
function love_letter:game/role_name
execute as @e[tag=ll.board] if score @s ll_seat = #public_actor ll_ctx run function love_letter:game/announce_part
function love_letter:sound/play
