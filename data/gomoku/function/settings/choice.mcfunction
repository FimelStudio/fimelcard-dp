$execute store result score #ui_setting_current gm_ctx run data get storage gomoku:settings $(key)
$data modify storage gomoku:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #ui_setting_code gm_ctx $(code)
scoreboard players operation #ui_setting_code gm_ctx += #ui_setting_base gm_ctx
execute store result storage gomoku:settings code int 1 run scoreboard players get #ui_setting_code gm_ctx
$execute unless score #ui_setting_current gm_ctx matches $(value) run function gomoku:settings/command with storage gomoku:settings
$execute if score #ui_setting_current gm_ctx matches $(value) run data modify storage gomoku:settings option.color set value "gold"
$execute if score #ui_setting_current gm_ctx matches $(value) run data modify storage gomoku:settings option.bold set value true
$data modify storage gomoku:settings $(row).extra append from storage gomoku:settings option
