# 普通提示与完全提示奖励共用同一份已知提示标记。
data modify storage hanabi:dialog status_piece set value {text:"？        ",color:"white"}
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 run data modify storage hanabi:dialog status_piece set value {text:"色        ",color:"aqua"}
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:dialog status_piece set value {text:"数        ",color:"gold"}
execute if score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:dialog status_piece set value {text:"★        ",color:"green"}
