scoreboard players set @s sk_state 0
function skull:player/audience
execute as @a[tag=sk.audience] run function skull:player/clear_state
execute as @e[tag=sk.game_entity] if score @s sk_id = #ctx sk_ctx run kill @s
execute store result storage skull:io cleanup.table int 1 run scoreboard players get @s sk_id
function skull:input/cleanup with storage skull:io cleanup
function cardtable:animation/deal/clear
data remove entity @s data.skull
tag @s remove sk.controller
scoreboard players reset @s sk_id
scoreboard players reset @s sk_state
scoreboard players reset @s sk_round
scoreboard players reset @s sk_first
scoreboard players reset @s sk_turn
scoreboard players reset @s sk_lead
scoreboard players reset @s sk_bid
scoreboard players reset @s sk_total
scoreboard players reset @s sk_flipped
scoreboard players reset @s sk_source
scoreboard players reset @s sk_epoch
scoreboard players reset @s sk_timer
scoreboard players reset @s sk_players
scoreboard players reset @s sk_deal_seat
scoreboard players reset @s sk_deal_slot
scoreboard players reset @s sk_deal_time
function skull:log {text:"已清理本桌游戏状态及动画"}
function cardtable:game/return_lobby
