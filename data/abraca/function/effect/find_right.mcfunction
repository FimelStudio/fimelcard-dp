# 座位编号沿玩家视角的右侧递增，因此右侧应递减并在1前回到4。
scoreboard players remove #target ab_ctx 1
execute if score #target ab_ctx matches ..0 run scoreboard players set #target ab_ctx 4
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_seat = #target ab_ctx run tag @s add ab.target
execute as @a[tag=ab.target] if score @s ab_id = #ctx ab_ctx run scoreboard players set #found ab_ctx 1
