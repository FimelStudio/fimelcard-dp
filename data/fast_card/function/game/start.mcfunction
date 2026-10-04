# 从通用牌桌会话读取四名已入座玩家
function fast_card:log {text:"开始执行Fast Card开局检查"}
execute unless score @s ct_joined matches 4 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'必须先有四名玩家入座。',color:'red'}]
execute unless score @s ct_joined matches 4 run function fast_card:log {text:"开局失败：入座人数不是4人"}
execute unless score @s ct_joined matches 4 run return fail

scoreboard players operation #ctx_id fc_ctx = @s ct_id
scoreboard players set #online fc_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id fc_ctx run scoreboard players add #online fc_ctx 1
execute unless score #online fc_ctx matches 4 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'有已入座的玩家不在线。',color:'red'}]
execute unless score #online fc_ctx matches 4 run function fast_card:log {text:"开局失败：在线玩家不足4人"}
execute unless score #online fc_ctx matches 4 run return fail

# 快捷栏必须为空，主物品栏不受限制
scoreboard players set #blocked fc_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id fc_ctx run function fast_card:game/check_hotbar
execute if score #blocked fc_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'至少一名玩家的快捷栏不为空。',color:'red'}]
execute if score #blocked fc_ctx matches 1 run function fast_card:log {text:"开局失败：检测到非空快捷栏"}
execute if score #blocked fc_ctx matches 1 run return fail

# 创建Fast Card自己的运行期映射，不污染通用牌桌模块
tag @s add fc.controller
scoreboard players operation @s fc_id = @s ct_id
scoreboard players operation @s fc_joined = @s ct_joined
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id fc_ctx run tag @s add fc.player
execute as @a[tag=fc.player] if score @s ct_id = #ctx_id fc_ctx run scoreboard players operation @s fc_id = @s ct_id
function fast_card:player/map_seats

# 通知通用层所有前置检查已通过
function fast_card:log {text:"开局检查通过，初始化玩家、牌组和按钮"}
scoreboard players set @s ct_start 1

# 初始化本场总分并强制入座；中央抢按按钮会在每小局发牌动画结束后再出现
scoreboard players set @s fc_state 1
scoreboard players set @s fc_round 0
scoreboard players set @s fc_press 0
scoreboard players set @s fc_phase 0
scoreboard players set @s fc_deal 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:util/clear_cards
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players set @s fc_score 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players set @s fc_delta 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players set @s fc_order 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function cardtable:seat/mount
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/protect

function fast_card:round/begin
