# 旧牌局没有弃牌时间字段，只在升级时按当前实体顺序补号；新牌局始终记录真实弃牌先后
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players set #discard_migrate hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.discard] if score @s hb_id = #ctx_id hb_ctx run function hanabi:discard/migrate_one
scoreboard players operation @s hb_discard_count = #discard_migrate hb_ctx
execute if score @s hb_state matches 2 run function hanabi:ui/discard_pile/spawn
