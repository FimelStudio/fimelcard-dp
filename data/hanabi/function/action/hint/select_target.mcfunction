scoreboard players operation #target_seat hb_ctx = #action hb_ctx
scoreboard players remove #target_seat hb_ctx 300
execute if score #target_seat hb_ctx = @s hb_seat run tellraw @s [{text:"[花火] ",color:"light_purple"},{text:"不能提示自己。",color:"red"}]
execute if score #target_seat hb_ctx = @s hb_seat run return run function hanabi:dialog/hint/target

scoreboard players operation @s hb_target = #target_seat hb_ctx
scoreboard players set #found hb_ctx 0
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx run scoreboard players set #found hb_ctx 1
execute unless score #found hb_ctx matches 1 run tellraw @s [{text:"[花火] ",color:"light_purple"},{text:"该座位没有本局玩家。",color:"red"}]
execute unless score #found hb_ctx matches 1 run return run function hanabi:dialog/hint/target

function hanabi:log {text:"提示目标有效，开始构建提示内容Dialog"}
execute if score #target_seat hb_ctx matches 1 run function hanabi:dialog/hint/choice {seat:1}
execute if score #target_seat hb_ctx matches 2 run function hanabi:dialog/hint/choice {seat:2}
execute if score #target_seat hb_ctx matches 3 run function hanabi:dialog/hint/choice {seat:3}
execute if score #target_seat hb_ctx matches 4 run function hanabi:dialog/hint/choice {seat:4}
