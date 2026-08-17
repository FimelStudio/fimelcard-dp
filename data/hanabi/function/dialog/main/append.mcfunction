# 当前执行者是权威手牌标记；对自己只显示已经掌握的知识
function hanabi:card/load_definition
data modify storage hanabi:dialog piece set value {text:"\uE000",font:"card:hanabi_ui",shadow_color:0}
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 run data modify storage hanabi:dialog piece.text set from storage hanabi:card def.color_glyph
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:dialog piece.text set from storage hanabi:card def.rank_glyph
execute if score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:dialog piece.text set from storage hanabi:card def.glyph
execute if score @s hb_reward matches 1..2 run data modify storage hanabi:dialog piece.text set from storage hanabi:card def.glyph

$data modify storage hanabi:dialog piece.click_event set value {action:"run_command",command:"trigger hb_action set $(play)"}
execute if score #dialog_added hb_ctx matches 1.. run data modify storage hanabi:dialog play.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:dialog play.extra append from storage hanabi:dialog piece
$data modify storage hanabi:dialog piece.click_event set value {action:"run_command",command:"trigger hb_action set $(discard)"}
execute if score #dialog_added hb_ctx matches 1.. run data modify storage hanabi:dialog discard.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:dialog discard.extra append from storage hanabi:dialog piece
scoreboard players add #dialog_added hb_ctx 1
