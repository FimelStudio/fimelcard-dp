$execute store result score #setting_current ll_ctx run data get storage love_letter:settings $(key)
$scoreboard players set #setting_code ll_ctx $(code)
scoreboard players operation #setting_code ll_ctx += #setting_base ll_ctx
execute store result storage love_letter:settings code int 1 run scoreboard players get #setting_code ll_ctx
$data modify storage love_letter:settings option set value {text:" [$(label)] ",color:"aqua"}
$execute if score #setting_current ll_ctx matches $(value) run data modify storage love_letter:settings option.color set value "gold"
$execute if score #setting_current ll_ctx matches $(value) run data modify storage love_letter:settings option.bold set value true
$execute unless score #setting_current ll_ctx matches $(value) run function love_letter:settings/command with storage love_letter:settings
$data modify storage love_letter:settings $(key)_row.extra append from storage love_letter:settings option
