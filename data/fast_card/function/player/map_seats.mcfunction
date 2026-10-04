# 按实际座位顺时针建立四人内部编号，通用ct_seat保持原位。
scoreboard players set #mapped fc_ctx 0
execute as @a[tag=fc.player,scores={ct_seat=1}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=2}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=3}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=4}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=5}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=6}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=7}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
execute as @a[tag=fc.player,scores={ct_seat=8}] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/map_one
