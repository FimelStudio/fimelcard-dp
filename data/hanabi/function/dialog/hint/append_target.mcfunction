function hanabi:card/load_definition
data modify storage hanabi:dialog target_piece set value {text:"?",font:"card:hanabi_ui",shadow_color:0}
data modify storage hanabi:dialog target_piece.text set from storage hanabi:card def.glyph
execute if score #target_added hb_ctx matches 1.. run data modify storage hanabi:dialog target_hand.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:dialog target_hand.extra append from storage hanabi:dialog target_piece
# 状态按普通文字排布；每枚标记后保留三个全角空格，避免彼此拥挤。
data modify storage hanabi:dialog status_piece set value {text:"？        ",color:"white"}
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 run data modify storage hanabi:dialog status_piece set value {text:"色        ",color:"aqua"}
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:dialog status_piece set value {text:"数        ",color:"gold"}
execute if score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:dialog status_piece set value {text:"★        ",color:"green"}
data modify storage hanabi:dialog target_status.extra append from storage hanabi:dialog status_piece
scoreboard players add #target_added hb_ctx 1
