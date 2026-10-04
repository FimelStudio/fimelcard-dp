# 执行者及位置为牌桌控制器；直接初始化新实体，不通过附近实体反查。
function cardtable:animation/deal/box/cleanup_legacy
scoreboard players operation #deal_box_owner ct_ctx = @s ct_id
execute positioned ~ ~1.4 ~ summon minecraft:item_display run function cardtable:animation/deal/box/init
