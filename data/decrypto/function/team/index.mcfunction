# 给本队成员建立稳定的零起始轮换编号；不依赖空座数量。
scoreboard players operation #ctx dc_ctx = @s dc_id
scoreboard players set #white_count dc_ctx 0
scoreboard players set #black_count dc_ctx 0
execute as @a[tag=dc.player,scores={ct_seat=1}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=2}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=3}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=4}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=5}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=6}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=7}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={ct_seat=8}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/index_one
execute as @a[tag=dc.player,scores={dc_team=1}] if score @s dc_id = #ctx dc_ctx run scoreboard players operation @s dc_size = #white_count dc_ctx
execute as @a[tag=dc.player,scores={dc_team=2}] if score @s dc_id = #ctx dc_ctx run scoreboard players operation @s dc_size = #black_count dc_ctx
