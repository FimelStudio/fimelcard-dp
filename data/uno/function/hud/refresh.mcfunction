# 控制器入口；真实手牌已提交后，每名玩家只构建自己的面板。
function uno:system/context
execute as @a[tag=un.audience] run function uno:hud/update
scoreboard players set @s un_hud_dirty 0
