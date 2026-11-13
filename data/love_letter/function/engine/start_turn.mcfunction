function love_letter:system/context
tag @e[tag=ll.engine_actor] remove ll.engine_actor
scoreboard players operation #actor ll_ctx = @s ll_turn
execute as @e[tag=ll.board,scores={ll_alive=1}] if score @s ll_seat = #actor ll_ctx run tag @s add ll.engine_actor
execute unless entity @e[tag=ll.engine_actor] run return 0
scoreboard players set @e[tag=ll.engine_actor] ll_protect 0
function love_letter:engine/draw
scoreboard players operation @e[tag=ll.engine_actor,limit=1] ll_extra = #draw ll_ctx
scoreboard players set @s ll_phase 1
scoreboard players set @s ll_actor 0
scoreboard players set @s ll_target 0
data modify entity @s data.ll_private set value {}
data modify entity @s data.ll_buffer set value []
