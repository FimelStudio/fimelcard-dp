function hanabi:card/load_definition
data modify storage hanabi:dialog discard_piece set value {text:"?",font:"card:hanabi_ui",shadow_color:0}
data modify storage hanabi:dialog discard_piece.text set from storage hanabi:card def.glyph
scoreboard players operation #discard_column hb_ctx = #discard_added hb_ctx
scoreboard players set #five hb_ctx 5
scoreboard players operation #discard_column hb_ctx %= #five hb_ctx
# 每行固定五张；八个普通文字换行提供72像素行距，完整覆盖64像素牌面高度
execute if score #discard_added hb_ctx matches 1.. if score #discard_column hb_ctx matches 0 run data modify storage hanabi:dialog discard_view.extra append value {text:"\n\n\n\n\n\n\n\n",font:"minecraft:default"}
execute if score #discard_added hb_ctx matches 1.. if score #discard_column hb_ctx matches 1..4 run data modify storage hanabi:dialog discard_view.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:dialog discard_view.extra append from storage hanabi:dialog discard_piece
scoreboard players add #discard_added hb_ctx 1
