# 仅用于奖励计数与实体池异常时兜底；不创建pending，直接恢复原出牌结算
scoreboard players operation #slot hb_ctx = @s hb_pending_slot
scoreboard players operation #actor_seat hb_ctx = @a[tag=hb.action_actor,limit=1] hb_seat
scoreboard players set @s hb_pending_slot 0
scoreboard players set @s hb_reward_pending 0
function hanabi:score/update
execute if score @s hb_storm matches 0 if score @s hb_score matches 25 run scoreboard players set @s hb_reason 3
execute if score @s hb_storm matches 1 if score @s hb_score matches 30 run scoreboard players set @s hb_reason 3
execute if score @s hb_reason matches 3 run function hanabi:hud/update
execute if score @s hb_reason matches 3 run return run function hanabi:game/finish
function hanabi:card/draw_to_slot
function hanabi:hud/update
function hanabi:turn/advance
