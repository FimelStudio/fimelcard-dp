$data modify storage cardtable:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #setting_code ct_ctx $(value)
scoreboard players operation #setting_code ct_ctx += #setting_fieldbase ct_ctx
execute store result storage cardtable:settings code int 1 run scoreboard players get #setting_code ct_ctx
$execute unless score #setting_current ct_ctx matches $(value) run function cardtable:settings/command with storage cardtable:settings
$execute if score #setting_current ct_ctx matches $(value) run data modify storage cardtable:settings option.color set value "gold"
$execute if score #setting_current ct_ctx matches $(value) run data modify storage cardtable:settings option.bold set value true
$data modify storage cardtable:settings field$(field).extra append from storage cardtable:settings option
