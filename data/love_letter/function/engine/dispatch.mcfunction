execute if score @s ll_card matches 4 run scoreboard players set @e[tag=ll.engine_actor] ll_protect 1
execute if score @s ll_card matches 9 as @e[tag=ll.engine_actor] run function love_letter:engine/eliminate
execute if score @s ll_card matches 6 run return run function love_letter:engine/chancellor
execute if score @s ll_card matches 1..3 run return run function love_letter:engine/need_target
execute if score @s ll_card matches 5 run return run function love_letter:engine/need_target
execute if score @s ll_card matches 7 run return run function love_letter:engine/need_target
function love_letter:engine/done
