function love_letter:engine/private
data modify entity @s data.ll_private.kind set value "baron"
scoreboard players operation #a ll_ctx = @e[tag=ll.engine_actor,limit=1] ll_hand
scoreboard players operation #b ll_ctx = @e[tag=ll.engine_target,limit=1] ll_hand
execute if score #a ll_ctx < #b ll_ctx as @e[tag=ll.engine_actor] run function love_letter:engine/eliminate
execute if score #b ll_ctx < #a ll_ctx as @e[tag=ll.engine_target] run function love_letter:engine/eliminate
function love_letter:engine/done
