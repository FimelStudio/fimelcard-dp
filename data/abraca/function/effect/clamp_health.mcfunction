scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 7.. run scoreboard players set @s ab_hp 6
