# 再次校正缺失或越界的旧牌桌设置，然后把当前值写入dialog宏参数
function fast_card:game/init_table
execute store result storage fast_card:settings_dialog rounds_initial int 1 run scoreboard players get @s fc_max
data modify storage fast_card:settings_dialog false_press_initial set value "false"
execute if score @s fc_rule matches 1 run data modify storage fast_card:settings_dialog false_press_initial set value "true"

# 把打开设置时的牌桌编号暂存在玩家身上，并仅向该玩家开放一次trigger
scoreboard players operation @a[tag=ct.settings_actor,limit=1] fc_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] fc_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] fc_settings

# 宏套宏：外层函数先把这两个值展开回dialog自己的输入占位符
data modify storage fast_card:settings_dialog rounds set value "$(rounds)"
data modify storage fast_card:settings_dialog false_press_penalty set value "$(false_press_penalty)"
function fast_card:settings/open_dialog with storage fast_card:settings_dialog
data remove storage fast_card:settings_dialog rounds_initial
data remove storage fast_card:settings_dialog false_press_initial
data remove storage fast_card:settings_dialog rounds
data remove storage fast_card:settings_dialog false_press_penalty
