# 通用牌桌只在这里分派各游戏的玩家清理逻辑，便于以后继续注册其他棋牌游戏
execute if entity @s[tag=fc.player] run function fast_card:player/clear_state
execute if entity @s[tag=lh.player] run function liars_holdem:player/clear_state
execute if entity @s[tag=hb.player] run function hanabi:player/clear_state
execute if entity @s[tag=ab.player] run function abraca:player/clear_state
execute if entity @s[tag=bw.player] run function bullshit:player/clear_state
execute if entity @s[tag=dc.player] run function decrypto:player/clear_state
execute if entity @s[tag=cp.player] run function critical_point:game/player_left

execute if entity @s[tag=wq.player] run function wenfei:player/clear_state

# 离线即视为离开牌桌；保持静默，不发送入座或离座提示
execute if entity @s[tag=sk.player] run function skull:player/clear_state
execute if entity @s[tag=dd.player] run function doudizhu:player/clear_state
execute if entity @s[tag=un.player] run function uno:player/clear_state
execute if entity @s[tag=gm.player] run function gomoku:player/clear_state
execute if entity @s[tag=ac.player] run function aeroplane_chess:player/clear_state
execute if entity @s[tag=av.player] run function avalon:player/clear
execute if entity @s[tag=ll.player] run function love_letter:player/clear_state
execute if entity @s[tag=gd.player] run function guandan:player/clear_state
execute if entity @s[tag=go.player] run function weiqi:player/clear_state
function cardtable:seat/remove_player
execute if entity @s[tag=ch.player] run function chess:player/clear_state
execute if entity @s[tag=xq.player] run function xiangqi:player/clear_state
