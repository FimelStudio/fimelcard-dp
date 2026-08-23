scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx at @s run playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 0.7 1.15
