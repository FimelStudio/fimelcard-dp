# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
tag @a[tag=av.target] remove av.target
execute as @a[tag=av.audience] if score @s av_seat = #action av_ctx run tag @s add av.target
execute unless entity @a[tag=av.target,limit=1] run return 0
scoreboard players set #toggle av_ctx 1
scoreboard players operation #toggle av_ctx -= @a[tag=av.target,limit=1] av_selected
scoreboard players operation @a[tag=av.target,limit=1] av_selected = #toggle av_ctx
execute as @a[tag=av.target,scores={av_selected=1}] run effect give @s minecraft:glowing infinite 0 true
execute as @a[tag=av.target,scores={av_selected=0}] run effect clear @s minecraft:glowing
function avalon:hud/update
tag @a[tag=av.target] remove av.target
