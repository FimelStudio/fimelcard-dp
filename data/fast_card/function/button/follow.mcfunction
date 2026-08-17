# 已经登记过的玩家重复点击无效
execute if entity @a[tag=fc.clicker,tag=fc.pressed,limit=1] run return fail

# 记录服务器收到点击事件的严格先后顺序
scoreboard players add @s fc_press 1
scoreboard players operation @a[tag=fc.clicker,limit=1] fc_order = @s fc_press
tag @a[tag=fc.clicker,limit=1] add fc.pressed
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute store result storage fast_card:debug order int 1 run scoreboard players get @s fc_press
function fast_card:debug/log_press with storage fast_card:debug

# 普通牌型只罚第4名；特殊牌型罚第3名和第4名；超级牌型罚其余三人
execute if score @s fc_mode matches 1 if score @s fc_press matches 4 run scoreboard players remove @a[tag=fc.clicker,limit=1] fc_score 1
execute if score @s fc_mode matches 2 if score @s fc_press matches 3..4 run scoreboard players remove @a[tag=fc.clicker,limit=1] fc_score 1
execute if score @s fc_mode matches 3 if score @s fc_press matches 2..4 run scoreboard players remove @a[tag=fc.clicker,limit=1] fc_score 1

execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{selector:'@a[tag=fc.clicker,limit=1]',color:'yellow'},{text:' 第 ',color:'gray'},{score:{name:'@a[tag=fc.clicker,limit=1]',objective:'fc_order'}},{text:' 个按下按钮。',color:'gray'}]
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx at @s run playsound minecraft:block.stone_button.click_on master @s ~ ~ ~ 0.7 1.2

# 四人全部响应后进入结算
execute if score @s fc_press matches 4 run return run function fast_card:round/end
