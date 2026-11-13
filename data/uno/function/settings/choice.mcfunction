$execute store result score #ui_setting_current un_ctx run data get storage uno:settings $(key)
$data modify storage uno:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code un_ctx $(code)
scoreboard players operation #ui_setting_code un_ctx += #ui_setting_base un_ctx
execute store result storage uno:settings code int 1 run scoreboard players get #ui_setting_code un_ctx
$execute unless score #ui_setting_current un_ctx matches $(value) run function uno:settings/command with storage uno:settings
$execute if score #ui_setting_current un_ctx matches $(value) run data modify storage uno:settings option.color set value "gold"
$execute if score #ui_setting_current un_ctx matches $(value) run data modify storage uno:settings option.bold set value true
$data modify storage uno:settings $(row).extra append from storage uno:settings option
