# 玩家提交；先消费输入，拒绝跨桌、开局后或已切换游戏的旧窗口。
scoreboard players operation #set_rounds dd_ctx = @s dd_settings
scoreboard players reset @s dd_settings
scoreboard players set #set_table dd_ctx 0
scoreboard players operation #set_table dd_ctx = @s dd_set_table
scoreboard players reset @s dd_set_table
execute unless entity @s[tag=ct.player] run return 0
execute unless score @s ct_id = #set_table dd_ctx run return run function doudizhu:settings/invalid
scoreboard players set #set_ten dd_ctx 10
# 回合数、音乐、模式、牌数显示、记牌器、版本尾码9；旧窗口不再接受。
scoreboard players operation #set_marker dd_ctx = #set_rounds dd_ctx
scoreboard players operation #set_marker dd_ctx %= #set_ten dd_ctx
execute unless score #set_marker dd_ctx matches 7 run return run function doudizhu:settings/invalid
scoreboard players operation #set_rounds dd_ctx /= #set_ten dd_ctx
scoreboard players operation #set_shuffle dd_ctx = #set_rounds dd_ctx
scoreboard players operation #set_shuffle dd_ctx %= #set_ten dd_ctx
scoreboard players operation #set_rounds dd_ctx /= #set_ten dd_ctx
execute unless score #set_shuffle dd_ctx matches 0..1 run return run function doudizhu:settings/invalid
scoreboard players operation #set_counter dd_ctx = #set_rounds dd_ctx
scoreboard players operation #set_counter dd_ctx %= #set_ten dd_ctx
scoreboard players operation #set_rounds dd_ctx /= #set_ten dd_ctx
execute unless score #set_counter dd_ctx matches 0..1 run return run function doudizhu:settings/invalid
scoreboard players operation #set_counts dd_ctx = #set_rounds dd_ctx
scoreboard players operation #set_counts dd_ctx %= #set_ten dd_ctx
scoreboard players operation #set_rounds dd_ctx /= #set_ten dd_ctx
execute unless score #set_counts dd_ctx matches 0..1 run return run function doudizhu:settings/invalid
scoreboard players operation #set_mode dd_ctx = #set_rounds dd_ctx
scoreboard players operation #set_mode dd_ctx %= #set_ten dd_ctx
scoreboard players operation #set_rounds dd_ctx /= #set_ten dd_ctx
execute unless score #set_mode dd_ctx matches 0..2 run return run function doudizhu:settings/invalid
scoreboard players operation #set_music dd_ctx = #set_rounds dd_ctx
scoreboard players operation #set_music dd_ctx %= #set_ten dd_ctx
scoreboard players operation #set_rounds dd_ctx /= #set_ten dd_ctx
execute unless score #set_music dd_ctx matches 0..1 run return run function doudizhu:settings/invalid
execute unless score #set_rounds dd_ctx matches 1..32 run return run function doudizhu:settings/invalid
tag @e[tag=dd.settings_table] remove dd.settings_table
execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_state=0,ct_game=10}] if score @s ct_id = #set_table dd_ctx run tag @s add dd.settings_table
execute unless entity @e[tag=dd.settings_table,limit=1] run return run function doudizhu:settings/invalid
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_noshuffle = #set_shuffle dd_ctx
execute if score #set_shuffle dd_ctx matches 1 run tellraw @s {text:"不洗牌模式：首副同点数成组，切牌后连续发牌；后续保留出牌组合收牌、切牌，不逐张打散。",color:"green"}
execute if score #set_shuffle dd_ctx matches 0 run tellraw @s {text:"正常洗牌模式。",color:"green"}
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_max = #set_rounds dd_ctx
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_audio = #set_music dd_ctx
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_counter = #set_counter dd_ctx
execute if score #set_counter dd_ctx matches 0 run tellraw @s {text:"记牌器：关闭。",color:"gray"}
execute if score #set_counter dd_ctx matches 1 run tellraw @s {text:"记牌器：开启（显示另外两家各点数的剩余总数）。",color:"green"}
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_counts = #set_counts dd_ctx
execute if score #set_counts dd_ctx matches 0 run tellraw @s {text:"剩余牌数：隐藏（同时关闭报单、报双的聊天提醒）。",color:"gray"}
execute if score #set_counts dd_ctx matches 1 run tellraw @s {text:"剩余牌数：显示。",color:"green"}
scoreboard players operation @e[tag=dd.settings_table,limit=1] dd_bidmode = #set_mode dd_ctx
execute if score #set_mode dd_ctx matches 0 run tellraw @s {text:"叫地主模式：叫分制。",color:"green"}
execute if score #set_mode dd_ctx matches 1 run tellraw @s {text:"叫地主模式：叫抢制。",color:"green"}
execute if score #set_mode dd_ctx matches 2 run tellraw @s {text:"叫地主模式：手速制。",color:"green"}
execute if score #set_music dd_ctx matches 1 run tellraw @s {text:"[斗地主] 游戏音乐：开启。",color:"green"}
execute if score #set_music dd_ctx matches 0 run tellraw @s {text:"[斗地主] 游戏音乐：关闭。",color:"gray"}
tellraw @s [{text:"[斗地主] 本场局数已设为 ",color:"gold"},{score:{name:"#set_rounds",objective:"dd_ctx"}},{text:" 局，每局分数累计。",color:"gold"}]
tag @e[tag=dd.settings_table] remove dd.settings_table
