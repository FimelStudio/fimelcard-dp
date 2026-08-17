# 第二版：将提前ALL IN从潜行+Q改为F键
scoreboard players set #version lh_ctx 2
# 旧版运行中牌局的五张公共牌没有保存牌号，无法原地修复；安全结束当前小局并重新洗牌
execute as @e[type=minecraft:marker,tag=lh.controller,scores={lh_state=1..16}] at @s run function liars_holdem:round/end
tellraw @a[tag=lh.player] [{text:'[赌命德州扑克] ',color:'red'},{text:'操作已升级：F键触发ALL IN。',color:'green'}]
