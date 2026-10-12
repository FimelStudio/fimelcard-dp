execute if score @s dd_bid matches 0 run return run function doudizhu:deal/start
function doudizhu:player/audience
tag @e[tag=dd.bottom] remove dd.bottom
execute as @e[tag=dd.card,scores={dd_owner=0}] if score @s dd_id = #ctx dd_ctx run tag @s add dd.bottom
execute as @e[tag=dd.card,scores={dd_owner=0}] if score @s dd_id = #ctx dd_ctx run scoreboard players operation @s dd_owner = @e[tag=dd.current,limit=1] dd_lord
scoreboard players operation @s dd_turn = @s dd_lord
scoreboard players set @s dd_state 3
execute as @e[tag=dd.actors] if score @s dd_seat = @e[tag=dd.current,limit=1] dd_lord run tellraw @a[tag=dd.audience] [{text:"地主：",color:"gold"},{selector:"@s",color:"yellow"},{text:"。底牌已加入地主手牌。",color:"gray"}]
tag @e[tag=dd.bottom] add dd.bottom_card
tag @e[tag=dd.hand] remove dd.hand
tag @e[tag=dd.bottom] add dd.hand
scoreboard players set @e[tag=dd.bottom] dd_selected 1
function doudizhu:hand/build_play
tellraw @a[tag=dd.audience] [{text:"底牌：",color:"gold"},{nbt:"played",storage:"doudizhu:ui",interpret:true}]
scoreboard players set @e[tag=dd.bottom] dd_selected 0
tag @e[tag=dd.bottom] remove dd.bottom
tag @e[tag=dd.hand] remove dd.hand
function doudizhu:round/announce
function doudizhu:system/refresh
