# 异常或重载导致候选缺失时安全解除当前换牌锁，不生成新牌
execute as @e[tag=lh.swap_candidate] if score @s lh_id = #ctx_id lh_ctx if score @s lh_seat = #swap_seat lh_ctx run kill @s
scoreboard players set @s lh_swap_pending 0
dialog clear @s
tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'换牌候选已经失效，本次换牌取消。',color:'yellow'}]
tag @e[tag=lh.action_controller] remove lh.action_controller
tag @s remove lh.swap_actor
