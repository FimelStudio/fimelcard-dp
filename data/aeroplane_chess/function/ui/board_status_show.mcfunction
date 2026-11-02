# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$title @a[tag=ac.audience] actionbar [{text:"$(color)方",color:"gold"},{text:" · $(phase) · 骰子 $(dice)",color:"white"}]
