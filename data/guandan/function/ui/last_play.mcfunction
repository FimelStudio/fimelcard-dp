# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage guandan:ui last_play set value {text:"还没有出牌，或等待重新领出。",color:"gray"}
execute if score @e[tag=gd.current,limit=1] gd_lastkind matches 1.. run data modify storage guandan:ui last_play set value {text:"",extra:[]}
scoreboard players operation #ui_lastseat gd_ctx = @e[tag=gd.current,limit=1] gd_lastseat
execute if score @e[tag=gd.current,limit=1] gd_lastkind matches 1.. as @e[tag=gd.board] if score @s gd_seat = #ui_lastseat gd_ctx run function guandan:ui/last_play_owner
