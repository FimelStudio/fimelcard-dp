# 第十版牌桌：规则介绍从投票模块拆分为牌桌常驻通用界面
execute unless data entity @s {data:{cardtable:{menu_version:9}}} run function cardtable:table/migrate_v9

# 清理旧版混合界面并按当前状态重建，再独立生成常驻规则按钮
execute if score @s ct_state matches 0 run function cardtable:menu/render
execute if score @s ct_state matches 1 run function cardtable:vote/render
function cardtable:rules/render
data merge entity @s {data:{cardtable:{menu_version:10}}}
