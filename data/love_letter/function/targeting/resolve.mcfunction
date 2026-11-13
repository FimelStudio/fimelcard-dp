function love_letter:targeting/scan
scoreboard players set #blocked ll_ctx 0
execute unless score @s ll_aimepoch = @s ll_epoch run scoreboard players set @s ll_aim 0
execute unless score @s ll_aimepoch = @s ll_epoch run scoreboard players set @s ll_aimttl 0
scoreboard players operation @s ll_aimepoch = @s ll_epoch
# 受保护与已出局的身体仍可命中，但不能留下旧目标误打另一人。
scoreboard players set #aim_legal ll_ctx 0
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] if score @s ll_seat = #aim ll_ctx run scoreboard players set #aim_legal ll_ctx 1
execute if score #aim ll_ctx matches 1..8 unless score #aim_legal ll_ctx matches 1 run scoreboard players set @s ll_aim 0
execute if score #aim ll_ctx matches 1..8 unless score #aim_legal ll_ctx matches 1 run scoreboard players set @s ll_aimttl 0
execute if score #aim ll_ctx matches 1..8 unless score #aim_legal ll_ctx matches 1 run scoreboard players set #blocked ll_ctx 1
execute if score #blocked ll_ctx matches 1 run scoreboard players set #aim ll_ctx 0
execute if score #blocked ll_ctx matches 1 run return 0
execute if score #pitch ll_ctx matches 50.. run scoreboard players set @s ll_aim 0
execute if score #pitch ll_ctx matches 50.. run scoreboard players set @s ll_aimttl 0
execute if score #aim ll_ctx matches 1..8 run scoreboard players operation @s ll_aim = #aim ll_ctx
execute if score #aim ll_ctx matches 1..8 run scoreboard players set @s ll_aimttl 60
scoreboard players set #remember_legal ll_ctx 0
scoreboard players operation #remember ll_ctx = @s ll_aim
execute as @e[tag=ll.board,scores={ll_alive=1,ll_protect=0}] if score @s ll_seat = #remember ll_ctx run scoreboard players set #remember_legal ll_ctx 1
execute unless score #remember_legal ll_ctx matches 1 run scoreboard players set @s ll_aim 0
execute unless score @s ll_aimttl matches 1.. run scoreboard players set @s ll_aim 0
scoreboard players operation #aim ll_ctx = @s ll_aim
