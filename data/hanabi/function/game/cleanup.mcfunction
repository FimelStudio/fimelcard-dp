# 正常结束、投票、掉线和管理员中止统一经过本入口
scoreboard players operation #ctx_id hb_ctx = @s hb_id
function cardtable:animation/deal/clear

execute store result storage hanabi:cleanup table int 1 run scoreboard players get @s hb_id
function hanabi:game/cleanup_drops with storage hanabi:cleanup
execute as @e[tag=hb.game_entity,distance=..8] if score @s hb_id = #ctx_id hb_ctx run kill @s
execute as @a[tag=hb.player] if score @s hb_id = #ctx_id hb_ctx run function hanabi:player/clear_state

scoreboard players reset @s hb_id
scoreboard players reset @s hb_state
scoreboard players reset @s hb_phase
scoreboard players reset @s hb_timer
scoreboard players reset @s hb_players
scoreboard players reset @s hb_turn
scoreboard players reset @s hb_hand_size
scoreboard players reset @s hb_deal
scoreboard players reset @s hb_total
scoreboard players reset @s hb_scan
scoreboard players reset @s hb_deck_count
scoreboard players reset @s hb_clues
scoreboard players reset @s hb_strikes
scoreboard players reset @s hb_final
scoreboard players reset @s hb_score
scoreboard players reset @s hb_wstack
scoreboard players reset @s hb_rstack
scoreboard players reset @s hb_bstack
scoreboard players reset @s hb_ystack
scoreboard players reset @s hb_gstack
scoreboard players reset @s hb_mstack
scoreboard players reset @s hb_reason
scoreboard players reset @s hb_pending_slot
scoreboard players reset @s hb_discard_count
scoreboard players reset @s hb_reward_left
scoreboard players reset @s hb_reward_pending
tag @s remove hb.reward_external_wait
tag @s remove hb.controller

function cardtable:table/recount_players
function cardtable:game/return_lobby
