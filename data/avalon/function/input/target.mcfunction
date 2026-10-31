scoreboard players operation #target av_ctx = #action av_ctx
scoreboard players remove #target av_ctx 50
execute as @a[tag=av.audience,scores={av_role=1..3}] if score @s av_seat = #target av_ctx run scoreboard players operation @a[tag=av.actor,limit=1] av_target = #target av_ctx
