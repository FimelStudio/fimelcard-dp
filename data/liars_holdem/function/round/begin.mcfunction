# 开始新牌局前先确认整场仍有至少两名存活玩家
function liars_holdem:util/count_alive
execute if score @s lh_alive_count matches ..1 run return run function liars_holdem:game/finish

scoreboard players add @s lh_round 1
scoreboard players set @s lh_state 1
scoreboard players set @s lh_phase 0
scoreboard players set @s lh_timer 0
scoreboard players set @s lh_flipped 0
scoreboard players set @s lh_allin 0
scoreboard players set @s lh_auto 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
function liars_holdem:round/cleanup

# 存活玩家恢复本局状态、1发子弹和一次换牌机会
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_fold 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_wait 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_done 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_bullets 1
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_swap 1
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_swap_pending 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_retry 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_pending_gun 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_hand_count 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_in_showdown 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_is_winner 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_shown 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_card 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_call 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_fold 0

# 重置弹数后立即生成HUD，使其从“第x局”标题开始就稳定显示
function liars_holdem:hud/update
function liars_holdem:turn/rotate_dealer
function liars_holdem:transition/round_title
function liars_holdem:log {text:"新牌局过场开始"}
