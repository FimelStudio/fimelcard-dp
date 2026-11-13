scoreboard players operation #sound_table ma_ctx = @s ct_id
tag @a[tag=ma.sound_audience] remove ma.sound_audience
execute as @a[tag=ma.player,tag=ct.player] if score @s ma_table = #sound_table ma_ctx if score @s ct_id = #sound_table ma_ctx run tag @s add ma.sound_audience
