$execute store result score #setting_current ac_ctx run data get storage aeroplane_chess:settings $(key)
$data modify storage aeroplane_chess:settings option set value {text:" [$(label)] ",color:"aqua"}
$scoreboard players set #setting_code ac_ctx $(code)
scoreboard players operation #setting_code ac_ctx += #setting_base ac_ctx
execute store result storage aeroplane_chess:settings code int 1 run scoreboard players get #setting_code ac_ctx
$execute unless score #setting_current ac_ctx matches $(value) run function aeroplane_chess:settings/command with storage aeroplane_chess:settings
$execute if score #setting_current ac_ctx matches $(value) run data modify storage aeroplane_chess:settings option.color set value "gold"
$execute if score #setting_current ac_ctx matches $(value) run data modify storage aeroplane_chess:settings option.bold set value true
$data modify storage aeroplane_chess:settings $(key)_row.extra append from storage aeroplane_chess:settings option
