# 执行者是玩家。以权威ab.hand marker计数，避免用物品栏数量误判。
scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players operation #seat ab_ctx = @s ab_seat
scoreboard players set #hand ab_ctx 0
execute as @e[type=minecraft:marker,tag=ab.hand] if score @s ab_id = #ctx ab_ctx if score @s ab_owner = #seat ab_ctx run scoreboard players add #hand ab_ctx 1
scoreboard players set #deck ab_ctx 0
execute as @e[type=minecraft:marker,tag=ab.deck] if score @s ab_id = #ctx ab_ctx run scoreboard players add #deck ab_ctx 1
execute if score #hand ab_ctx matches ..4 if score #deck ab_ctx matches 1.. run function abraca:deck/draw
execute if score #hand ab_ctx matches ..4 if score #deck ab_ctx matches 1.. run function abraca:deck/refill
