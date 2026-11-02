$scoreboard players set #setting_target ct_ctx $(delta)
scoreboard players operation #setting_target ct_ctx += #setting_current ct_ctx
execute if score #setting_target ct_ctx < #setting_low ct_ctx run scoreboard players operation #setting_target ct_ctx = #setting_low ct_ctx
execute if score #setting_target ct_ctx > #setting_high ct_ctx run scoreboard players operation #setting_target ct_ctx = #setting_high ct_ctx
execute if score #setting_target ct_ctx = #setting_current ct_ctx run return 0
$data modify storage cardtable:settings option set value {text:" [$(label)] ",color:"aqua"}
scoreboard players operation #setting_code ct_ctx = #setting_target ct_ctx
scoreboard players operation #setting_code ct_ctx += #setting_fieldbase ct_ctx
execute store result storage cardtable:settings code int 1 run scoreboard players get #setting_code ct_ctx
function cardtable:settings/command with storage cardtable:settings
$data modify storage cardtable:settings field$(field).extra append from storage cardtable:settings option
