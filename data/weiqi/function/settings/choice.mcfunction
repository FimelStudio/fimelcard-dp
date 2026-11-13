$execute store result score #ui_setting_current go_ctx run data get storage weiqi:settings $(key)
$data modify storage weiqi:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code go_ctx $(code)
scoreboard players operation #ui_setting_code go_ctx += #ui_setting_base go_ctx
execute store result storage weiqi:settings code int 1 run scoreboard players get #ui_setting_code go_ctx
$execute unless score #ui_setting_current go_ctx matches $(value) run function weiqi:settings/command with storage weiqi:settings
$execute if score #ui_setting_current go_ctx matches $(value) run data modify storage weiqi:settings option.color set value "gold"
$execute if score #ui_setting_current go_ctx matches $(value) run data modify storage weiqi:settings option.bold set value true
$data modify storage weiqi:settings $(row).extra append from storage weiqi:settings option
