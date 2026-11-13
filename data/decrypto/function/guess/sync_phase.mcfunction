# 解密与拦截同时开放。旧同步回合的角色4仅保留解密资格。
execute unless score #phase dc_ctx matches 5 run return 0
execute if entity @s[scores={dc_team=1,dc_role=2..4}] unless score @s dc_role matches 3 unless data entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.answers.p6 run return run scoreboard players set #guess_phase dc_ctx 6
execute if entity @s[scores={dc_team=2,dc_role=2..4}] unless score @s dc_role matches 3 unless data entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.answers.p8 run return run scoreboard players set #guess_phase dc_ctx 8
execute if score @e[type=minecraft:marker,tag=dc.guess_table,limit=1] dc_round matches 1 run return 0
execute unless entity @s[scores={dc_role=3}] unless entity @s[scores={dc_role=1,dc_size=2}] run return 0
execute if entity @s[scores={dc_team=1}] unless data entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.answers.p7 run scoreboard players set #guess_phase dc_ctx 7
execute if entity @s[scores={dc_team=2}] unless data entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.sync.answers.p5 run scoreboard players set #guess_phase dc_ctx 5
