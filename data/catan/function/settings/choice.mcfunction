$execute store result score #set_current ca_ctx run data get storage catan:settings $(key)
$data modify storage catan:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #set_code ca_ctx $(code)
scoreboard players operation #set_code ca_ctx += #set_base ca_ctx
execute store result storage catan:settings code int 1 run scoreboard players get #set_code ca_ctx
$execute unless score #set_current ca_ctx matches $(value) run function catan:settings/command with storage catan:settings
$execute if score #set_current ca_ctx matches $(value) run data modify storage catan:settings option.color set value "gold"
$execute if score #set_current ca_ctx matches $(value) run data modify storage catan:settings option.bold set value true
$data modify storage catan:settings $(key)_row.extra append from storage catan:settings option
