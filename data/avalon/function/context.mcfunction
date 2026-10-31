scoreboard players operation #table av_ctx = @s av_id
tag @a[tag=av.audience] remove av.audience
execute as @a[tag=av.player,tag=ct.player] if score @s av_id = #table av_ctx if score @s ct_id = #table av_ctx run tag @s add av.audience
