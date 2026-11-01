scoreboard players set @s go_bot 0
execute if score @s ct_joined matches 1 run return run function weiqi:game/solo_sides
scoreboard players set @a[tag=go.audience] go_side -1
execute if score @s go_first matches 0 run scoreboard players set @a[tag=go.audience,sort=random,limit=1] go_side 1
execute if score @s go_first matches 1 as @a[tag=go.audience] if score @s go_weight matches 1 run scoreboard players set @s go_side 1
