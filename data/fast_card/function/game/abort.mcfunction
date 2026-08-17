# 保存编号后清理Fast Card内容，但不删除方块牌桌、座位和已入座玩家
function fast_card:log {text:"管理员中止Fast Card，开始清理运行期状态"}
scoreboard players operation #ctx_id fc_ctx = @s fc_id
function fast_card:transition/cleanup
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'本场游戏已被管理员中止。',color:'red'}]
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
tellraw @a[tag=fc.admin,limit=1] [{text:'[Fast Card] ',color:'gold'},{text:'游戏已结束，牌桌已回到大厅。',color:'green'}]
function cardtable:game/return_lobby
