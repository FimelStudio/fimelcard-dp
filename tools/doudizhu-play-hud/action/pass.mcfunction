execute unless score @e[tag=dd.current,limit=1] dd_state matches 3 run return 0
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return run function doudizhu:action/not_turn
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 run tellraw @s {text:"你是本轮领出者，必须出牌。",color:"red"}
execute if score @e[tag=dd.current,limit=1] dd_type matches 0 run return 0
scoreboard players set #submitted dd_ctx 1
function doudizhu:hud/record_pass
execute as @e[tag=dd.current,limit=1] run function doudizhu:player/audience
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:"：不出。",color:"gray"}]
scoreboard players set @e[tag=dd.hand] dd_selected 0
scoreboard players add @e[tag=dd.current,limit=1] dd_passes 1
execute if score @e[tag=dd.current,limit=1] dd_passes matches 2 run scoreboard players set @e[tag=dd.current,limit=1] dd_type 0
execute as @e[tag=dd.current,limit=1] run function doudizhu:round/advance
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
