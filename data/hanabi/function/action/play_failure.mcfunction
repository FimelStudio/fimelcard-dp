execute as @e[tag=hb.chosen,limit=1] run function hanabi:card/load_definition
function hanabi:player/tag_audience
function hanabi:message/play_failure with storage hanabi:card def
playsound minecraft:entity.firework_rocket.twinkle_far master @a[tag=hb.audience] ~ ~ ~ 1.0 0.55
particle minecraft:smoke ~ ~1.35 ~ 0.45 0.15 0.45 0.03 24 force @a[tag=hb.audience]
function hanabi:log {text:"错误出牌，增加一次失误并尝试补牌"}
scoreboard players add @s hb_strikes 1
scoreboard players operation #played_reward hb_ctx = @e[tag=hb.chosen,limit=1] hb_reward
execute if score #played_reward hb_ctx matches 100.. run function #hanabi:reward_failed
tag @e[tag=hb.chosen,limit=1] remove hb.hand
tag @e[tag=hb.chosen,limit=1] add hb.discard
function hanabi:discard/record_chosen
scoreboard players set @e[tag=hb.chosen,limit=1] hb_seat 0
scoreboard players set @e[tag=hb.chosen,limit=1] hb_slot 0
tag @e[tag=hb.chosen] remove hb.chosen
execute if score @s hb_strikes >= @s hb_strike_max run scoreboard players set @s hb_score 0
execute if score @s hb_strikes >= @s hb_strike_max run scoreboard players set @s hb_reason 1
execute if score @s hb_strikes >= @s hb_strike_max run function hanabi:hud/update
execute if score @s hb_strikes >= @s hb_strike_max run return run function hanabi:game/finish
function hanabi:card/draw_to_slot
function hanabi:hud/update
function hanabi:turn/advance
