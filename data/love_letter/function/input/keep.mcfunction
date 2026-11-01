scoreboard players operation #keep ll_ctx = #ui_action ll_ctx
scoreboard players remove #keep ll_ctx 300
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/keep
