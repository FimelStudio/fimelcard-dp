scoreboard players operation #ctx ab_ctx = @s ab_id
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
execute as @a[tag=ab.player,tag=!ab.this_winner] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run scoreboard players add @s ab_score 1
execute as @a[tag=ab.player,tag=!ab.this_winner] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'你本轮存活，前进1层。',color:'yellow'}]

# 若有人因失败或其他非攻击原因倒下，本轮没有击倒胜者，仍由所有存活者各前进1层。
execute unless entity @a[tag=ab.this_winner] run tellraw @a[tag=ab.audience] [{text:'[出包魔法师] ',color:'dark_purple'},{text:'本轮没有击倒胜者；存活玩家各前进1层。',color:'yellow'}]
execute unless entity @a[tag=ab.this_winner] run execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches 1.. run scoreboard players add @s ab_score 1
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches ..0 run tellraw @s [{text:'[出包魔法师] ',color:'dark_purple'},{text:'你本轮被击倒，不能获得存活奖励。',color:'red'}]
tag @a[tag=ab.audience] remove ab.audience
tag @a[tag=ab.this_winner] remove ab.this_winner
function abraca:game/finish
