# 奖励效果不会消耗额外回合；处理完成后继续原数字5的补牌与回合推进
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @a[tag=hb.reward_actor] remove hb.reward_actor
execute as @a[tag=hb.player,tag=hb.reward_pending] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.reward_actor
execute unless entity @a[tag=hb.reward_actor,limit=1] run return run function hanabi:game/player_left

scoreboard players operation #slot hb_ctx = @s hb_pending_slot
scoreboard players operation #actor_seat hb_ctx = @a[tag=hb.reward_actor,limit=1] hb_seat
dialog clear @a[tag=hb.reward_actor,limit=1]
tag @a[tag=hb.reward_actor,limit=1] remove hb.reward_pending
tag @a[tag=hb.reward_actor,limit=1] remove hb.restore_pending
scoreboard players set @a[tag=hb.reward_actor,limit=1] hb_target 0
scoreboard players set @s hb_reward_pending 0
scoreboard players set @s hb_pending_slot 0
tag @s remove hb.reward_external_wait

function hanabi:log {text:"奖励牌效果处理完成，继续原回合的补牌与推进"}
function hanabi:score/update
execute if score @s hb_storm matches 0 if score @s hb_score matches 25 run scoreboard players set @s hb_reason 3
execute if score @s hb_storm matches 1 if score @s hb_score matches 30 run scoreboard players set @s hb_reason 3
execute if score @s hb_reason matches 3 run function hanabi:hud/update
execute if score @s hb_reason matches 3 run return run function hanabi:game/finish
function hanabi:card/draw_to_slot
function hanabi:hud/update
function hanabi:turn/advance
tag @a[tag=hb.reward_actor] remove hb.reward_actor
