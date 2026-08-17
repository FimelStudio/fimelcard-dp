function liars_holdem:turn/clear_actions
scoreboard players set @s lh_state 16
scoreboard players set @s lh_timer 0
scoreboard players operation #ctx_id lh_ctx = @s lh_id
# 本局进入结算等待时就立即清理公共牌、牌库、HUD和手牌，不延迟到下一局开始
function liars_holdem:round/cleanup
# 立即终止仍打开的换牌流程，避免结算期间残留对话框或下一局误收 trigger
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run dialog clear @s
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_swap_pending 0
tag @a[tag=lh.showdown] remove lh.showdown
tag @a[tag=lh.winner] remove lh.winner
tag @a[tag=lh.audience] remove lh.audience
tag @a[tag=lh.round_winner] remove lh.round_winner
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run title @s actionbar {text:'本局结束，正在重新洗牌……',color:'gray'}
function liars_holdem:log {text:"本局结束，等待下一局"}
