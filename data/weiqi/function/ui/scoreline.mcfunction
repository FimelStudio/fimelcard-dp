# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage weiqi:ui scoreline set value {"text":"$(area_title)：黑$(barea) / 白$(warea)\n空地 黑$(bterrit) / 白$(wterrit) · 未定/公气$(neutral)\n含贴目得分：黑$(bscore_label) / 白$(wscore_label)\n复盘手数：$(review)","color":"gray"}
