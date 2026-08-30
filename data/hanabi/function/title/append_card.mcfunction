# 当前执行者是手牌marker；按槽位调用顺序追加真实牌面字符。
function hanabi:card/load_definition
data modify storage hanabi:title card_piece set value {text:"?",shadow_color:0}
data modify storage hanabi:title card_piece.text set from storage hanabi:card def.glyph
data modify storage hanabi:title cards.extra append from storage hanabi:title card_piece
scoreboard players add #title_card_count hb_ctx 1
