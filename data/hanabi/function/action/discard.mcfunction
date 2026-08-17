function hanabi:action/select_card
execute unless entity @e[tag=hb.chosen,limit=1] run return run execute as @a[tag=hb.action_actor,limit=1] run function hanabi:hand/sync

execute as @e[tag=hb.chosen,limit=1] run function hanabi:card/load_definition
function hanabi:player/tag_audience
function hanabi:message/discard with storage hanabi:card def
playsound minecraft:item.book.page_turn master @a[tag=hb.audience] ~ ~ ~ 0.7 0.85
function hanabi:log {text:"弃牌合法，返还提示标记并尝试补牌"}
scoreboard players add @s hb_clues 1
execute if score @s hb_clues > @s hb_clue_max run scoreboard players operation @s hb_clues = @s hb_clue_max
scoreboard players operation #played_reward hb_ctx = @e[tag=hb.chosen,limit=1] hb_reward
execute if score #played_reward hb_ctx matches 100.. run function #hanabi:reward_discarded
tag @e[tag=hb.chosen,limit=1] remove hb.hand
tag @e[tag=hb.chosen,limit=1] add hb.discard
function hanabi:discard/record_chosen
scoreboard players set @e[tag=hb.chosen,limit=1] hb_seat 0
scoreboard players set @e[tag=hb.chosen,limit=1] hb_slot 0
tag @e[tag=hb.chosen] remove hb.chosen
function hanabi:card/draw_to_slot
function hanabi:hud/update
function hanabi:turn/advance
