# 设置直接保存在通用牌桌控制器上；仅修复缺失或越界值，不覆盖玩家已经保存的配置
execute unless score @s hb_clue_max matches 1..32 run scoreboard players set @s hb_clue_max 8
execute unless score @s hb_strike_max matches 1..9 run scoreboard players set @s hb_strike_max 3
execute unless score @s hb_storm matches 0..1 run scoreboard players set @s hb_storm 0
function hanabi:log {text:"已检查花火牌桌设置：提示、失误与彩色风暴"}
