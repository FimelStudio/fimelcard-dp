execute unless score @s hb_clues matches 1.. run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"提示标记已经用完。",color:"red"}]
execute unless score @s hb_clues matches 1.. run return 0
function hanabi:action/hint/find_target
execute unless entity @a[tag=hb.hint_target,limit=1] as @a[tag=hb.action_actor,limit=1] run function hanabi:dialog/hint/target
execute unless entity @a[tag=hb.hint_target,limit=1] run return 0

scoreboard players set #matches hb_ctx 0
scoreboard players operation #target_seat hb_ctx = @a[tag=hb.hint_target,limit=1] hb_seat
execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx if score @s hb_rank = #hint_value hb_ctx run scoreboard players add #matches hb_ctx 1
execute unless score #matches hb_ctx matches 1.. run tellraw @a[tag=hb.action_actor,limit=1] [{text:"[花火] ",color:"light_purple"},{text:"这个数字没有命中任何牌，不能作出该提示。",color:"red"}]
execute unless score #matches hb_ctx matches 1.. run return run execute as @a[tag=hb.action_actor,limit=1] run function hanabi:action/hint/reopen_choice

execute as @e[type=minecraft:marker,tag=hb.hand] if score @s hb_id = #ctx_id hb_ctx if score @s hb_seat = #target_seat hb_ctx if score @s hb_rank = #hint_value hb_ctx run scoreboard players set @s hb_known_n 1
scoreboard players remove @s hb_clues 1
execute as @a[tag=hb.hint_target,limit=1] run function hanabi:hand/sync
function hanabi:player/tag_audience
tellraw @a[tag=hb.audience] [{text:"[花火] ",color:"light_purple"},{selector:"@a[tag=hb.action_actor,limit=1]",color:"yellow"},{text:" 提示了 ",color:"gray"},{selector:"@a[tag=hb.hint_target,limit=1]",color:"aqua"},{text:" 的数字 ",color:"gray"},{score:{name:"#hint_value",objective:"hb_ctx"},color:"gold"},{text:"（共命中 ",color:"gray"},{score:{name:"#matches",objective:"hb_ctx"},color:"gold"},{text:" 张）。",color:"gray"}]
playsound minecraft:block.note_block.pling master @a[tag=hb.audience] ~ ~ ~ 0.8 1.5
function hanabi:log {text:"数字提示完成，已更新所有命中手牌的数字知识"}
tag @a[tag=hb.hint_target] remove hb.hint_target
function hanabi:turn/advance
