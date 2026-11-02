# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage catan:ui guidance set value {text:"还可免费修 $(guide_free) 路：第1格 Q 瞄准边；无处可建时在菜单放弃。",color:"aqua"}
$data modify storage catan:ui hud_guidance set value {text:"免费修路余 $(guide_free) 次 · 第1格 Q 选边",color:"aqua"}
