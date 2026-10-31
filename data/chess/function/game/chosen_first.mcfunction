scoreboard players set @a[tag=ch.audience] ch_side -1
execute as @a[tag=ch.audience] if score @s ch_weight matches 1 run scoreboard players set @s ch_side 1
