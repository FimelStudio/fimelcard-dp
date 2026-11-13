function splendor:direct/reset
scoreboard players operation @s sp_select_id = @s sp_target
scoreboard players operation @s sp_select_kind = #select_kind sp_ctx
scoreboard players set @s sp_select_stage 1
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
