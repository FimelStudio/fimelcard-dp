function hanabi:game/init_table
execute store result storage hanabi:rules clues int 1 run scoreboard players get @s hb_clue_max
execute store result storage hanabi:rules strikes int 1 run scoreboard players get @s hb_strike_max
data modify storage hanabi:rules storm set value {text:"关闭（标准50张牌、五组烟花、满分25）",color:"gray"}
execute if score @s hb_storm matches 1 run data modify storage hanabi:rules storm set value {text:"开启（额外加入彩色1～5、六组烟花、满分30）",color:"light_purple"}
function hanabi:rules/show_dialog with storage hanabi:rules
