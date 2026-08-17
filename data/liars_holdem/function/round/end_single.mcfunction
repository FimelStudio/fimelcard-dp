scoreboard players operation #ctx_id lh_ctx = @s lh_id
tag @a[tag=lh.round_winner] remove lh.round_winner
execute as @a[tag=lh.player,scores={lh_alive=1,lh_fold=0}] if score @s lh_id = #ctx_id lh_ctx run tag @s add lh.round_winner
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{selector:'@a[tag=lh.round_winner,limit=1]',color:'gold'},{text:' 是本局唯一未弃牌玩家，直接获胜。',color:'green'}]
function liars_holdem:sound/round_win
tag @a[tag=lh.round_winner] remove lh.round_winner
function liars_holdem:round/end
