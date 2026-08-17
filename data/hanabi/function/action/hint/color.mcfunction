execute unless score @s hb_clues matches 1.. run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"提示标记已经用完。",color:"red"}]
execute unless score @s hb_clues matches 1.. run return 0
function hanabi:action/hint/find_target
execute unless entity @a[tag=hb.hint_target,limit=1] as @a[tag=hb.action_actor,limit=1] run function hanabi:dialog/hint/target
execute unless entity @a[tag=hb.hint_target,limit=1] run return 0

scoreboard players set #matches hb_ctx 0
scoreboard players operation #target_seat hb_ctx = @a[tag=hb.hint_target,limit=1] hb_seat
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx if score @s hb_color = #hint_value hb_ctx run scoreboard players add #matches hb_ctx 1
execute unless score #matches hb_ctx matches 1.. run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"这个颜色没有命中任何牌，不能作出该提示。",color:"red"}]
execute unless score #matches hb_ctx matches 1.. run return run execute as @a[tag=hb.action_actor,limit=1] run function hanabi:action/hint/reopen_choice

execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx if score @s hb_color = #hint_value hb_ctx run scoreboard players set @s hb_known_c 1
scoreboard players remove @s hb_clues 1
execute as @a[tag=hb.hint_target,limit=1] run function hanabi:hand/sync
function hanabi:player/tag_audience
function hanabi:message/hint_color
playsound minecraft:block.amethyst_block.chime master @a[tag=hb.audience] ~ ~ ~ 0.8 1.25
function hanabi:log {text:"颜色提示完成，已更新所有命中手牌的颜色知识"}
tag @a[tag=hb.hint_target] remove hb.hint_target
function hanabi:turn/advance
