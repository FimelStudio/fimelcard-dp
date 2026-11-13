function love_letter:system/context
scoreboard players set #over ll_ctx 0
execute if score @s ll_phase matches 6 run scoreboard players set #over ll_ctx 1
execute if score @s ll_phase matches 6 run return 1
scoreboard players set @s ll_alive_n 0
execute as @e[tag=ll.board,scores={ll_alive=1}] run scoreboard players add @e[tag=ll.current,limit=1] ll_alive_n 1
execute if score @s ll_alive_n matches ..1 run scoreboard players set #over ll_ctx 1
execute if score #over ll_ctx matches 1 if score @s ll_phase matches 4..5 run function love_letter:engine/resign_buffer
execute if score #over ll_ctx matches 0 if score @s ll_phase matches 2..5 run return 0
execute unless data entity @s data.love_letter.deck[0] run scoreboard players set #over ll_ctx 1
execute unless score #over ll_ctx matches 1 run return 0
scoreboard players set @s ll_phase 6
function love_letter:game/round_over
scoreboard players set #over ll_ctx 1
