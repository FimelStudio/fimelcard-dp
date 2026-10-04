execute if score @s ct_joined > @s ct_capacity run return fail
# 标准花火支持2至5人；五人局使用八座桌
function hanabi:log {text:"开始执行花火开局检查"}
function hanabi:game/init_table
execute unless score @s ct_joined matches 2..5 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'需要2至5名玩家入座。',color:'yellow'}]
execute unless score @s ct_joined matches 2..5 run function hanabi:log {text:"开局失败：入座人数不在2至5人范围内"}
execute unless score @s ct_joined matches 2..5 run return fail

scoreboard players operation #ctx_id hb_ctx = @s ct_id
scoreboard players set #online hb_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id hb_ctx run scoreboard players add #online hb_ctx 1
execute unless score #online hb_ctx = @s ct_joined run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'有已入座的玩家不在线。',color:'yellow'}]
execute unless score #online hb_ctx = @s ct_joined run return fail

# 先清除本模块可能遗留的操作物，再确认将要占用的位置不会覆盖玩家自己的物品
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id hb_ctx run clear @s minecraft:paper[minecraft:custom_data~{hanabi:{card:1b}}]
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id hb_ctx run clear @s minecraft:firework_star[minecraft:custom_data~{hanabi:{action:"hint"}}]
scoreboard players set #blocked hb_ctx 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id hb_ctx run function hanabi:game/check_inventory
execute if score #blocked hb_ctx matches 1 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[花火] ',color:'light_purple'},{text:'请让所有玩家清空快捷栏第1至5格、第9格和副手后再开始。',color:'yellow'}]
execute if score #blocked hb_ctx matches 1 run return fail

# 建立本桌运行期控制器与玩家映射
tag @s add hb.controller
scoreboard players operation @s hb_id = @s ct_id
scoreboard players set @s hb_state 0
scoreboard players set @s hb_phase 0
scoreboard players set @s hb_timer 0
scoreboard players operation @s hb_players = @s ct_joined
scoreboard players set @s hb_turn 0
scoreboard players set @s hb_deal 0
scoreboard players set @s hb_scan 0
scoreboard players operation @s hb_clues = @s hb_clue_max
scoreboard players set @s hb_strikes 0
scoreboard players set @s hb_deck_count 0
scoreboard players set @s hb_final 0
scoreboard players set @s hb_reward_left 0
scoreboard players set @s hb_reward_pending 0
scoreboard players set @s hb_score 0
scoreboard players set @s hb_wstack 0
scoreboard players set @s hb_rstack 0
scoreboard players set @s hb_bstack 0
scoreboard players set @s hb_ystack 0
scoreboard players set @s hb_gstack 0
scoreboard players set @s hb_mstack 0
scoreboard players set @s hb_reason 0
scoreboard players set @s hb_pending_slot 0
scoreboard players set @s hb_discard_count 0

scoreboard players set @s hb_hand_size 5
execute if score @s hb_players matches 4..5 run scoreboard players set @s hb_hand_size 4
scoreboard players operation @s hb_total = @s hb_players
scoreboard players operation @s hb_total *= @s hb_hand_size

execute as @a[tag=ct.player] if score @s ct_id = #ctx_id hb_ctx run tag @s add hb.player
execute as @a[tag=hb.player] if score @s ct_id = #ctx_id hb_ctx run scoreboard players operation @s hb_id = @s ct_id
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players operation @s hb_seat = @s ct_seat
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_hand_count 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_action 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_target 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_drop_card 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_drop_hint 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run scoreboard players set @s hb_self 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run tag @s remove hb.restore_pending
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run tag @s remove hb.reward_pending
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run title @s actionbar {text:""}
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function cardtable:seat/mount
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:hand/sync

# 牌库只在全部玩家状态初始化成功后创建
function hanabi:deck/create
function hanabi:reward/deck/create

# 向通用牌桌提交成功握手，再进入公共牌盒发牌动画
scoreboard players set @s ct_start 1
function hanabi:log {text:"开局检查通过，开始发牌"}
function hanabi:deal/start
