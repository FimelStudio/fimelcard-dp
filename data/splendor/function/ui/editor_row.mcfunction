# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code sp_ctx $(minus)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui minus int 1 run scoreboard players get #ui_code sp_ctx
$scoreboard players set #ui_code sp_ctx $(plus)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui plus int 1 run scoreboard players get #ui_code sp_ctx
$data modify storage splendor:ui row_name set value "$(name)"
function splendor:ui/row_append with storage splendor:ui
