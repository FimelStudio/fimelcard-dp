# 校正旧牌桌或缺失的设置，并把当前值写入dialog宏参数。
execute unless score @s dc_round_limit matches 1..32 run scoreboard players set @s dc_round_limit 8
execute store result storage decrypto:settings_dialog rounds_initial int 1 run scoreboard players get @s dc_round_limit

# 记录打开设置时的牌桌，保存时再次校验玩家与牌桌状态。
scoreboard players operation @a[tag=ct.settings_actor,limit=1] dc_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] dc_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] dc_settings

# 宏套宏：外层先把动态对话框提交时才会使用的输入占位符原样展开回去。
data modify storage decrypto:settings_dialog rounds set value "$(rounds)"
function decrypto:settings/open_dialog with storage decrypto:settings_dialog
data remove storage decrypto:settings_dialog rounds_initial
data remove storage decrypto:settings_dialog rounds
