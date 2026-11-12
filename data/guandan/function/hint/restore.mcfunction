scoreboard players operation @s gd_hint = #hint_cursor gd_ctx
execute as @e[tag=gd.cards] if score @s gd_owner = #actor gd_ctx run scoreboard players set @s gd_sel 0
scoreboard players set @e[tag=gd.hint_saved] gd_sel 1
function guandan:game/select_context
