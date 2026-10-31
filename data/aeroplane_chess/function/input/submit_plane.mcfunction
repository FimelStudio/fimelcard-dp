scoreboard players operation #plane ac_ctx = #ui_action ac_ctx
scoreboard players remove #plane ac_ctx 2
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/choose
dialog clear @s
