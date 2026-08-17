# 当前执行者是目标牌桌控制器，输入值已经由保存入口完成范围校验
scoreboard players operation @s fc_max = #settings_rounds fc_ctx
scoreboard players operation @s fc_rule = #settings_rule fc_ctx
execute store result storage fast_card:debug rounds int 1 run scoreboard players get @s fc_max
function fast_card:debug/log_round_config with storage fast_card:debug
execute if score @s fc_rule matches 0 run function fast_card:log {text:"Fast Card设置已保存：无牌型乱按忽略"}
execute if score @s fc_rule matches 1 run function fast_card:log {text:"Fast Card设置已保存：无牌型乱按立即判负"}
execute if score @s fc_rule matches 0 run tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'当前牌桌设置已保存：',color:'green'},{text:'局数 ',color:'gray'},{score:{name:'@s',objective:'fc_max'},color:'yellow'},{text:'；无牌型乱按 ',color:'gray'},{text:'忽略',color:'aqua'}]
execute if score @s fc_rule matches 1 run tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'当前牌桌设置已保存：',color:'green'},{text:'局数 ',color:'gray'},{score:{name:'@s',objective:'fc_max'},color:'yellow'},{text:'；无牌型乱按 ',color:'gray'},{text:'立即判负',color:'red'}]
