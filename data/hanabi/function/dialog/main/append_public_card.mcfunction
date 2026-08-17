function hanabi:card/load_definition
data modify storage hanabi:dialog public_piece set value {text:"?",font:"card:hanabi_ui",shadow_color:0}
data modify storage hanabi:dialog public_piece.text set from storage hanabi:card def.glyph
execute if score #row_added hb_ctx matches 1.. run data modify storage hanabi:dialog row_piece.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:dialog row_piece.extra append from storage hanabi:dialog public_piece
scoreboard players add #row_added hb_ctx 1
