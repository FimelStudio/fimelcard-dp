# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$execute store result score #ui_count un_ctx if entity @e[tag=un.uihand,scores={un_card=$(id)}]
execute if score #ui_count un_ctx matches 0 run return 0
# 每行12种完整牌面（444px），十个9px换行为四层堆叠预留6px行距。
execute if score #ui_col un_ctx matches 12 run data modify storage uno:ui grid.extra append value {text:"\n\n\n\n\n\n\n\n\n\n"}
execute if score #ui_col un_ctx matches 12 run scoreboard players set #ui_col un_ctx 0
scoreboard players add #ui_col un_ctx 1
$scoreboard players set #ui_code un_ctx $(id)
scoreboard players add #ui_code un_ctx 100
scoreboard players operation #ui_code un_ctx += #ui_base un_ctx
execute store result storage uno:ui pick int 1 run scoreboard players get #ui_code un_ctx
execute store result storage uno:ui count int 1 run scoreboard players get #ui_count un_ctx
$data modify storage uno:ui glyph set value "$(glyph)"
$execute if score #ui_count un_ctx matches 2 run data modify storage uno:ui glyph set value "$(glyph2)"
$execute if score #ui_count un_ctx matches 3 run data modify storage uno:ui glyph set value "$(glyph3)"
$execute if score #ui_count un_ctx matches 4.. run data modify storage uno:ui glyph set value "$(glyph4)"
$data modify storage uno:ui name set value "$(name)"
data modify storage uno:ui card_font set value "card:uno/dialog"
data modify storage uno:ui pick_hint set value "点击选择"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui card_font set value "card:uno/dialog_selected"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui pick_hint set value "已选中 · 再点取消"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui selected set value {text:"$(name)",color:"gold"}
function uno:ui/append_card with storage uno:ui
