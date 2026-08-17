# 正常整场结束先保留三秒胜利过场，再清理并返回牌桌大厅
execute if score @s lh_state matches 17 run return 0
scoreboard players set @s lh_state 17
scoreboard players set @s lh_timer 0
function liars_holdem:turn/clear_actions
scoreboard players operation #ctx_id lh_ctx = @s lh_id
function liars_holdem:transition/final_winner
tag @a[tag=lh.final_winner] remove lh.final_winner
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.final_winner
title @a[tag=lh.final_winner] title {text:'最后的幸存者',color:'gold',bold:true}
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'整场胜者：',color:'gold'},{selector:'@a[tag=lh.final_winner,limit=1]',color:'yellow',bold:true}]
function liars_holdem:log {text:"整场只剩一名存活玩家，播放最终胜利过场"}
