# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
# @s 为这一件阅读工具；只向实际丢出者重开。
execute on origin if entity @s[tag=bw.player] at @s run function bullshit:question/open_answer
kill @s
