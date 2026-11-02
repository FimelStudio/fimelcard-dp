# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui private set value {"text":"","extra":[{"text":"你是 $(side) 号（$(color_label)）\n\n","color":"gold"},{"text":"","font":"card:catan","color":"white"},{"text":" 木材 ×$(r0)　","color":"white"},{"text":"","font":"card:catan","color":"white"},{"text":" 砖块 ×$(r1)　","color":"white"},{"text":"","font":"card:catan","color":"white"},{"text":" 羊毛 ×$(r2)　","color":"white"},{"text":"","font":"card:catan","color":"white"},{"text":" 粮食 ×$(r3)　","color":"white"},{"text":"","font":"card:catan","color":"white"},{"text":" 矿石 ×$(r4)　","color":"white"},{"text":"\n\n胜利点：$(vp)　剩余道路$(roads_left)／村庄$(settlements_left)／城市$(cities_left)","color":"gray"}]}
