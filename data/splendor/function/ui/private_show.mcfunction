# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui private set value {"text":"","extra":[{"text":"你的筹码（$(token_count)／10）：\n","color":"gray"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t0)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t1)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t2)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t3)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t4)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t5)  ","color":"white"},{"text":"\n永久折扣：白$(b0) 蓝$(b1) 绿$(b2) 红$(b3) 黑$(b4)\n声望$(vp)分 · 已购$(card_count)张 · 预约$(reserve_count)／3","color":"gray"}]}
