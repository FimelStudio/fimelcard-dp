# 进入下一小局并清理上一局残留
scoreboard players add @s fc_round 1
execute store result storage fast_card:debug round int 1 run scoreboard players get @s fc_round
function fast_card:debug/log_round_begin with storage fast_card:debug
scoreboard players set @s fc_state 1
scoreboard players set @s fc_phase 0
scoreboard players set @s fc_press 0
scoreboard players set @s fc_mode 0
scoreboard players set @s fc_timer 0
scoreboard players set @s fc_deal 0
scoreboard players operation #ctx_id fc_ctx = @s fc_id

# 清除上次过场、牌堆、掉落牌和玩家手牌
function fast_card:transition/cleanup
function fast_card:deal/clear_legacy_box
function cardtable:animation/deal/box/clear
function fast_card:table/clear_button
kill @e[type=minecraft:marker,tag=fc.deck,distance=..1]
execute as @e[type=minecraft:item,distance=..6] run function fast_card:util/kill_if_card
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:util/clear_cards
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players set @s fc_order 0
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players operation @s fc_delta = @s fc_score
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.pressed
execute as @a[tag=fc.turn] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.turn
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:pass/reset_drop

# 首位玩家和完整牌堆先准备好，40刻过场结束后再逐张发出
execute store result score @s fc_turn run random value 1..4
function fast_card:deck/create
function fast_card:transition/round_title
function fast_card:log {text:"小局过场开始，显示两秒局数文字"}
