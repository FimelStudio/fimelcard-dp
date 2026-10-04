# 第十三版兼容四座与八座；八座实例不得进入会把座位搬回十字布局的旧迁移。
execute unless score @s ct_capacity matches 8 unless data entity @s {data:{cardtable:{menu_version:12}}} run function cardtable:table/migrate_v12
execute unless score @s ct_capacity matches 8 run scoreboard players set @s ct_capacity 4
data merge entity @s {data:{cardtable:{menu_version:13}}}
execute if score @s ct_state matches 0 run function cardtable:menu/render
function cardtable:rules/render
execute if score @s ct_state matches 1 run function cardtable:vote/render
