function love_letter:engine/targets
execute unless entity @e[tag=ll.legal] run return run function love_letter:engine/done
scoreboard players set @s ll_phase 2
function love_letter:game/await_choice
