function hanabi:card/load_definition
data modify storage hanabi:dialog target_piece set value {text:"?",font:"card:hanabi_ui",shadow_color:0}
data modify storage hanabi:dialog target_piece.text set from storage hanabi:card def.glyph
execute if score #target_added hb_ctx matches 1.. run data modify storage hanabi:dialog target_hand.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:dialog target_hand.extra append from storage hanabi:dialog target_piece
scoreboard players add #target_added hb_ctx 1
