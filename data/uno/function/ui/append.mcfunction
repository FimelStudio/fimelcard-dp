$execute store result score #ui_count un_ctx if entity @e[tag=un.uihand,scores={un_card=$(id)}]
execute if score #ui_count un_ctx matches 0 run return 0
# 每行仍为8牌型；七个9px换行给54px牌面留出9px行距。
execute if score #ui_col un_ctx matches 8 run data modify storage uno:ui grid.extra append value {text:"\n\n\n\n\n\n\n"}
execute if score #ui_col un_ctx matches 8 run scoreboard players set #ui_col un_ctx 0
scoreboard players add #ui_col un_ctx 1
$scoreboard players set #ui_code un_ctx $(id)
scoreboard players add #ui_code un_ctx 100
scoreboard players operation #ui_code un_ctx += #ui_base un_ctx
execute store result storage uno:ui pick int 1 run scoreboard players get #ui_code un_ctx
execute store result storage uno:ui count int 1 run scoreboard players get #ui_count un_ctx
$data modify storage uno:ui glyph set value "$(glyph)"
$data modify storage uno:ui name set value "$(name)"
data modify storage uno:ui card_font set value "card:uno/dialog"
data modify storage uno:ui pick_hint set value "点击选择"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui card_font set value "card:uno/dialog_selected"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui pick_hint set value "已选中 · 再点取消"
$execute if score @s un_pick matches $(id) run data modify storage uno:ui selected set value {text:"$(name)",color:"gold"}
function uno:ui/append_card with storage uno:ui
