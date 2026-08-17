# 默认规则下无效点击只提示本人，不改变牌局
execute as @e[type=minecraft:marker,tag=fc.controller] if score @s fc_id = #ctx_id fc_ctx run function fast_card:log {text:"检测到无有效牌型乱按，按配置忽略"}
tellraw @a[tag=fc.clicker,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'你还没有组成有效牌型。',color:'red'}]
execute as @a[tag=fc.clicker,limit=1] at @s run playsound minecraft:block.stone_button.click_off master @s ~ ~ ~ 0.5 0.7
