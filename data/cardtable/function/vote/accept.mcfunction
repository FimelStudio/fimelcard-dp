# 同一玩家每场游戏只能投一次
execute if score @a[tag=ct.voter,limit=1] ct_voted matches 1 run tellraw @a[tag=ct.voter,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'你已经投过结束票了。',color:'yellow'}]
execute if score @a[tag=ct.voter,limit=1] ct_voted matches 1 run return fail

scoreboard players set @a[tag=ct.voter,limit=1] ct_voted 1
scoreboard players add @s ct_votes 1
scoreboard players operation #vote_need ct_ctx = @s ct_joined
execute if score #vote_need ct_ctx matches 3.. run scoreboard players set #vote_need ct_ctx 3
execute store result storage cardtable:debug votes int 1 run scoreboard players get @s ct_votes
function cardtable:debug/log_vote with storage cardtable:debug
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{selector:'@a[tag=ct.voter,limit=1]',color:'yellow'},{text:' 投票结束游戏（',color:'gray'},{score:{name:'@e[tag=ct.vote_controller,limit=1]',objective:'ct_votes'},color:'gold'},{text:'/',color:'gray'},{score:{name:'#vote_need',objective:'ct_ctx'},color:'gold'},{text:'）。',color:'gray'}]

# 四人桌仍需3票；淘汰导致只剩2人时改为2票，死亡玩家不占票数
execute if score @s ct_votes < #vote_need ct_ctx run function cardtable:vote/render
execute if score @s ct_votes >= #vote_need ct_ctx if score @s ct_game matches 1 run function fast_card:game/end_vote
execute if score @s ct_votes >= #vote_need ct_ctx if score @s ct_game matches 2 run function liars_holdem:game/end_vote
execute if score @s ct_votes >= #vote_need ct_ctx if score @s ct_game matches 3 run function hanabi:game/end_vote
execute if score @s ct_votes >= #vote_need ct_ctx if score @s ct_game matches 4 run function abraca:game/end_vote
