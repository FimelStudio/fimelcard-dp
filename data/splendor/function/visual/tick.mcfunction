# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return 0
execute unless score @s sp_vtimer matches 1.. run return 0
function splendor:visual/context
execute store result storage splendor:visual step int 1 run scoreboard players get @s sp_vstep
function splendor:visual/read_frame with storage splendor:visual
execute as @e[tag=sp.anim] if score @s sp_table = #vis_table sp_ctx run function splendor:visual/animate_frame with storage splendor:visual frame
scoreboard players add @s sp_vstep 1
scoreboard players remove @s sp_vtimer 1
execute if score @s sp_vtimer matches 0 run function splendor:visual/animation_done
