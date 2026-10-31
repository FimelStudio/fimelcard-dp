scoreboard players set @a[tag=gm.audience] gm_side -1
execute as @a[tag=gm.audience] if score @s gm_weight matches 1 run scoreboard players set @s gm_side 1
