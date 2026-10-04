# 普通创建模式：放置桌面结构，再生成座位交互及椅子展示实体。
# 仅新建四人桌使用新模板；重载及座位修复不调用本函数。
execute unless score @s ct_capacity matches 8 run place template cardtable:table4_display ~-2 ~ ~-2 none none 1.0 0 strict
execute if score @s ct_capacity matches 8 run place template cardtable:table8 ~-3 ~ ~-3 none none 1.0 0 strict
function cardtable:table/spawn_seats
execute unless score @s ct_capacity matches 8 run function cardtable:table/spawn_chairs4
