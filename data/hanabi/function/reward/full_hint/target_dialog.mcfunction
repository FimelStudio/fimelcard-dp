scoreboard players set @s hb_action 0
scoreboard players enable @s hb_action
scoreboard players operation #ctx_id hb_ctx = @s hb_id
scoreboard players operation #actor_seat hb_ctx = @s hb_seat
scoreboard players set #option_added hb_ctx 0
tag @a[tag=hb.full_hint_option] remove hb.full_hint_option
data modify storage hanabi:reward full_hint_target_body set value {text:"这张奖励会直接公开目标的一张牌，同时揭示颜色和数字。请选择其他仍有手牌的玩家。\n\n",color:"gray",extra:[]}

function hanabi:reward/full_hint/append_target {seat:1,action:1101}
function hanabi:reward/full_hint/append_target {seat:2,action:1102}
function hanabi:reward/full_hint/append_target {seat:3,action:1103}
function hanabi:reward/full_hint/append_target {seat:4,action:1104}

execute unless score #option_added hb_ctx matches 1.. run data modify storage hanabi:reward full_hint_target_body.extra append value {text:"当前没有可选择的其他玩家，本次奖励将无效果结算。",color:"yellow",click_event:{action:"run_command",command:"trigger hb_action set 1199"}}
function hanabi:reward/full_hint/show_target with storage hanabi:reward
tag @a[tag=hb.full_hint_option] remove hb.full_hint_option
