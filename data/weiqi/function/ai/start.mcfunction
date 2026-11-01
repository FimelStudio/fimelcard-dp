function weiqi:system/context
function weiqi:ai/reset
scoreboard players set @s go_aistate 1
scoreboard players operation @s go_aiepoch = @s go_epoch
scoreboard players set @e[tag=go.board] go_tested 0
scoreboard players set @s go_aimoves 14
execute if score @s go_level matches 2 run scoreboard players set @s go_aimoves 28
execute if score @s go_level matches 3 run scoreboard players set @s go_aimoves 48
