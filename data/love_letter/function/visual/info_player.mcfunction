data modify storage love_letter:visual info.name set value {text:"未知玩家"}
execute if data entity @s data.ll_name run data modify storage love_letter:visual info.name set from entity @s data.ll_name
data modify storage love_letter:visual info.lines append from storage love_letter:visual info.name
execute store result storage love_letter:visual info.points int 1 run scoreboard players get @s ll_points
function love_letter:visual/info_points with storage love_letter:visual info
execute if score #vis_state ll_ctx matches 2 if score @s ll_alive matches 1 if score @s ll_seat = #vis_turn ll_ctx run data modify storage love_letter:visual info.lines append value {text:" · 行动中",color:"yellow"}
execute if score @s ll_alive matches 0 run data modify storage love_letter:visual info.lines append value {text:" · 出局",color:"red"}
execute if score @s ll_alive matches 1 if score @s ll_protect matches 1 run data modify storage love_letter:visual info.lines append value {text:" · 受保护",color:"aqua"}
execute if score #vis_state ll_ctx matches 3..4 if score @s ll_won matches 1 run data modify storage love_letter:visual info.lines append value {text:" · 本轮胜者",color:"yellow"}
execute if score #vis_state ll_ctx matches 3..4 if score @s ll_bonus matches 1 run data modify storage love_letter:visual info.lines append value {text:" · 间谍奖励",color:"light_purple"}
execute if score #vis_state ll_ctx matches 4 if score @s ll_matchwin matches 1 run data modify storage love_letter:visual info.lines append value {text:" · 本场胜者",color:"gold"}
execute if score #vis_state ll_ctx matches 3..4 if data entity @s data.ll_reveal run function love_letter:visual/info_reveal
data modify storage love_letter:visual info.lines append value {text:"\n"}
