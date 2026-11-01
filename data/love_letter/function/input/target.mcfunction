scoreboard players operation #target ll_ctx = #ui_action ll_ctx
scoreboard players remove #target ll_ctx 100
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/target
