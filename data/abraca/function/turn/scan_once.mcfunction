# 执行者是本桌控制器。每次将座位号向前推进一格；仅选中真实参加本桌游戏的玩家。
scoreboard players add @s ab_turn 1
execute if score @s ab_turn matches 5.. run scoreboard players set @s ab_turn 1
scoreboard players operation #seat ab_ctx = @s ab_turn
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_seat = #seat ab_ctx run tag @s add ab.turn
execute as @a[tag=ab.turn] if score @s ab_id = #ctx ab_ctx run scoreboard players set #found ab_ctx 1
