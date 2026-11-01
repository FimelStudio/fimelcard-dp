scoreboard players operation #guess ll_ctx = #ui_action ll_ctx
scoreboard players remove #guess ll_ctx 200
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/guess
