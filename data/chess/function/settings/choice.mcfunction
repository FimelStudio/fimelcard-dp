$execute store result score #ui_setting_current ch_ctx run data get storage chess:settings $(key)
$data modify storage chess:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code ch_ctx $(code)
scoreboard players operation #ui_setting_code ch_ctx += #ui_setting_base ch_ctx
execute store result storage chess:settings code int 1 run scoreboard players get #ui_setting_code ch_ctx
$execute unless score #ui_setting_current ch_ctx matches $(value) run function chess:settings/command with storage chess:settings
$execute if score #ui_setting_current ch_ctx matches $(value) run data modify storage chess:settings option.color set value "gold"
$execute if score #ui_setting_current ch_ctx matches $(value) run data modify storage chess:settings option.bold set value true
$data modify storage chess:settings $(row).extra append from storage chess:settings option
