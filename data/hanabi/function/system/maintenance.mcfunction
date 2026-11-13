# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @a[tag=hb.player] at @s run function hanabi:system/recover_orphan_player
execute as @e[type=minecraft:marker,tag=hb.controller,scores={hb_state=1..2}] at @s run function hanabi:system/maintenance_one
