$scoreboard players set #ui_code ca_ctx $(code)
scoreboard players operation #ui_code ca_ctx += #ui_base ca_ctx
execute store result storage catan:ui code int 1 run scoreboard players get #ui_code ca_ctx
$data modify storage catan:ui button_name set from entity @e[tag=ca.current,limit=1] data.catan.p$(side).name
function catan:ui/named_append with storage catan:ui
