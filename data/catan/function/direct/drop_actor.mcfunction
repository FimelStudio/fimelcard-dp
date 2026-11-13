function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
$execute unless score @s ca_table matches $(table) run return 0
execute if data storage catan:input drop{resource:1b} run return run function catan:direct/resource with storage catan:input drop
execute if data storage catan:input drop{development:1b} run return run function catan:direct/dev_use with storage catan:input drop
$scoreboard players set #code ca_ctx $(action)
execute if score #code ca_ctx matches 1 run return run function catan:direct/q_aim with storage catan:input drop
$execute if data storage catan:input drop{control:1b} unless score @e[tag=ca.current,limit=1] ca_epoch matches $(epoch) run return run function catan:ui/stale
execute if score #code ca_ctx matches 999 run return run function catan:direct/cancel
execute if score #code ca_ctx matches 900..904 run return run function catan:direct/resource_code
execute if score #code ca_ctx matches 998 run return run function catan:direct/undo
execute if score #code ca_ctx matches 210 run return run function catan:direct/bank_begin
execute if score #code ca_ctx matches 200 run return run function catan:direct/trade_begin
execute if score #code ca_ctx matches 501..504 run return run function catan:direct/partner
execute if score #code ca_ctx matches 401..404 run return run function catan:direct/confirm
execute if score #code ca_ctx matches 352..354 run return run function catan:direct/confirm
execute if score #code ca_ctx matches 10 run return run function catan:input/roll
function catan:direct/confirm
