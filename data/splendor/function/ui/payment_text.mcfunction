# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui detail.extra append value {text:"声望$(points)分 · 第$(tier)级\n原价：白$(c0) 蓝$(c1) 绿$(c2) 红$(c3) 黑$(c4)\n折扣后：白$(d0) 蓝$(d1) 绿$(d2) 红$(d3) 黑$(d4)\n下方选择实际支付。可少付某色、用等量黄金替代，不能超付。\n",color:"gray"}
