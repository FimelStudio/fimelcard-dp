# 当前执行者是权威手牌标记；真实牌值写入custom_data，外观只反映玩家已获得的提示
function hanabi:card/load_definition
scoreboard players operation #hotbar hb_ctx = @s hb_slot
scoreboard players remove #hotbar hb_ctx 1

execute store result storage hanabi:item table int 1 run scoreboard players get @s hb_id
execute store result storage hanabi:item id int 1 run scoreboard players get @s hb_card
execute store result storage hanabi:item seat int 1 run scoreboard players get @s hb_seat
execute store result storage hanabi:item slot int 1 run scoreboard players get @s hb_slot
execute store result storage hanabi:item hotbar int 1 run scoreboard players get #hotbar hb_ctx
execute store result storage hanabi:item color int 1 run scoreboard players get @s hb_color
execute store result storage hanabi:item rank int 1 run scoreboard players get @s hb_rank
execute store result storage hanabi:item known_color int 1 run scoreboard players get @s hb_known_c
execute store result storage hanabi:item known_rank int 1 run scoreboard players get @s hb_known_n
execute store result storage hanabi:item reward int 1 run scoreboard players get @s hb_reward

data modify storage hanabi:item model set value "card:hanabi/back"
data modify storage hanabi:item name set value "未知的花火牌（F出牌／Q弃牌）"

execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 1 run data modify storage hanabi:item model set value "card:hanabi/w_color"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 1 run data modify storage hanabi:item name set value "白色花火牌·数字未知（F出牌／Q弃牌）"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 2 run data modify storage hanabi:item model set value "card:hanabi/r_color"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 2 run data modify storage hanabi:item name set value "红色花火牌·数字未知（F出牌／Q弃牌）"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 3 run data modify storage hanabi:item model set value "card:hanabi/b_color"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 3 run data modify storage hanabi:item name set value "蓝色花火牌·数字未知（F出牌／Q弃牌）"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 4 run data modify storage hanabi:item model set value "card:hanabi/y_color"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 4 run data modify storage hanabi:item name set value "黄色花火牌·数字未知（F出牌／Q弃牌）"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 5 run data modify storage hanabi:item model set value "card:hanabi/g_color"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 5 run data modify storage hanabi:item name set value "绿色花火牌·数字未知（F出牌／Q弃牌）"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 6 run data modify storage hanabi:item model set value "card:hanabi/m_color"
execute if score @s hb_known_c matches 1 unless score @s hb_known_n matches 1 if score @s hb_color matches 6 run data modify storage hanabi:item name set value "彩色花火牌·数字未知（F出牌／Q弃牌）"

execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 1 run data modify storage hanabi:item model set value "card:hanabi/n_1"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 1 run data modify storage hanabi:item name set value "数字1花火牌·颜色未知（F出牌／Q弃牌）"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 2 run data modify storage hanabi:item model set value "card:hanabi/n_2"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 2 run data modify storage hanabi:item name set value "数字2花火牌·颜色未知（F出牌／Q弃牌）"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 3 run data modify storage hanabi:item model set value "card:hanabi/n_3"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 3 run data modify storage hanabi:item name set value "数字3花火牌·颜色未知（F出牌／Q弃牌）"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 4 run data modify storage hanabi:item model set value "card:hanabi/n_4"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 4 run data modify storage hanabi:item name set value "数字4花火牌·颜色未知（F出牌／Q弃牌）"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 5 run data modify storage hanabi:item model set value "card:hanabi/n_5"
execute unless score @s hb_known_c matches 1 if score @s hb_known_n matches 1 if score @s hb_rank matches 5 run data modify storage hanabi:item name set value "数字5花火牌·颜色未知（F出牌／Q弃牌）"

execute if score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:item model set from storage hanabi:card def.model
execute if score @s hb_known_c matches 1 if score @s hb_known_n matches 1 run data modify storage hanabi:item name set from storage hanabi:card def.name

# 道具牌属于公开信息，持有者也能直接辨认；F使用，Q仍按普通弃牌处理
execute if score @s hb_reward matches 1 run data modify storage hanabi:item model set value "card:hanabi/tool_hint"
execute if score @s hb_reward matches 1 run data modify storage hanabi:item name set value "提示牌（F使用／Q弃牌）"
execute if score @s hb_reward matches 2 run data modify storage hanabi:item model set value "card:hanabi/tool_restore"
execute if score @s hb_reward matches 2 run data modify storage hanabi:item name set value "恢复牌（F使用／Q弃牌）"
function hanabi:hand/place_item with storage hanabi:item
