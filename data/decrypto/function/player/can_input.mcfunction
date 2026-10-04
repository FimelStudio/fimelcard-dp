# 调用者已验证桌号，#phase为本桌阶段；所有入口共用同一职责判定。
scoreboard players set #authorized dc_ctx 0
execute if score #phase dc_ctx matches 1 if entity @s[scores={dc_team=1,dc_role=1}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 3 if entity @s[scores={dc_team=2,dc_role=1}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 5 if entity @s[scores={dc_team=2,dc_role=3..4}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 6 if entity @s[scores={dc_team=1,dc_role=2}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 6 if entity @s[scores={dc_team=1,dc_role=4}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 7 if entity @s[scores={dc_team=1,dc_role=3..4}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 8 if entity @s[scores={dc_team=2,dc_role=2}] run scoreboard players set #authorized dc_ctx 1
execute if score #phase dc_ctx matches 8 if entity @s[scores={dc_team=2,dc_role=4}] run scoreboard players set #authorized dc_ctx 1
