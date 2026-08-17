# 提示物只接受Q；误按F时从副手清除并恢复到当前回合玩家
item replace entity @s weapon.offhand with minecraft:air
execute if entity @s[tag=hb.turn] run function hanabi:input/give_hint
