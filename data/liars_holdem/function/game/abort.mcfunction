function liars_holdem:log {text:"管理员中止赌命德州扑克"}
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'本场游戏已被管理员中止。',color:'yellow'}]
function liars_holdem:game/cleanup
