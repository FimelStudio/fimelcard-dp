# 第九版牌桌：游戏界面加入规则介绍，并调整结束游戏和规则按钮的点击区
# 尚未完成第八版迁移的旧牌桌先补做座椅与中央菜单迁移
execute unless data entity @s {data:{cardtable:{menu_version:8}}} run function cardtable:table/migrate_v8

# 重新渲染当前状态对应的界面；活跃游戏会立即得到新位置和规则按钮
execute if score @s ct_state matches 0 run function cardtable:menu/render
execute if score @s ct_state matches 1 run function cardtable:vote/render
data merge entity @s {data:{cardtable:{menu_version:9}}}
