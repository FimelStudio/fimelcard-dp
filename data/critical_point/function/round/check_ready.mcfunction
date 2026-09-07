scoreboard players set #ready cp_ctx 0
execute as @a[tag=cp.player,scores={cp_ready=1}] if score @s cp_id = #ctx cp_ctx run scoreboard players add #ready cp_ctx 1
execute if score #ready cp_ctx = @s ct_joined run function critical_point:round/next

