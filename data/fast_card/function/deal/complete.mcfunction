# 此时最后一张牌已经有足够时间被对应玩家拾取
function fast_card:round/sync_turn
function fast_card:log {text:"发牌动画全部完成，进入传牌阶段"}
function fast_card:table/spawn_button
scoreboard players set @s fc_state 2
scoreboard players set @s fc_phase 0
scoreboard players set @s fc_timer 0
scoreboard players operation #ctx_id fc_ctx = @s fc_id
scoreboard players operation #ctx_turn fc_ctx = @s fc_turn
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx if score @s fc_seat = #ctx_turn fc_ctx run tag @s add fc.turn
function fast_card:util/announce_turn
