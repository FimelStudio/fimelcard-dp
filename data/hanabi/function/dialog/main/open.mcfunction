# 仅当前回合玩家能够打开；所有牌位点击仍会在action层重新校验
execute unless entity @s[tag=hb.player,tag=hb.turn] run return fail
scoreboard players operation #ctx_id hb_ctx = @s hb_id
tag @e[tag=hb.dialog_controller] remove hb.dialog_controller
execute as @e[type=minecraft:marker,tag=hb.controller] if score @s hb_id = #ctx_id hb_ctx run tag @s add hb.dialog_controller
execute unless entity @e[tag=hb.dialog_controller,limit=1] run return fail

scoreboard players set @s hb_action 0
scoreboard players enable @s hb_action
dialog clear @s

execute store result storage hanabi:dialog clues int 1 run scoreboard players get @e[tag=hb.dialog_controller,limit=1] hb_clues
execute store result storage hanabi:dialog clue_max int 1 run scoreboard players get @e[tag=hb.dialog_controller,limit=1] hb_clue_max
execute store result storage hanabi:dialog strikes int 1 run scoreboard players get @e[tag=hb.dialog_controller,limit=1] hb_strikes
execute store result storage hanabi:dialog strike_max int 1 run scoreboard players get @e[tag=hb.dialog_controller,limit=1] hb_strike_max
execute store result storage hanabi:dialog deck int 1 run scoreboard players get @e[tag=hb.dialog_controller,limit=1] hb_deck_count
execute store result storage hanabi:dialog reward int 1 run scoreboard players get @e[tag=hb.dialog_controller,limit=1] hb_reward_left
data modify storage hanabi:dialog play set value {text:"出牌：　",color:"green",bold:true,extra:[]}
data modify storage hanabi:dialog discard set value {text:"弃牌：　",color:"red",bold:true,extra:[]}
scoreboard players set #dialog_added hb_ctx 0
scoreboard players operation #actor_seat hb_ctx = @s hb_seat
data modify storage hanabi:dialog rows set value {text:"其他玩家的手牌（你能够看见，持有者本人看不见）\n",color:"gray",extra:[]}
execute unless score #actor_seat hb_ctx matches 1 run function hanabi:dialog/main/append_row {seat:1}
execute unless score #actor_seat hb_ctx matches 2 run function hanabi:dialog/main/append_row {seat:2}
execute unless score #actor_seat hb_ctx matches 3 run function hanabi:dialog/main/append_row {seat:3}
execute unless score #actor_seat hb_ctx matches 4 run function hanabi:dialog/main/append_row {seat:4}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=1}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx run function hanabi:dialog/main/append {play:101,discard:201}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=2}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx run function hanabi:dialog/main/append {play:102,discard:202}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=3}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx run function hanabi:dialog/main/append {play:103,discard:203}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=4}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx run function hanabi:dialog/main/append {play:104,discard:204}
execute as @e[type=minecraft:marker,tag=hb.hand,scores={hb_slot=5}] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #actor_seat hb_ctx run function hanabi:dialog/main/append {play:105,discard:205}
function hanabi:dialog/main/show with storage hanabi:dialog
tag @e[tag=hb.dialog_controller] remove hb.dialog_controller
