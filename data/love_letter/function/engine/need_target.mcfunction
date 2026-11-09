function love_letter:engine/targets
execute unless entity @e[tag=ll.legal] run return run function love_letter:engine/done
scoreboard players set @s ll_phase 2
execute if score #pre_target ll_ctx matches 1..8 run return run function love_letter:targeting/apply
function love_letter:game/await_choice
