dialog clear @a[tag=hb.action_actor,limit=1]
function hanabi:hud/update
function hanabi:player/tag_audience
scoreboard players operation #ctx_id hb_ctx = @s hb_id

# 牌库为空后继续处理剩余手牌；只有全桌普通手牌清空才结束
scoreboard players set #hand_left hb_ctx 0
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx run scoreboard players add #hand_left hb_ctx 1
execute if score @s hb_deck_count matches 0 unless score #hand_left hb_ctx matches 1.. run scoreboard players set @s hb_reason 2
execute if score @s hb_reason matches 2 run function hanabi:score/update
execute if score @s hb_reason matches 2 run return run function hanabi:game/finish

execute as @a[tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run function hanabi:input/clear_actions
execute as @a[tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run dialog clear @s
execute as @a[tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run tag @s remove hb.turn
scoreboard players set #found hb_ctx 0
scoreboard players operation @s hb_scan = @s hb_turn
function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute if score #found hb_ctx matches 0 run function hanabi:turn/scan_once
execute unless score #found hb_ctx matches 1 run scoreboard players set @s hb_reason 4
execute unless score #found hb_ctx matches 1 run return run function hanabi:game/finish
scoreboard players operation @s hb_turn = @s hb_scan
function hanabi:log {text:"回合已推进到下一名玩家"}
tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{text:"现在轮到 ",color:"gray"},{selector:"@a[tag=hb.turn,tag=hb.audience,limit=1]",color:"yellow"},{text:"。",color:"gray"}]
execute if score @s hb_clues matches 1.. as @a[tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run function hanabi:input/give_hint
execute as @a[tag=hb.turn] if score @s hb_id = #ctx_id hb_ctx run playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.8 1.35
