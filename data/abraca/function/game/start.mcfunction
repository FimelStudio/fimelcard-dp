execute unless score @s ct_joined matches 2..4 run tellraw @a[tag=ct.start_actor,limit=1] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'需要2至4名玩家入座；当前四座牌桌暂不支持原规则的5人局。',color:'yellow'}]
execute unless score @s ct_joined matches 2..4 run return fail
scoreboard players operation #ctx ab_ctx = @s ct_id
# 上一局留下的最终生命面板只展示到下一局开始。
execute as @e[type=minecraft:text_display,tag=ab.final_info] if score @s ab_id = #ctx ab_ctx run kill @s
tag @s add ab.controller
scoreboard players operation @s ab_id = @s ct_id
scoreboard players set @s ab_state 1
scoreboard players set @s ab_round 1
scoreboard players set @s ab_phase 0
scoreboard players set @s ab_timer 0
scoreboard players set @s ab_deal 0
scoreboard players set @s ab_scan 0
# 从0开始，由turn/begin扫描到本桌第一位实际入座的玩家。
scoreboard players set @s ab_turn 0
scoreboard players set @s ab_deck_count 0
scoreboard players set @s ab_play_1 0
scoreboard players set @s ab_play_2 0
scoreboard players set @s ab_play_3 0
scoreboard players set @s ab_play_4 0
scoreboard players set @s ab_play_5 0
scoreboard players set @s ab_play_6 0
scoreboard players set @s ab_play_7 0
scoreboard players set @s ab_play_8 0
execute as @a[tag=ct.player] if score @s ct_id = #ctx ab_ctx run tag @s add ab.player
execute as @a[tag=ab.player] if score @s ct_id = #ctx ab_ctx run scoreboard players operation @s ab_id = @s ct_id
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run scoreboard players operation @s ab_seat = @s ct_seat
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run scoreboard players set @s ab_hp 6
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run scoreboard players set @s ab_score 0
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run scoreboard players set @s ab_secret 0
function abraca:deck/create
function abraca:deck/create_secret
execute store result storage abraca:debug id int 1 run scoreboard players get @s ab_id
execute store result storage abraca:debug players int 1 run scoreboard players get @s ct_joined
function abraca:debug/log_start with storage abraca:debug
scoreboard players set @s ct_start 1
function abraca:deal/start
