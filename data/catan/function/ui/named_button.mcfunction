# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
$scoreboard players set #ui_code ca_ctx $(code)
scoreboard players operation #ui_code ca_ctx += #ui_base ca_ctx
execute store result storage catan:ui code int 1 run scoreboard players get #ui_code ca_ctx
$data modify storage catan:ui button_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(side).name
function catan:ui/named_append with storage catan:ui
