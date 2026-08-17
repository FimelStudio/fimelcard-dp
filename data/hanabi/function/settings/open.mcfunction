# 校正旧牌桌默认值并把当前配置写入Dialog宏参数
function hanabi:game/init_table
execute store result storage hanabi:settings_dialog clues_initial int 1 run scoreboard players get @s hb_clue_max
execute store result storage hanabi:settings_dialog strikes_initial int 1 run scoreboard players get @s hb_strike_max
data modify storage hanabi:settings_dialog storm_initial set value "false"
execute if score @s hb_storm matches 1 run data modify storage hanabi:settings_dialog storm_initial set value "true"

# 记录打开设置时的牌桌编号；普通玩家只获得一次保存trigger权限
scoreboard players operation @a[tag=ct.settings_actor,limit=1] hb_set_table = @s ct_id
scoreboard players set @a[tag=ct.settings_actor,limit=1] hb_settings 0
scoreboard players enable @a[tag=ct.settings_actor,limit=1] hb_settings

# 提交值编码为：彩色风暴位、失误位、提示上限；奖励牌固定为独立六张，不属于设置
data modify storage hanabi:settings_dialog clues set value "$(clues)"
data modify storage hanabi:settings_dialog strikes set value "$(strikes)"
data modify storage hanabi:settings_dialog storm set value "$(storm)"
function hanabi:settings/open_dialog with storage hanabi:settings_dialog
data remove storage hanabi:settings_dialog clues_initial
data remove storage hanabi:settings_dialog strikes_initial
data remove storage hanabi:settings_dialog storm_initial
data remove storage hanabi:settings_dialog clues
data remove storage hanabi:settings_dialog strikes
data remove storage hanabi:settings_dialog storm
