# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s ct_paused matches 1 run return 0
function magical_athlete:visual/context
execute if score @s ma_vtimer matches 0 run function magical_athlete:visual/event_begin
execute unless score @s ma_anim matches 1.. run return 0
data modify storage magical_athlete:visual event set from entity @s data.magical_athlete.visual_event
scoreboard players add @s ma_vframe 1
function magical_athlete:visual/event_tick with storage magical_athlete:visual event
scoreboard players remove @s ma_vtimer 1
execute if score @s ma_vtimer matches 0 run function magical_athlete:visual/event_end
