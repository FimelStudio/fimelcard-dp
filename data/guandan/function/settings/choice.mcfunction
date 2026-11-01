$execute store result score #setting_current gd_ctx run data get storage guandan:settings $(key)
$scoreboard players set #setting_code gd_ctx $(code)
scoreboard players operation #setting_code gd_ctx += #setting_base gd_ctx
execute store result storage guandan:settings code int 1 run scoreboard players get #setting_code gd_ctx
$data modify storage guandan:settings option set value {text:" [$(label)] ",color:"aqua"}
$execute if score #setting_current gd_ctx matches $(value) run data modify storage guandan:settings option.color set value "gold"
$execute if score #setting_current gd_ctx matches $(value) run data modify storage guandan:settings option.bold set value true
$execute unless score #setting_current gd_ctx matches $(value) run function guandan:settings/command with storage guandan:settings
$data modify storage guandan:settings $(key)_row.extra append from storage guandan:settings option
