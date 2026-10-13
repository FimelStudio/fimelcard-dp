# 四人桌内部初始化；由创建入口以新控制器为执行者调用，玩家无需直接执行。
# 通用模块分配桌号、按创建模式生成牌桌内容，并初始化默认选择的游戏
function cardtable:table/init
tag @s remove ct.new_controller

execute unless entity @s[tag=ct.no_structure] run tellraw @a[tag=ct.creator,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已创建通用牌桌 #',color:'green'},{score:{name:'@s',objective:'ct_id'}},{text:'。',color:'green'}]
execute if entity @s[tag=ct.no_structure] run tellraw @a[tag=ct.creator,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'已将现有桌椅注册为通用牌桌 #',color:'green'},{score:{name:'@s',objective:'ct_id'}},{text:'，未修改任何方块。',color:'green'}]
execute unless entity @s[tag=ct.no_structure] run tellraw @a[tag=ct.creator,limit=1] [{text:'右键白桦木楼梯上的座椅交互区即可入座；游戏与规则可在中央菜单中选择和设置。',color:'gray'}]
execute if entity @s[tag=ct.no_structure] run tellraw @a[tag=ct.creator,limit=1] [{text:'四个座位交互区位于桌心南、北、东、西各2格；游戏与规则可在中央菜单中选择和设置。',color:'gray'}]
tag @s remove ct.no_structure
