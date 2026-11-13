$data modify storage cardtable:chairs option set value {text:" [$(count)] ",color:"aqua"}
$scoreboard players set #chair_code ct_ctx $(count)
scoreboard players operation #chair_code ct_ctx += #chair_base ct_ctx
execute store result storage cardtable:chairs code int 1 run scoreboard players get #chair_code ct_ctx
$execute if score @s ct_chairs matches $(count) run data modify storage cardtable:chairs option.color set value "gold"
$execute if score @s ct_chairs matches $(count) run data modify storage cardtable:chairs option.bold set value true
$execute unless score @s ct_chairs matches $(count) run function cardtable:chairs/settings/command with storage cardtable:chairs
data modify storage cardtable:chairs row.extra append from storage cardtable:chairs option
