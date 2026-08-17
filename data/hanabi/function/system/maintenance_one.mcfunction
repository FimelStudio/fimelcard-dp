# 当前执行者是控制器；任意参赛玩家离线都会安全结束合作牌局
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players set #online hb_ctx 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players add #online hb_ctx 1
execute unless score #online hb_ctx = @s hb_players run function hanabi:game/player_left
