# 先完成七选五计算，再进入逐座位亮牌过场；亮牌实体会一直保留到全部开枪结束
function liars_holdem:turn/clear_actions
scoreboard players set @s lh_state 14
scoreboard players set @s lh_timer 0
scoreboard players set @s lh_show_seat 0
scoreboard players set @s lh_show_count 0
scoreboard players set @s lh_show_phase 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
function liars_holdem:transition/showdown

# 摊牌归属使用记分项长期保存，避免多张牌桌同时摊牌时互相清除临时标签
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_in_showdown 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_is_winner 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_shown 0
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_in_showdown 1
scoreboard players set #showdown_count lh_ctx 0
execute as @a[tag=lh.player,scores={lh_in_showdown=1}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players add #showdown_count lh_ctx 1
execute if score #showdown_count lh_ctx matches 0 run return run function liars_holdem:round/end
execute if score #showdown_count lh_ctx matches 1 run return run function liars_holdem:round/end_single

# 每名玩家保存实际最佳五张牌ID及牌型比较值
execute as @a[tag=lh.player,scores={lh_in_showdown=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:hand/evaluate

# 排名是摊牌的唯一结果来源：第一名（包括完全平局的并列第一）就是本局胜者
# 不再单独用 #best 计算第二套胜者状态，避免排名显示与左轮判罚发生分叉
execute as @a[tag=lh.player,scores={lh_in_showdown=1}] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:showdown/calculate_place
execute as @a[tag=lh.player,scores={lh_in_showdown=1,lh_place=1}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_is_winner 1

# 非胜者会在亮牌和排名全部展示后依座位开枪；先更新子弹实体，展示期间即可看见判罚
execute as @a[tag=lh.player,scores={lh_in_showdown=1}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_pending_gun 0
execute as @a[tag=lh.player,scores={lh_in_showdown=1,lh_place=2..}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_pending_gun 1
execute as @a[tag=lh.player,scores={lh_in_showdown=1,lh_place=2..}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_bullets 8
function liars_holdem:hud/update
function liars_holdem:sound/showdown_start
function liars_holdem:log {text:"摊牌计算完成，开始依次展示每名玩家的最佳五张牌"}
