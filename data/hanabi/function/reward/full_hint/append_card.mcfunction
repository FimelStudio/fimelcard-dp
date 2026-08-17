function hanabi:card/load_definition
data modify storage hanabi:reward full_hint_piece set value {text:"?",font:"card:hanabi_ui",shadow_color:0}
data modify storage hanabi:reward full_hint_piece.text set from storage hanabi:card def.glyph
$data modify storage hanabi:reward full_hint_piece.click_event set value {action:"run_command",command:"trigger hb_action set $(action)"}
execute if score #reward_card_added hb_ctx matches 1.. run data modify storage hanabi:reward full_hint_cards.extra append value {text:"\u0001",font:"card:hanabi_ui"}
data modify storage hanabi:reward full_hint_cards.extra append from storage hanabi:reward full_hint_piece
scoreboard players add #reward_card_added hb_ctx 1
