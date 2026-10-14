# 同一玩家每场游戏只能投一次
execute if score @a[tag=ct.voter,limit=1] ct_voted matches 1 run tellraw @a[tag=ct.voter,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'你已经投过结束票了。',color:'yellow'}]
execute if score @a[tag=ct.voter,limit=1] ct_voted matches 1 run return fail

scoreboard players set @a[tag=ct.voter,limit=1] ct_voted 1
function cardtable:vote/count
execute store result storage cardtable:debug votes int 1 run scoreboard players get @s ct_votes
function cardtable:debug/log_vote with storage cardtable:debug
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run tellraw @s [{text:'[牌桌] ',color:'dark_aqua'},{selector:'@a[tag=ct.voter,limit=1]',color:'yellow'},{text:' 投票结束游戏（',color:'gray'},{score:{name:'@e[tag=ct.vote_controller,limit=1]',objective:'ct_votes'},color:'gold'},{text:'/',color:'gray'},{score:{name:'#vote_need',objective:'ct_ctx'},color:'gold'},{text:'）。',color:'gray'}]

function cardtable:vote/refresh
