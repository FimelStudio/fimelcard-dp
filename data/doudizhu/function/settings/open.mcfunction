function doudizhu:game/init_table
execute store result storage doudizhu:settings initial int 1 run scoreboard players get @s dd_max
scoreboard players operation @a[tag=ct.settings_actor,limit=1] dd_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] dd_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] dd_settings
# 保留给对话框提交时展开的输入占位符。
data modify storage doudizhu:settings rounds set value "$(rounds)"
data modify storage doudizhu:settings music set value "$(music)"
data modify storage doudizhu:settings enabled set value false
data modify storage doudizhu:settings disabled set value false
execute if score @s dd_audio matches 1 run data modify storage doudizhu:settings enabled set value true
execute if score @s dd_audio matches 0 run data modify storage doudizhu:settings disabled set value true
data modify storage doudizhu:settings mode set value "$(mode)"
data modify storage doudizhu:settings score_mode set value false
data modify storage doudizhu:settings rob_mode set value false
data modify storage doudizhu:settings speed_mode set value false
execute if score @s dd_bidmode matches 0 run data modify storage doudizhu:settings score_mode set value true
execute if score @s dd_bidmode matches 1 run data modify storage doudizhu:settings rob_mode set value true
execute if score @s dd_bidmode matches 2 run data modify storage doudizhu:settings speed_mode set value true
data modify storage doudizhu:settings counts set value "$(counts)"
data modify storage doudizhu:settings counts_on set value true
data modify storage doudizhu:settings counts_off set value false
execute if score @s dd_counts matches 0 run data modify storage doudizhu:settings counts_on set value false
execute if score @s dd_counts matches 0 run data modify storage doudizhu:settings counts_off set value true
data modify storage doudizhu:settings counter set value "$(counter)"
data modify storage doudizhu:settings counter_on set value false
data modify storage doudizhu:settings counter_off set value true
execute if score @s dd_counter matches 1 run data modify storage doudizhu:settings counter_on set value true
execute if score @s dd_counter matches 1 run data modify storage doudizhu:settings counter_off set value false
data modify storage doudizhu:settings shuffle set value "$(shuffle)"
data modify storage doudizhu:settings shuffled set value true
data modify storage doudizhu:settings unshuffled set value false
execute if score @s dd_noshuffle matches 1 run data modify storage doudizhu:settings shuffled set value false
execute if score @s dd_noshuffle matches 1 run data modify storage doudizhu:settings unshuffled set value true
function doudizhu:settings/show with storage doudizhu:settings
