# 选择器不限定世界坐标，覆盖所有维度中已加载的控制器。
execute as @e[type=minecraft:marker,tag=ct.controller,limit=1] at @s run function cardtable:table/remove
schedule function cardtable:uninstall/step 1t replace
