# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# 提示物只接受Q；误按F时从副手清除并恢复到当前回合玩家
item replace entity @s weapon.offhand with minecraft:air
execute if entity @s[tag=hb.turn] run function hanabi:input/give_hint
