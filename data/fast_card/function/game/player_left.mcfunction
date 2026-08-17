# 任意参赛者离线都会破坏四人传牌顺序，因此直接结束本场并让牌桌回到大厅
function fast_card:log {text:"检测到参赛玩家离线，结束当前Fast Card游戏"}
scoreboard players operation #ctx_id fc_ctx = @s fc_id
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'有玩家离线，本场游戏已结束。',color:'red'}]

function fast_card:transition/cleanup
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:player/clear_state
execute as @e[type=minecraft:item,distance=..6] run function fast_card:util/kill_if_card
function fast_card:deal/clear_legacy_box
function cardtable:animation/deal/box/clear
execute as @e[tag=fc.game_entity,distance=..3] if score @s fc_id = #ctx_id fc_ctx run kill @s
kill @e[type=minecraft:marker,tag=fc.deck,distance=..1]

scoreboard players set @s fc_state 0
scoreboard players set @s fc_phase 0
scoreboard players set @s fc_deal 0
scoreboard players reset @s fc_id
scoreboard players reset @s fc_joined
tag @s remove fc.controller
function cardtable:table/recount_players
function cardtable:game/return_lobby
