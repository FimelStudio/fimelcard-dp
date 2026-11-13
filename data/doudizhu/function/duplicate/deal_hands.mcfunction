# 同一牌序按叫分顺序发给两边的第一、第二、第三位玩家。
scoreboard players operation #match dd_ctx = @s ct_id
execute as @e[tag=ct.controller,tag=dd.controller,scores={dd_lane=1}] if score @s ct_id = #match dd_ctx run data modify storage doudizhu:deck queue set from entity @s data.dd_duplicate.deck
scoreboard players set #ordered dd_ctx 1
scoreboard players set #position dd_ctx 0
function doudizhu:deck/assign
scoreboard players set #dealpos dd_ctx 0
scoreboard players operation #first_bidder dd_ctx = @s dd_turn
function doudizhu:duplicate/deal_hand
function doudizhu:round/select_next
function doudizhu:duplicate/deal_hand
function doudizhu:round/select_next
function doudizhu:duplicate/deal_hand
scoreboard players operation @s dd_turn = #first_bidder dd_ctx
