scoreboard players operation #ctx ab_ctx = @s ab_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx at @s run playsound minecraft:entity.lightning_bolt.thunder master @s ~ ~ ~ 0.45 1.4
