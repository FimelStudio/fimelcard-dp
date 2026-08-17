# 当前执行者是一名进入摊牌的玩家；两张权威手牌标记与五张公共牌组成七张评估集
scoreboard players operation #eval_id lh_ctx = @s lh_id
scoreboard players operation #eval_seat lh_ctx = @s lh_seat
tag @e[tag=lh.eval_card] remove lh.eval_card
execute as @e[type=minecraft:marker,tag=lh.hand_card] if score @s lh_id = #eval_id lh_ctx if score @s lh_seat = #eval_seat lh_ctx run tag @s add lh.eval_card
execute as @e[type=minecraft:item_display,tag=lh.community] if score @s lh_id = #eval_id lh_ctx run tag @s add lh.eval_card

# 点数计数
scoreboard players set #r2 lh_ctx 0
scoreboard players set #r3 lh_ctx 0
scoreboard players set #r4 lh_ctx 0
scoreboard players set #r5 lh_ctx 0
scoreboard players set #r6 lh_ctx 0
scoreboard players set #r7 lh_ctx 0
scoreboard players set #r8 lh_ctx 0
scoreboard players set #r9 lh_ctx 0
scoreboard players set #r10 lh_ctx 0
scoreboard players set #r11 lh_ctx 0
scoreboard players set #r12 lh_ctx 0
scoreboard players set #r13 lh_ctx 0
scoreboard players set #r14 lh_ctx 0
execute as @e[tag=lh.eval_card,scores={lh_rank=2}] run scoreboard players add #r2 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=3}] run scoreboard players add #r3 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=4}] run scoreboard players add #r4 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=5}] run scoreboard players add #r5 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=6}] run scoreboard players add #r6 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=7}] run scoreboard players add #r7 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=8}] run scoreboard players add #r8 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=9}] run scoreboard players add #r9 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=10}] run scoreboard players add #r10 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=11}] run scoreboard players add #r11 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=12}] run scoreboard players add #r12 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=13}] run scoreboard players add #r13 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_rank=14}] run scoreboard players add #r14 lh_ctx 1

# 花色计数：1黑桃、2方块、3红心、4梅花
scoreboard players set #s1 lh_ctx 0
scoreboard players set #s2 lh_ctx 0
scoreboard players set #s3 lh_ctx 0
scoreboard players set #s4 lh_ctx 0
execute as @e[tag=lh.eval_card,scores={lh_suit=1}] run scoreboard players add #s1 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_suit=2}] run scoreboard players add #s2 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_suit=3}] run scoreboard players add #s3 lh_ctx 1
execute as @e[tag=lh.eval_card,scores={lh_suit=4}] run scoreboard players add #s4 lh_ctx 1

scoreboard players set @s lh_cat 0
scoreboard players set @s lh_k1 0
scoreboard players set @s lh_k2 0
scoreboard players set @s lh_k3 0
scoreboard players set @s lh_k4 0
scoreboard players set @s lh_k5 0

# 从最大牌型向下求值，已命中时后续函数不再执行
function liars_holdem:hand/straight_flush
execute if score @s lh_cat matches 0 run function liars_holdem:hand/four
execute if score @s lh_cat matches 0 run function liars_holdem:hand/full_house
execute if score @s lh_cat matches 0 run function liars_holdem:hand/flush
execute if score @s lh_cat matches 0 run function liars_holdem:hand/straight
execute if score @s lh_cat matches 0 run function liars_holdem:hand/three
execute if score @s lh_cat matches 0 run function liars_holdem:hand/two_pair
execute if score @s lh_cat matches 0 run function liars_holdem:hand/pair
execute if score @s lh_cat matches 0 run function liars_holdem:hand/high

# 以15进制折叠“牌型+五级比较键”，最大值不到一千万，安全落在32位记分范围
scoreboard players operation @s lh_value = @s lh_cat
scoreboard players operation @s lh_value *= #base lh_ctx
scoreboard players operation @s lh_value += @s lh_k1
scoreboard players operation @s lh_value *= #base lh_ctx
scoreboard players operation @s lh_value += @s lh_k2
scoreboard players operation @s lh_value *= #base lh_ctx
scoreboard players operation @s lh_value += @s lh_k3
scoreboard players operation @s lh_value *= #base lh_ctx
scoreboard players operation @s lh_value += @s lh_k4
scoreboard players operation @s lh_value *= #base lh_ctx
scoreboard players operation @s lh_value += @s lh_k5

# 在临时七张评估集中选出实际参与比较的五张牌，并保存其牌ID
function liars_holdem:hand/best/select

tag @e[tag=lh.eval_card] remove lh.eval_card
tag @e[tag=lh.flush_card] remove lh.flush_card
