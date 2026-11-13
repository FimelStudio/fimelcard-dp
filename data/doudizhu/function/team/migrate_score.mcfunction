# 旧2v2分数制累计的是净分。续局保留领先方的净胜分，落后方从0起算。
execute if data entity @s data.dd_team_points run return 0
data modify entity @s data.dd_team_points set value 1b
execute if score @s dd_scoring matches 1 run return 0
scoreboard players set @s dd_team_one 0
scoreboard players set @s dd_team_two 0
scoreboard players set #legacy_orange dd_ctx 0
scoreboard players set #legacy_aqua dd_ctx 0
scoreboard players operation #legacy_team_table dd_ctx = @s dd_id
execute as @e[tag=dd.actor,scores={dd_team=1}] if score @s dd_id = #legacy_team_table dd_ctx run scoreboard players operation #legacy_orange dd_ctx += @s dd_total
execute as @e[tag=dd.actor,scores={dd_team=2}] if score @s dd_id = #legacy_team_table dd_ctx run scoreboard players operation #legacy_aqua dd_ctx += @s dd_total
scoreboard players operation @s dd_team_one > #legacy_orange dd_ctx
scoreboard players operation @s dd_team_two > #legacy_aqua dd_ctx
