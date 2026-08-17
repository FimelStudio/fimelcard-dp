# 通用牌桌只在这里分派各游戏的玩家清理逻辑，便于以后继续注册其他棋牌游戏
execute if entity @s[tag=fc.player] run function fast_card:player/clear_state
execute if entity @s[tag=lh.player] run function liars_holdem:player/clear_state
execute if entity @s[tag=hb.player] run function hanabi:player/clear_state

# 离线即视为离开牌桌；保持静默，不发送入座或离座提示
function cardtable:seat/remove_player
