execute unless score @e[tag=dd.current,limit=1] dd_state matches 3 run return 0
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return run function doudizhu:action/not_turn
function doudizhu:rules/classify
execute if score #type dd_ctx matches 0 run tellraw @s {text:"所选牌不组成合法牌型，请重新选择。",color:"red"}
execute if score #type dd_ctx matches 0 run return 0
scoreboard players set #beats dd_ctx 0
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 run scoreboard players set #beats dd_ctx 1
execute if score #type dd_ctx matches 14 run scoreboard players set #beats dd_ctx 1
execute if score #type dd_ctx matches 13 if score @e[tag=dd.current,limit=1] dd_type matches 1..12 run scoreboard players set #beats dd_ctx 1
execute if score #type dd_ctx = @e[tag=dd.current,limit=1] dd_type if score #n dd_ctx = @e[tag=dd.current,limit=1] dd_len if score #high dd_ctx > @e[tag=dd.current,limit=1] dd_high run scoreboard players set #beats dd_ctx 1
execute unless score #beats dd_ctx matches 1 run tellraw @s {text:"所选牌不能压过上一手。",color:"red"}
execute unless score #beats dd_ctx matches 1 run return 0
function doudizhu:hand/build_play
data modify entity @e[tag=dd.current,limit=1] data.doudizhu.last_play set from storage doudizhu:ui played
execute as @e[tag=dd.current,limit=1] run function doudizhu:player/audience
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 出牌：",color:"gray"},{nbt:"played",storage:"doudizhu:ui",interpret:true}]
scoreboard players operation @e[tag=dd.current,limit=1] dd_type = #type dd_ctx
scoreboard players operation @e[tag=dd.current,limit=1] dd_high = #high dd_ctx
scoreboard players operation @e[tag=dd.current,limit=1] dd_len = #n dd_ctx
scoreboard players operation @e[tag=dd.current,limit=1] dd_last = @s dd_seat
scoreboard players set @e[tag=dd.current,limit=1] dd_passes 0
execute if score #type dd_ctx matches 13..14 run scoreboard players operation @e[tag=dd.current,limit=1] dd_mult += @e[tag=dd.current,limit=1] dd_mult
scoreboard players add @s dd_plays 1
scoreboard players set @e[tag=dd.hand,scores={dd_selected=1}] dd_owner -1
scoreboard players set @e[tag=dd.hand] dd_selected 0
scoreboard players set #remaining dd_ctx 0
execute as @e[tag=dd.hand] if score @s dd_owner = #owner dd_ctx run scoreboard players add #remaining dd_ctx 1
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 剩余 ",color:"gray"},{score:{name:"#remaining",objective:"dd_ctx"},color:"gold"},{text:" 张牌。",color:"gray"}]
execute if score #remaining dd_ctx matches 0 run scoreboard players operation #winner dd_ctx = @s dd_seat
execute if score #remaining dd_ctx matches 0 as @e[tag=dd.current,limit=1] at @s run return run function doudizhu:game/finish
execute as @e[tag=dd.current,limit=1] run function doudizhu:round/advance
tag @a[tag=dd.audience] remove dd.audience
