# 当前执行者是控制器；#action为1101..1108
scoreboard players operation #reward_target hb_ctx = #action hb_ctx
scoreboard players remove #reward_target hb_ctx 1100
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #actor_seat hb_ctx = @a[tag=hb.action_actor,limit=1] hb_seat
execute if score #reward_target hb_ctx = #actor_seat hb_ctx run return run function hanabi:reward/full_hint/open_target

scoreboard players set #target_cards hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #reward_target hb_ctx run scoreboard players add #target_cards hb_ctx 1
execute unless score #target_cards hb_ctx matches 1.. run return run function hanabi:reward/full_hint/open_target
scoreboard players operation @a[tag=hb.action_actor,limit=1] hb_target = #reward_target hb_ctx
function hanabi:reward/full_hint/open_card
