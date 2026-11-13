# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless entity @s[tag=ct.player,tag=ac.player] run return 0
execute unless score @s ct_id = #click_table ac_ctx run return 0
execute unless score @s ac_table = #click_table ac_ctx run return 0
function aeroplane_chess:input/context
execute unless entity @s[tag=ac.actor] run return 0

execute unless score @s ac_color = #click_color ac_ctx run return 0
scoreboard players operation #plane ac_ctx = #click_plane ac_ctx
execute as @e[tag=ac.current,limit=1] at @s run function aeroplane_chess:game/choose
