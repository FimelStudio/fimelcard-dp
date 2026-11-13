# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui guidance set value {text:"你须弃 $(guide_due) 张：第9格 Q → 选择弃牌，用 ＋／− 选满后确认。",color:"red"}
$data modify storage catan:ui hud_guidance set value {text:"你须弃 $(guide_due) 张 · 第9格 Q 菜单",color:"red"}
