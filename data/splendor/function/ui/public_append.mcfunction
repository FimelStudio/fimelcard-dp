# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui detail.extra append value {text:"",extra:[$(name),{text:" · $(vp)分 · $(card_count)张开发卡 · 预约$(reserve_count)张\n筹码：白$(t0) 蓝$(t1) 绿$(t2) 红$(t3) 黑$(t4) 金$(t5)\n折扣：白$(b0) 蓝$(b1) 绿$(b2) 红$(b3) 黑$(b4)\n\n",color:"gray"}]}
