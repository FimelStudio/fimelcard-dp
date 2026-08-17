# 当前执行者是牌桌控制器；逐座位校验可发现“总数相同但某座位缺失”的情况
scoreboard players operation #ctx_id lh_ctx = @s lh_id
scoreboard players set #hud_dirty lh_ctx 0
function liars_holdem:hud/check_seat {seat:1}
function liars_holdem:hud/check_seat {seat:2}
function liars_holdem:hud/check_seat {seat:3}
function liars_holdem:hud/check_seat {seat:4}
execute if score #hud_dirty lh_ctx matches 1 run function liars_holdem:hud/update
