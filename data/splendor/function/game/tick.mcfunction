# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return 0
function splendor:system/context
function splendor:visual/tick
function splendor:sound/tick
scoreboard players add @s sp_pulse 1
execute if score @s sp_pulse matches 20.. run function splendor:game/hud
execute if score @s sp_finish matches 1.. run return run function splendor:game/finish_tick
execute if score @s sp_anim matches 1.. run scoreboard players remove @s sp_anim 1
execute if score @s sp_anim matches 1 run function splendor:game/after_animation
execute if score @s sp_pulse matches 0 as @a[tag=sp.audience] run function splendor:input/give
