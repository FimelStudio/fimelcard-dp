function wenfei:input/clear_category_menu
function wenfei:log {text:"清理本桌游戏状态并返回大厅"}
scoreboard players set @s wq_state 0
function wenfei:player/mark_audience
execute as @a[tag=wq.audience] run function wenfei:player/clear_state
execute as @e[tag=wq.game_entity] if score @s wq_id = #ctx wq_ctx run kill @s
execute store result storage wenfei:io cleanup.table int 1 run scoreboard players get @s wq_id
function wenfei:input/cleanup_drops with storage wenfei:io cleanup
function cardtable:animation/deal/clear
data remove entity @s data.wenfei
tag @s remove wq.controller
scoreboard players reset @s wq_id
scoreboard players reset @s wq_state
scoreboard players reset @s wq_players
scoreboard players reset @s wq_round
scoreboard players reset @s wq_total
scoreboard players reset @s wq_turn
scoreboard players reset @s wq_cat
scoreboard players reset @s wq_index
scoreboard players reset @s wq_gain
scoreboard players reset @s wq_epoch
tag @a[tag=wq.audience] remove wq.audience
function cardtable:game/return_lobby
scoreboard players reset @s wq_page
scoreboard players reset @s wq_ptick
