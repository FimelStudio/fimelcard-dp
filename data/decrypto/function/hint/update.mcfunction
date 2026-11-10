function decrypto:player/audience
tag @e[tag=dc.guess_table] remove dc.guess_table
tag @s add dc.guess_table
scoreboard players set #hint_changed dc_ctx 0
execute as @a[tag=dc.audience] run function decrypto:hint/player
execute if score #hint_changed dc_ctx matches 1 run function decrypto:title/render_all
