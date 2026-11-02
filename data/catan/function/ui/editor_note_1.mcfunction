# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui note set value {"text":"","extra":[{"text":"须弃 $(due) 张\n\n","color":"red"},{"text":"已选：","color":"yellow"},{"text":"","font":"card:catan","color":"white"},{"text":" 木材 ×$(g0)　","color":"yellow"},{"text":"","font":"card:catan","color":"white"},{"text":" 砖块 ×$(g1)　","color":"yellow"},{"text":"","font":"card:catan","color":"white"},{"text":" 羊毛 ×$(g2)　","color":"yellow"},{"text":"","font":"card:catan","color":"white"},{"text":" 粮食 ×$(g3)　","color":"yellow"},{"text":"","font":"card:catan","color":"white"},{"text":" 矿石 ×$(g4)　","color":"yellow"}]}
