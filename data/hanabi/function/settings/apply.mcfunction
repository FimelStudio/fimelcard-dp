# 当前执行者是目标牌桌控制器，输入已经由settings/save完成范围和状态校验
scoreboard players operation @s hb_clue_max = #settings_clues hb_ctx
scoreboard players operation @s hb_strike_max = #settings_strikes hb_ctx
scoreboard players operation @s hb_storm = #settings_storm hb_ctx
function hanabi:log {text:"花火设置已保存"}
tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'当前牌桌设置已保存：',color:'green'},{text:'提示 ',color:'gray'},{score:{name:'@s',objective:'hb_clue_max'},color:'aqua'},{text:'；失误 ',color:'gray'},{score:{name:'@s',objective:'hb_strike_max'},color:'red'}]
execute if score @s hb_storm matches 0 run tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'彩色风暴：关闭',color:'gray'}]
execute if score @s hb_storm matches 1 run tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'彩色风暴：开启',color:'light_purple',bold:true}]
tellraw @a[tag=ct.settings_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'奖励牌：固定六张，完成烟花序列时随机抽取并立即使用。',color:'gold'}]
