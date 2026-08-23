scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx at @s run playsound minecraft:block.powder_snow.step master @s ~ ~ ~ 0.75 0.8
