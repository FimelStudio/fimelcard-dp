# 最终排行榜按分数从高到低输出；同分时按座位号稳定排序
function fast_card:log {text:"开始生成最终排行榜并清理Fast Card运行期状态"}
scoreboard players operation #ctx_id fc_ctx = @s fc_id
function fast_card:transition/cleanup
scoreboard players set @s fc_rank 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.ranked

execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run title @s title {text:'游戏结束',color:'gold',bold:true}
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'========== Fast Card 排行榜 ==========',color:'gold',bold:true}]
function fast_card:ranking/one
function fast_card:ranking/one
function fast_card:ranking/one
function fast_card:ranking/one
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'====================================',color:'gold'}]

# 排行显示完成后只清理Fast Card运行期内容，保留通用方块牌桌与座位
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
function cardtable:game/return_lobby
