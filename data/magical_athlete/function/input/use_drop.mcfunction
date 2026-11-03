# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute unless score @a[tag=ma.dropper,limit=1] ma_table matches $(table) run return 0
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:input/give
execute as @a[tag=ma.dropper,limit=1] run function magical_athlete:input/roll
