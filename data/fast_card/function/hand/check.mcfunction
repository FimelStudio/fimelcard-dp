# 结果：0为无效，1为四张同点数，2为三张同点数加小丑牌，3为四张同点数加小丑牌
# 直接按custom_data中的点数统计整个物品栏，避免逐格扫描快捷栏
scoreboard players set @s fc_result 0
execute store result score @s fc_aux run clear @s minecraft:paper[minecraft:custom_data~{fast_card:{card:1b,rank:0}}] 0

# 依次检查10、J、Q、K；每种点数都先检查超级牌型，避免被普通四张牌提前截获
execute store result score @s fc_count run clear @s minecraft:paper[minecraft:custom_data~{fast_card:{card:1b,rank:10}}] 0
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 3
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. run scoreboard players set @s fc_result 1
execute if score @s fc_result matches 0 if score @s fc_count matches 3.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 2

execute store result score @s fc_count run clear @s minecraft:paper[minecraft:custom_data~{fast_card:{card:1b,rank:11}}] 0
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 3
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. run scoreboard players set @s fc_result 1
execute if score @s fc_result matches 0 if score @s fc_count matches 3.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 2

execute store result score @s fc_count run clear @s minecraft:paper[minecraft:custom_data~{fast_card:{card:1b,rank:12}}] 0
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 3
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. run scoreboard players set @s fc_result 1
execute if score @s fc_result matches 0 if score @s fc_count matches 3.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 2

execute store result score @s fc_count run clear @s minecraft:paper[minecraft:custom_data~{fast_card:{card:1b,rank:13}}] 0
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 3
execute if score @s fc_result matches 0 if score @s fc_count matches 4.. run scoreboard players set @s fc_result 1
execute if score @s fc_result matches 0 if score @s fc_count matches 3.. if score @s fc_aux matches 1.. run scoreboard players set @s fc_result 2

# 把结果交还给控制器分支
scoreboard players operation #hand fc_ctx = @s fc_result
