$execute store result score #set_current ma_ctx run data get storage magical_athlete:settings $(key)
$data modify storage magical_athlete:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #set_code ma_ctx $(code)
scoreboard players operation #set_code ma_ctx += #set_base ma_ctx
execute store result storage magical_athlete:settings code int 1 run scoreboard players get #set_code ma_ctx
$execute unless score #set_current ma_ctx matches $(value) run function magical_athlete:settings/command with storage magical_athlete:settings
$execute if score #set_current ma_ctx matches $(value) run data modify storage magical_athlete:settings option.color set value "gold"
$execute if score #set_current ma_ctx matches $(value) run data modify storage magical_athlete:settings option.bold set value true
$data modify storage magical_athlete:settings $(key)_row.extra append from storage magical_athlete:settings option
