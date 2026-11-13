function splendor:sound/context
execute if score @s ct_paused matches 1 run return 0
execute as @a[tag=sp.player,tag=ct.player] if score @s sp_table = #sound_table sp_ctx if score @s ct_id = #sound_table sp_ctx at @s run playsound splendor:return block @s ~ ~ ~ 0.37 1 0
