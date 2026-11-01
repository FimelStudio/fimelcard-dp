scoreboard players operation #actor ll_ctx = @s ll_actor
scoreboard players set #valid ll_ctx 0
function love_letter:engine/validate
execute unless score #valid ll_ctx matches 1 run return 0
function love_letter:engine/targets
execute unless entity @e[tag=ll.legal] run return run function love_letter:engine/done
scoreboard players operation #target ll_ctx = @e[tag=ll.legal,sort=random,limit=1] ll_seat
function love_letter:engine/target
