scoreboard players set @s go_bconfirm 0
scoreboard players set @s go_wconfirm 0
execute if score @s go_bot matches 1 run scoreboard players set @s go_bconfirm 1
execute if score @s go_bot matches -1 run scoreboard players set @s go_wconfirm 1
scoreboard players add @s go_epoch 1
