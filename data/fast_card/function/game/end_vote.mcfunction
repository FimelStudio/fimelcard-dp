# 三票达到通用牌桌的过半阈值
function fast_card:log {text:"结束游戏投票达到3票，提前结束本场游戏"}
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'结束投票已通过，本场Fast Card提前结束。',color:'red'}]
function fast_card:game/finish
