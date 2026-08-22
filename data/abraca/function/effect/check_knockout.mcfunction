# 法术效果结束后立刻检查；不等待当前施法者主动结束回合。
scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches ..0 run tag @s add ab.knocked
execute if entity @a[tag=ab.knocked] run function abraca:game/round_finish
execute as @a[tag=ab.knocked] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.knocked
