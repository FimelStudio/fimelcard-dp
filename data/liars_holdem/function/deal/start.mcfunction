# 新建牌库并播放公共牌盒发手牌；公共牌在牌盒消失后才从剩余牌库生成
scoreboard players set @s lh_state 2
scoreboard players set @s lh_phase 1
scoreboard players set @s lh_timer 0
scoreboard players set @s lh_deal 0
scoreboard players set @s lh_scan 0
function liars_holdem:deck/create
function cardtable:animation/deal/box/clear
function cardtable:animation/deal/box/spawn
function liars_holdem:sound/deck_appear
function liars_holdem:util/count_alive
scoreboard players operation @s lh_total = @s lh_alive_count
scoreboard players add @s lh_total 0
scoreboard players operation @s lh_total *= #two lh_ctx
function liars_holdem:log {text:"牌库已创建，开始发放玩家手牌"}
