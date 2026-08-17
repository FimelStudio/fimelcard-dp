# 弃牌先退出当前局，再锁定左轮结果；其他人的行动在占位演出期间暂停
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_fold 1
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_wait 1
scoreboard players set @a[tag=lh.action_actor,limit=1] lh_done 1
execute as @a[tag=lh.action_actor,limit=1] run function liars_holdem:util/clear_items_actions
scoreboard players operation @s lh_return = @s lh_state
scoreboard players operation @s lh_gun_seat = @a[tag=lh.action_actor,limit=1] lh_seat
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{selector:'@a[tag=lh.action_actor,limit=1]',color:'yellow'},{text:' 选择弃牌，并立即接受左轮判定。',color:'gray'}]
function liars_holdem:sound/fold
function liars_holdem:log {text:"当前玩家弃牌，进入即时左轮判定"}
function liars_holdem:gun/start_fold
