scoreboard players set @a[tag=xq.audience] xq_side -1
execute as @a[tag=xq.audience] if score @s xq_weight matches 1 run scoreboard players set @s xq_side 1
