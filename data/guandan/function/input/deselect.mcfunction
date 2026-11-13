# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute if score @s gd_seat = @e[tag=gd.current,limit=1] gd_turn run scoreboard players set @e[tag=gd.current,limit=1] gd_hint 0
function guandan:input/clear_selected
function guandan:ui/open
