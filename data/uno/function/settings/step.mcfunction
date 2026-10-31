$execute store result score #ui_setting_current un_ctx run data get storage uno:settings $(key)
scoreboard players operation #ui_setting_value un_ctx = #ui_setting_current un_ctx
$scoreboard players set #ui_setting_delta un_ctx $(delta)
scoreboard players operation #ui_setting_value un_ctx += #ui_setting_delta un_ctx
$execute if score #ui_setting_value un_ctx matches ..$(min) run scoreboard players set #ui_setting_value un_ctx $(min)
$execute if score #ui_setting_value un_ctx matches $(max).. run scoreboard players set #ui_setting_value un_ctx $(max)
$data modify storage uno:settings option set value {text:" [$(label)] ",color:"aqua"}
scoreboard players operation #ui_setting_code un_ctx = #ui_setting_base un_ctx
$scoreboard players add #ui_setting_code un_ctx $(offset)
scoreboard players operation #ui_setting_code un_ctx += #ui_setting_value un_ctx
execute store result storage uno:settings code int 1 run scoreboard players get #ui_setting_code un_ctx
execute unless score #ui_setting_value un_ctx = #ui_setting_current un_ctx run function uno:settings/command with storage uno:settings
execute if score #ui_setting_value un_ctx = #ui_setting_current un_ctx run data modify storage uno:settings option.color set value "dark_gray"
$data modify storage uno:settings $(row).extra append from storage uno:settings option
