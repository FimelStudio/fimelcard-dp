$execute store result score #set_current sp_ctx run data get storage splendor:settings $(key)
$data modify storage splendor:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #set_code sp_ctx $(code)
scoreboard players operation #set_code sp_ctx += #set_base sp_ctx
execute store result storage splendor:settings code int 1 run scoreboard players get #set_code sp_ctx
$execute unless score #set_current sp_ctx matches $(value) run function splendor:settings/command with storage splendor:settings
$execute if score #set_current sp_ctx matches $(value) run data modify storage splendor:settings option.color set value "gold"
$execute if score #set_current sp_ctx matches $(value) run data modify storage splendor:settings option.bold set value true
$data modify storage splendor:settings $(key)_row.extra append from storage splendor:settings option
