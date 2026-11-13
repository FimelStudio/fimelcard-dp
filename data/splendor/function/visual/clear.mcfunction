function splendor:visual/context
execute as @e[tag=sp.visual] if score @s sp_table = #vis_table sp_ctx run kill @s
scoreboard players set @s sp_vtimer 0
scoreboard players set @s sp_vstep 0
data remove entity @s data.splendor.visual_active
