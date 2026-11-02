# Keep controller position as source; never retarget another table.
scoreboard players operation #sound_table ca_ctx = @s ct_id
execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx run playsound card:catan.city block @s ~ ~ ~ 0.55 1 0
