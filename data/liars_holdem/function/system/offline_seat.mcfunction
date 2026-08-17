$scoreboard players set @s $(alive) 0
$execute as @e[type=minecraft:marker,tag=lh.hand_card,scores={lh_seat=$(seat)}] if score @s lh_id = #ctx_id lh_ctx run kill @s
execute as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run tellraw @s [{text:'[赌命德州扑克] ',color:'red'},{text:'一名存活玩家离线，该座位已被淘汰。',color:'yellow'}]
function cardtable:table/recount_players
function liars_holdem:util/count_alive
execute if score @s lh_alive_count matches ..1 run return run function liars_holdem:game/finish
# 过场或逐张发牌期间人数变化会使计划发牌数失效，安全取消本局后重新洗牌
execute if score @s lh_state matches 1..2 run return run function liars_holdem:round/end
$execute if score @s lh_turn matches $(seat) if score @s lh_state matches 5 run return run function liars_holdem:turn/advance
$execute if score @s lh_turn matches $(seat) if score @s lh_state matches 7 run return run function liars_holdem:turn/advance
$execute if score @s lh_turn matches $(seat) if score @s lh_state matches 9 run return run function liars_holdem:turn/advance
$execute if score @s lh_turn matches $(seat) if score @s lh_state matches 11..12 run return run function liars_holdem:turn/advance
