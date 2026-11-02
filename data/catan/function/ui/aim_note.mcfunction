# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
dialog clear @s
execute if score @s ca_mode matches 1 run tellraw @s {"text":"[卡坦岛] 瞄准另一块六边形地块，再用第1格按 Q；金色预选后确认移动强盗。","color":"aqua"}
execute if score @s ca_mode matches 2 run tellraw @s {"text":"[卡坦岛] 瞄准地块交会的交点，再用第1格按 Q；金色预选后确认村庄。","color":"aqua"}
execute if score @s ca_mode matches 3 run tellraw @s {"text":"[卡坦岛] 瞄准两个交点之间的边中段，再用第1格按 Q；金色预选后确认道路。","color":"aqua"}
execute if score @s ca_mode matches 4 run tellraw @s {"text":"[卡坦岛] 瞄准己方村庄所在交点，再用第1格按 Q；金色预选后确认升级城市。","color":"aqua"}
