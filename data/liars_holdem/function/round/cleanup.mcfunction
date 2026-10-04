# 清理当前桌的上一局内容；通用牌桌、座椅和其他游戏不受影响
scoreboard players operation #ctx_id lh_ctx = @s lh_id
function liars_holdem:transition/cleanup
function cardtable:animation/deal/clear
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:util/clear_items
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run dialog clear @s
# 兼容清理旧版因高度选择范围错误而未获得标签和记分的公共牌
kill @e[type=minecraft:item_display,nbt={data:{liars_holdem:{new_community:1b}}},distance=..4]
# 公共牌按接入规范同时校验lh.community和本桌lh_id，不依赖最近实体
execute as @e[type=minecraft:item_display,tag=lh.community] if score @s lh_id = #ctx_id lh_ctx run kill @s
# 八人单列摊牌可高于4格，清理只按本游戏标签和桌号限定，不能按距离漏掉高行。
execute as @e[tag=lh.game_entity] if score @s lh_id = #ctx_id lh_ctx run kill @s
execute as @e[type=minecraft:item,distance=..4] run function liars_holdem:util/kill_if_item
