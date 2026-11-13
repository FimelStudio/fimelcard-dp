$execute store result score #ui_setting_current xq_ctx run data get storage xiangqi:settings $(key)
$data modify storage xiangqi:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code xq_ctx $(code)
scoreboard players operation #ui_setting_code xq_ctx += #ui_setting_base xq_ctx
execute store result storage xiangqi:settings code int 1 run scoreboard players get #ui_setting_code xq_ctx
$execute unless score #ui_setting_current xq_ctx matches $(value) run function xiangqi:settings/command with storage xiangqi:settings
$execute if score #ui_setting_current xq_ctx matches $(value) run data modify storage xiangqi:settings option.color set value "gold"
$execute if score #ui_setting_current xq_ctx matches $(value) run data modify storage xiangqi:settings option.bold set value true
$data modify storage xiangqi:settings $(row).extra append from storage xiangqi:settings option
