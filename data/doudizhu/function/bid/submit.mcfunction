execute unless score @e[tag=dd.current,limit=1] dd_state matches 2 run return 0
execute if score @e[tag=dd.current,limit=1] dd_bidmode matches 1..2 run return 0
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return run function doudizhu:action/not_turn
scoreboard players operation #bid dd_ctx = #action dd_ctx
scoreboard players remove #bid dd_ctx 200
execute if score #bid dd_ctx matches 1.. if score #bid dd_ctx <= @e[tag=dd.current,limit=1] dd_bid run return 0
scoreboard players set #submitted dd_ctx 1
execute if score #bid dd_ctx matches 1.. run scoreboard players operation @e[tag=dd.current,limit=1] dd_bid = #bid dd_ctx
execute if score #bid dd_ctx matches 1.. run scoreboard players operation @e[tag=dd.current,limit=1] dd_lord = @s dd_seat
execute as @e[tag=dd.current,limit=1] run function doudizhu:player/audience
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 叫分：",color:"gray"},{score:{name:"#bid",objective:"dd_ctx"},color:"gold"},{text:"（0表示不叫）",color:"gray"}]
scoreboard players add @e[tag=dd.current,limit=1] dd_bidcount 1
execute if score @e[tag=dd.current,limit=1] dd_bid matches 3 as @e[tag=dd.current,limit=1] at @s run return run function doudizhu:bid/finish
execute if score @e[tag=dd.current,limit=1] dd_bidcount matches 3 as @e[tag=dd.current,limit=1] at @s run return run function doudizhu:bid/finish
execute as @e[tag=dd.current,limit=1] run function doudizhu:round/advance
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
