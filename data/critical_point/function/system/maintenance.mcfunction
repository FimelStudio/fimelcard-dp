scoreboard players operation #ctx cp_ctx = @s cp_id
scoreboard players set #online cp_ctx 0
execute as @a[tag=cp.player] if score @s cp_id = #ctx cp_ctx run scoreboard players add #online cp_ctx 1
# 开局安全线固定为3×人数+2，用其还原人数，避免大厅人数刷新掩盖离线。
scoreboard players operation #expected cp_ctx = @s cp_threshold
scoreboard players remove #expected cp_ctx 2
scoreboard players operation #expected cp_ctx /= #three cp_ctx
execute unless score #online cp_ctx = #expected cp_ctx run function critical_point:game/abort
