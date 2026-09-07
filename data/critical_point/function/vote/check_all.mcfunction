scoreboard players set #locked cp_ctx 0
execute as @a[tag=cp.player,scores={cp_locked=1}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #locked cp_ctx 1
execute if score #locked cp_ctx = @s ct_joined run function critical_point:vote/resolve

