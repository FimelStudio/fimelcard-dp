function doudizhu:game/ensure_match
function doudizhu:player/audience
# 新一局或全不叫重发时清除旧出牌记录，累计分数保持。
data modify entity @s data.doudizhu set value {}
execute as @e[tag=dd.actors] run scoreboard players set @s dd_action 0
execute as @a[tag=dd.audience] run dialog clear @s
execute as @e[tag=dd.card] if score @s dd_id = #ctx dd_ctx run kill @s
scoreboard players set @s dd_state 1
scoreboard players set @s dd_timer 0
scoreboard players set @s dd_bid 0
scoreboard players set @s dd_bidcount 0
scoreboard players set @s dd_lord 0
scoreboard players set @s dd_last 0
scoreboard players set @s dd_passes 0
scoreboard players set @s dd_type 0
scoreboard players set @s dd_mult 1
execute as @e[tag=dd.actors] run scoreboard players set @s dd_plays 0
function doudizhu:deck/create
tag @e[tag=dd.pool] remove dd.pool
execute as @e[tag=dd.card] if score @s dd_id = #ctx dd_ctx run tag @s add dd.pool
execute as @e[tag=dd.actors] run function doudizhu:deal/hand
tag @e[tag=dd.pool] remove dd.pool
scoreboard players operation @s dd_turn = @e[tag=dd.actors,sort=random,limit=1] dd_seat
function cardtable:animation/deal/clear
function cardtable:animation/deal/box/spawn
tellraw @a[tag=dd.audience] [{text:"[斗地主] 第 ",color:"gold"},{score:{name:"@s",objective:"dd_round"}},{text:" / "},{score:{name:"@s",objective:"dd_limit"}},{text:" 局：发牌中，每人17张，留3张底牌。"}]
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
