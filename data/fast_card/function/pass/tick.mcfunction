# 一桌一刻最多接收一张牌；地面实体扫描必须先通过当前玩家的Q键统计
scoreboard players operation #ctx_id fc_ctx = @s fc_id
scoreboard players operation #ctx_turn fc_ctx = @s fc_turn
scoreboard players set #pass_done fc_ctx 0

# 非当前出牌者按Q丢出的游戏牌立即送回本人，不进入传牌判断
tag @a[tag=fc.return_owner] remove fc.return_owner
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx unless score @s fc_seat = #ctx_turn fc_ctx at @s run function fast_card:pass/reject_drop

tag @a[tag=fc.sender] remove fc.sender
execute as @a[tag=fc.turn] if score @s fc_id = #ctx_id fc_ctx if score @s fc_seat = #ctx_turn fc_ctx at @s run function fast_card:pass/as_sender

tag @a[tag=fc.sender] remove fc.sender
tag @a[tag=fc.return_owner] remove fc.return_owner
