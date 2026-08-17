function liars_holdem:log {text:"结束游戏投票达到要求，提前结束赌命德州扑克"}
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'结束游戏投票通过，本场提前结束。',color:'yellow'}]
function liars_holdem:game/cleanup
