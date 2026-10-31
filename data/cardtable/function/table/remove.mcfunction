# 正在进行的游戏先走各自的清理接口
function cardtable:log {text:"管理员请求移除牌桌会话"}
execute if score @s ct_state matches 1 if score @s ct_game matches 1 run function fast_card:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 2 run function liars_holdem:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 3 run function hanabi:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 4 run function abraca:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 5 run function bullshit:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 6 run function decrypto:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 7 run function critical_point:game/abort

execute if score @s ct_state matches 1 if score @s ct_game matches 8 run function wenfei:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 9 run function skull:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 10 run function doudizhu:game/abort
execute if score @s ct_state matches 1 if score @s ct_game matches 11 run function uno:game/abort

execute if score @s ct_state matches 1 if score @s ct_game matches 12 run function chess:game/abort
execute if score @s ct_game matches 12 run function chess:game/remove

execute if score @s ct_state matches 1 if score @s ct_game matches 13 run function xiangqi:game/abort
execute if score @s ct_game matches 13 run function xiangqi:game/remove
execute if score @s ct_skin matches 1..6 unless score @s ct_capacity matches 8 run function cardtable:skin/default4
execute if score @s ct_skin matches 1..6 if score @s ct_capacity matches 8 run function cardtable:skin/default8
scoreboard players operation #ctx_id ct_ctx = @s ct_id
execute as @a[tag=ct.player] if score @s ct_id = #ctx_id ct_ctx run function cardtable:seat/remove_player
execute as @e[tag=ct.part] if score @s ct_id = #ctx_id ct_ctx run kill @s
tellraw @a[tag=ct.remove_actor,limit=1] [{text:'[牌桌] ',color:'dark_aqua'},{text:'牌桌会话和交互实体已移除；方块桌及玩家改装均已保留。',color:'green'}]
kill @s
