# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui note set value {"text":"","extra":[{"text":"","font":"card:catan","color":"white"},{"text":" 发明取牌：$(a_label) ＋ $(b_label)","color":"aqua"}]}
