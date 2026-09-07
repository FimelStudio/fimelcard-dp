scoreboard players operation #ctx ab_ctx = @s ab_id
function abraca:log {text:"本轮结束，开始结算胜者与存活奖励"}
# 建立本桌接收者，保证同时进行的其他牌桌不会收到结算消息。
tag @a[tag=ab.audience] remove ab.audience
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tag @s add ab.audience
tag @a[tag=ab.this_winner] remove ab.this_winner
execute as @a[tag=ab.round_winner] if score @s ab_id = #ctx ab_ctx run tag @s add ab.this_winner

# 打空手牌与击倒对手都是本轮胜利：胜者+3，其他存活者+1。
execute if entity @a[tag=ab.this_winner] run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.this_winner]',color:'gold'},{text:' 本轮胜出！',color:'green'}]
execute if entity @a[tag=ab.this_winner,tag=ab.win_hand] run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.this_winner,tag=ab.win_hand]',color:'gold'},{text:' 已在同一回合打完全部手牌，前进3层。',color:'aqua'}]
execute if entity @a[tag=ab.this_winner,tag=!ab.win_hand] run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.this_winner,tag=!ab.win_hand]',color:'gold'},{text:' 击倒了其他玩家，前进3层。',color:'red'}]
execute as @a[tag=ab.this_winner] run scoreboard players add @s ab_score 3
execute if entity @a[tag=ab.this_winner] as @a[tag=ab.player,tag=!ab.this_winner] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run scoreboard players add @s ab_score 1
execute if entity @a[tag=ab.this_winner] as @a[tag=ab.player,tag=!ab.this_winner] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'你本轮存活，前进1层。',color:'yellow'}]

# 若有人因失败或其他非攻击原因倒下，本轮没有击倒胜者，仍由所有存活者各前进1层。
execute unless entity @a[tag=ab.this_winner] run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'本轮没有击倒胜者；存活玩家各前进1层。',color:'yellow'}]
execute unless entity @a[tag=ab.this_winner] run execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run scoreboard players add @s ab_score 1
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches ..0 run tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'你本轮被击倒，不能获得存活奖励。',color:'red'}]

# 成功施放的每只猫头鹰都会为存活玩家额外前进一层；胜者与其他存活者分开结算，确保打空手牌的胜者也能在+3后获得奖励。
execute as @a[tag=ab.this_winner,scores={ab_hp=1..,ab_owl=1..}] run scoreboard players operation @s ab_score += @s ab_owl
execute as @a[tag=ab.player,tag=!ab.this_winner,scores={ab_hp=1..,ab_owl=1..}] if score @s ab_id = #ctx ab_ctx run scoreboard players operation @s ab_score += @s ab_owl
execute as @a[tag=ab.player,scores={ab_hp=1..,ab_owl=1..}] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.audience] [{text:'[猫头鹰奖励] ',color:'gold'},{selector:'@s',color:'yellow'},{text:'成功施放 ',color:'gray'},{score:{name:'@s',objective:'ab_owl'},color:'gold'},{text:' 次猫头鹰，额外前进同等层数。',color:'green'}]

# 层数跨局累计；只有结算后至少一人达到8层，整场游戏才结束。
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx run tellraw @a[tag=ab.audience] [{text:'[塔层] ',color:'dark_purple'},{selector:'@s',color:'yellow'},{text:' 当前位于第 ',color:'gray'},{score:{name:'@s',objective:'ab_score'},color:'gold'},{text:' 层。',color:'gray'}]
tag @a[tag=ab.tower_winner] remove ab.tower_winner
execute as @a[tag=ab.player,scores={ab_score=8..}] if score @s ab_id = #ctx ab_ctx run tag @s add ab.tower_winner
scoreboard players set #game_over ab_ctx 0
execute if entity @a[tag=ab.tower_winner] run scoreboard players set #game_over ab_ctx 1
execute if entity @a[tag=ab.tower_winner] run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{selector:'@a[tag=ab.tower_winner]',color:'gold',bold:true},{text:' 达到8层，赢得整场游戏！',color:'green'}]
tag @a[tag=ab.audience] remove ab.audience
tag @a[tag=ab.this_winner] remove ab.this_winner
tag @a[tag=ab.tower_winner] remove ab.tower_winner
execute if score #game_over ab_ctx matches 1 run function abraca:game/finish
execute if score #game_over ab_ctx matches 1 run return 0
function abraca:game/next_round
