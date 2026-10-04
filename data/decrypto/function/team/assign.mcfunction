# 实际座位按1至8顺时针排序，前半为白队、后半为黑队；奇数人数白队多一人。
scoreboard players operation #white_size dc_ctx = @s ct_joined
scoreboard players add #white_size dc_ctx 1
scoreboard players set #two dc_ctx 2
scoreboard players operation #white_size dc_ctx /= #two dc_ctx
scoreboard players set #order dc_ctx 0
execute as @a[tag=dc.player,scores={ct_seat=1}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=2}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=3}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=4}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=5}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=6}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=7}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
execute as @a[tag=dc.player,scores={ct_seat=8}] if score @s dc_id = #ctx dc_ctx run function decrypto:team/assign_one
