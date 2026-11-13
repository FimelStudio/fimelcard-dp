scoreboard players operation #vis_table ma_ctx = @s ct_id
execute as @e[tag=ma.visual] if score @s ct_id = #vis_table ma_ctx run kill @s
scoreboard players set @s ma_vtimer 0
scoreboard players set @s ma_vframe 0
# direct-v2
execute as @e[tag=ma.direct] if score @s ct_id = #vis_table ma_ctx run kill @s
