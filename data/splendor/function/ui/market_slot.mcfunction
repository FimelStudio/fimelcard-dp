# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$data modify storage splendor:ui icon_id set from entity @e[tag=sp.current,limit=1] data.splendor.market[$(slot)]
$scoreboard players set #ui_code sp_ctx $(code)
scoreboard players operation #ui_code sp_ctx += #ui_base sp_ctx
execute store result storage splendor:ui code int 1 run scoreboard players get #ui_code sp_ctx
function splendor:ui/market_icon with storage splendor:ui
