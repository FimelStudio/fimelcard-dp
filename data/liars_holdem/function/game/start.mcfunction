# 赌命德州扑克允许任意2至4个座位开局；空座位不会被加入发牌、轮转和存活统计
function liars_holdem:log {text:"开始执行赌命德州扑克开局检查"}
execute unless score @s ct_joined matches 2..4 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[赌命德州扑克] ',color:'red'},{text:'需要2至4名玩家入座。',color:'yellow'}]
execute unless score @s ct_joined matches 2..4 run function liars_holdem:log {text:"开局失败：入座人数不在2至4人范围内"}
execute unless score @s ct_joined matches 2..4 run return fail

scoreboard players operation #ctx_id lh_ctx = @s ct_id
scoreboard players set #online lh_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id lh_ctx run scoreboard players add #online lh_ctx 1
execute unless score #online lh_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[赌命德州扑克] ',color:'red'},{text:'有已入座的玩家不在线。',color:'yellow'}]
execute unless score #online lh_ctx = @s ct_joined run return fail

scoreboard players set #blocked lh_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id lh_ctx run function liars_holdem:game/check_hotbar
execute if score #blocked lh_ctx matches 1 run function liars_holdem:log {text:"开局失败：检测到非空快捷栏"}
execute if score #blocked lh_ctx matches 1 run return fail

# 建立游戏专属映射
tag @s add lh.controller
scoreboard players operation @s lh_id = @s ct_id
scoreboard players set @s lh_state 0
scoreboard players set @s lh_phase 0
scoreboard players set @s lh_round 0
scoreboard players set @s lh_dealer 0
scoreboard players set @s lh_a1 0
scoreboard players set @s lh_a2 0
scoreboard players set @s lh_a3 0
scoreboard players set @s lh_a4 0

execute as @a[tag=ct.player] if score @s ct_id = #ctx_id lh_ctx run tag @s add lh.player
execute as @a[tag=lh.player] if score @s ct_id = #ctx_id lh_ctx run scoreboard players operation @s lh_id = @s ct_id
execute as @a[tag=lh.player] if score @s ct_id = #ctx_id lh_ctx run scoreboard players operation @s lh_seat = @s ct_seat
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_alive 1
scoreboard players set #occupied lh_ctx 0
execute as @a[tag=lh.player,scores={lh_seat=1}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #occupied lh_ctx 1
execute if score #occupied lh_ctx matches 1 run scoreboard players set @s lh_a1 1
scoreboard players set #occupied lh_ctx 0
execute as @a[tag=lh.player,scores={lh_seat=2}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #occupied lh_ctx 1
execute if score #occupied lh_ctx matches 1 run scoreboard players set @s lh_a2 1
scoreboard players set #occupied lh_ctx 0
execute as @a[tag=lh.player,scores={lh_seat=3}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #occupied lh_ctx 1
execute if score #occupied lh_ctx matches 1 run scoreboard players set @s lh_a3 1
scoreboard players set #occupied lh_ctx 0
execute as @a[tag=lh.player,scores={lh_seat=4}] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set #occupied lh_ctx 1
execute if score #occupied lh_ctx matches 1 run scoreboard players set @s lh_a4 1
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_fold 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_wait 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_card 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_call 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run scoreboard players set @s lh_drop_fold 0
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run function cardtable:seat/mount
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run function liars_holdem:player/protect

# 首局庄家从实际存活玩家中随机抽取；round/begin 的轮转会先落在这名玩家。
tag @a[tag=lh.first_pool] remove lh.first_pool
tag @a[tag=lh.first_dealer] remove lh.first_dealer
execute as @a[tag=lh.player,scores={lh_alive=1}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.first_pool
tag @a[tag=lh.first_pool,sort=random,limit=1] add lh.first_dealer
scoreboard players operation @s lh_dealer = @a[tag=lh.first_dealer,limit=1] lh_seat
scoreboard players remove @s lh_dealer 1
execute if score @s lh_dealer matches ..0 run scoreboard players set @s lh_dealer 4
tag @a[tag=lh.first_pool] remove lh.first_pool
tag @a[tag=lh.first_dealer] remove lh.first_dealer

# 所有初始化完成后再向通用牌桌提交成功握手
scoreboard players set @s ct_start 1
function liars_holdem:log {text:"开局检查通过，进入第一局"}
function liars_holdem:round/begin
