scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players set #online cp_ctx 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players add #online cp_ctx 1
execute if score #online cp_ctx matches 0 run function critical_point:game/abort
