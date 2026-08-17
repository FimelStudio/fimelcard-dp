# 每个弃牌标记获得仅在当前桌本次Dialog中有效的选项序号
scoreboard players add #restore_option hb_ctx 1
scoreboard players operation @s hb_option = #restore_option hb_ctx
function hanabi:card/load_definition
data modify storage hanabi:dialog restore_piece set value {text:"?",font:"card:hanabi_ui",shadow_color:0}
data modify storage hanabi:dialog restore_piece.text set from storage hanabi:card def.glyph
scoreboard players operation #restore_action hb_ctx = #restore_option hb_ctx
scoreboard players add #restore_action hb_ctx 800
execute store result storage hanabi:dialog restore_action int 1 run scoreboard players get #restore_action hb_ctx
# 每行固定五张；行间预留72像素，避免64像素牌面上下重叠
scoreboard players operation #restore_column hb_ctx = #restore_added hb_ctx
scoreboard players set #five hb_ctx 5
scoreboard players operation #restore_column hb_ctx %= #five hb_ctx
execute if score #restore_added hb_ctx matches 1.. if score #restore_column hb_ctx matches 0 run data modify storage hanabi:dialog restore_view.extra append value {text:"\n\n\n\n\n\n\n\n",font:"minecraft:default"}
execute if score #restore_added hb_ctx matches 1.. if score #restore_column hb_ctx matches 1..4 run data modify storage hanabi:dialog restore_view.extra append value {text:"\u0001",font:"card:hanabi_ui"}
function hanabi:dialog/restore/append_click with storage hanabi:dialog
