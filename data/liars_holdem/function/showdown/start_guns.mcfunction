scoreboard players set @s lh_state 15
scoreboard players set @s lh_timer 0
scoreboard players set @s lh_gun_seat 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.audience] remove lh.audience
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.audience
tag @a[tag=lh.final_winner] remove lh.final_winner
# “本局最佳牌型”和失败者左轮都直接读取最终名次，不再读取独立的胜者缓存
execute as @a[tag=lh.player,scores={lh_in_showdown=1,lh_place=1}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.final_winner
tellraw @a[tag=lh.audience] [{text:'本局最佳牌型：',color:'gold'},{selector:'@a[tag=lh.final_winner]',color:'yellow',bold:true}]
tag @a[tag=lh.final_winner] remove lh.final_winner
tag @a[tag=lh.audience] remove lh.audience
function liars_holdem:log {text:"排名展示结束，开始按座位处理失败者左轮"}
function liars_holdem:gun/next_showdown
