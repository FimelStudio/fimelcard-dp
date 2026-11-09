# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
data modify storage splendor:direct hit set from entity @s data.hit
execute on attacker if entity @s[type=minecraft:player] run function splendor:direct/cancel with storage splendor:direct hit
data remove entity @s attack
