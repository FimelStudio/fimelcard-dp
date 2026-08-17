# 进度已确认玩家点击了相应编号的座椅，这里处理实例和占用状态
execute unless entity @e[tag=ct.clicked_seat,limit=1] run return fail

# 已参加牌桌的玩家在游戏中可自由离座，并通过右键自己的原座位重新坐回
execute if entity @s[tag=ct.player] run function cardtable:seat/remount_click
execute if entity @s[tag=ct.player] run tag @e[tag=ct.clicked_seat] remove ct.clicked_seat
execute if entity @s[tag=ct.player] run return 1

# 旧存档可能残留桌号错误的座椅；以座椅两格内最近的控制器为权威来源即时修复。
tag @e[tag=ct.seat_controller] remove ct.seat_controller
execute at @e[tag=ct.clicked_seat,limit=1] run tag @e[type=minecraft:marker,tag=ct.controller,distance=..2.3,sort=nearest,limit=1] add ct.seat_controller
execute if entity @e[tag=ct.seat_controller,limit=1] run scoreboard players operation @e[tag=ct.clicked_seat,limit=1] ct_id = @e[tag=ct.seat_controller,limit=1] ct_id
tag @e[tag=ct.seat_controller] remove ct.seat_controller

scoreboard players operation #ctx_id ct_ctx = @e[tag=ct.clicked_seat,limit=1] ct_id
scoreboard players operation #ctx_seat ct_ctx = @e[tag=ct.clicked_seat,limit=1] ct_seat
tag @e[tag=ct.join_controller] remove ct.join_controller
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0}] if score @s ct_id = #ctx_id ct_ctx run tag @s add ct.join_controller
execute unless entity @e[tag=ct.join_controller,limit=1] run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'这张牌桌当前不能加入。',color:'red'}]
execute unless entity @e[tag=ct.join_controller,limit=1] run tag @e[tag=ct.clicked_seat] remove ct.clicked_seat
execute unless entity @e[tag=ct.join_controller,limit=1] run return fail

# 同桌同座已有玩家时拒绝入座
scoreboard players set #occupied ct_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx if score @s ct_seat = #ctx_seat ct_ctx run scoreboard players set #occupied ct_ctx 1
execute if score #occupied ct_ctx matches 1 run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{text:'这个座位已经有人了。',color:'red'}]
execute if score #occupied ct_ctx matches 1 run tag @e[tag=ct.clicked_seat] remove ct.clicked_seat
execute if score #occupied ct_ctx matches 1 run tag @e[tag=ct.join_controller] remove ct.join_controller
execute if score #occupied ct_ctx matches 1 run return fail

# 记录通用会话身份并立即骑乘座椅交互实体
scoreboard players operation @s ct_id = #ctx_id ct_ctx
scoreboard players operation @s ct_seat = #ctx_seat ct_ctx
scoreboard players set @s ct_voted 0
scoreboard players set @s ct_online 1
tag @s add ct.player
tag @s add ct.joiner
execute store result storage cardtable:debug seat int 1 run scoreboard players get @s ct_seat
function cardtable:debug/log_join with storage cardtable:debug
function cardtable:seat/mount

# 入座提示保持静默；从在线玩家重新统计，避免有人刚离线时累计人数短暂变成5
execute as @e[tag=ct.join_controller,limit=1] at @s run function cardtable:table/recount_players

tag @s remove ct.joiner
tag @e[tag=ct.clicked_seat] remove ct.clicked_seat
tag @e[tag=ct.join_controller] remove ct.join_controller
