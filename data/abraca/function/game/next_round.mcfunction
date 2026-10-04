scoreboard players operation #ctx ab_ctx = @s ab_id
scoreboard players add @s ab_round 1
function abraca:log {text:"无人达到8层，重置牌局并开始下一局"}

# 清理上一局牌库、手牌、按钮和面板；玩家累计塔层不清零。
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run function abraca:game/reset_player_round
execute as @e[tag=ab.game_entity] if score @s ab_id = #ctx ab_ctx run kill @s
function cardtable:animation/deal/clear

scoreboard players set @s ab_state 1
scoreboard players set @s ab_phase 0
scoreboard players set @s ab_timer 0
scoreboard players set @s ab_deal 0
scoreboard players set @s ab_scan 0
scoreboard players set @s ab_deck_count 0
scoreboard players set @s ab_play_1 0
scoreboard players set @s ab_play_2 0
scoreboard players set @s ab_play_3 0
scoreboard players set @s ab_play_4 0
scoreboard players set @s ab_play_5 0
scoreboard players set @s ab_play_6 0
scoreboard players set @s ab_play_7 0
scoreboard players set @s ab_play_8 0

# 每局重新随机首位施法者，并创建全新的牌库与秘密咒语石。
tag @a[tag=ab.first_pool] remove ab.first_pool
tag @a[tag=ab.first_turn] remove ab.first_turn
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.first_pool
tag @a[tag=ab.first_pool,sort=random,limit=1] add ab.first_turn
scoreboard players operation @s ab_turn = @a[tag=ab.first_turn,limit=1] ab_seat
scoreboard players remove @s ab_turn 1
execute if score @s ab_turn matches ..0 run scoreboard players set @s ab_turn 8
tag @a[tag=ab.first_pool] remove ab.first_pool
tag @a[tag=ab.first_turn] remove ab.first_turn

function abraca:deck/create
function abraca:deck/create_secret
tellraw @a[tag=ab.player] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'第 ',color:'yellow'},{score:{name:'@s',objective:'ab_round'},color:'gold'},{text:' 局开始；塔层继续累计，率先达到8层者获胜。',color:'yellow'}]
function abraca:deal/start
