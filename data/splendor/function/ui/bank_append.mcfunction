# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui public.extra append value {"text":"","extra":[{"text":"\n银行：","color":"gray"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t0)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t1)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t2)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t3)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t4)  ","color":"white"},{"text":"","font":"card:splendor/small","color":"white"},{"text":" $(t5)  ","color":"white"}]}
