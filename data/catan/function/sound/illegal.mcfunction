# Keep controller position as source; never retarget another table.
execute if entity @s[type=minecraft:player] run return run function catan:sound/illegal_player
scoreboard players operation #sound_table ca_ctx = @s ct_id
execute at @s positioned ~ ~1 ~ as @a[tag=ca.player,tag=ct.player,tag=ca.actor] if score @s ca_table = #sound_table ca_ctx if score @s ct_id = #sound_table ca_ctx run playsound card:catan.illegal block @s ~ ~ ~ 0.35 1 0
