scoreboard players operation #table ma_ctx = @s ct_id
tag @e[tag=ma.current] remove ma.current
tag @a[tag=ma.audience] remove ma.audience
tag @s add ma.current
execute as @a[tag=ma.player,tag=ct.player] if score @s ma_table = #table ma_ctx if score @s ct_id = #table ma_ctx run tag @s add ma.audience
