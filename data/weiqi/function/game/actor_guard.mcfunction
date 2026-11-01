function weiqi:system/context
scoreboard players set #actor_ok go_ctx 0
execute as @a[tag=go.actor,tag=go.audience,limit=1] if score @s go_table = #table go_ctx if score @s go_side matches -1..1 unless score @s go_side matches 0 run scoreboard players set #actor_ok go_ctx 1
