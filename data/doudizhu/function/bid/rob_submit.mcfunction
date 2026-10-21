execute unless entity @e[tag=dd.current,scores={dd_state=2,dd_bidmode=1},limit=1] run return 0
execute unless score @s dd_seat = @e[tag=dd.current,limit=1] dd_turn run return 0
execute if score @e[tag=dd.current,limit=1] dd_bidphase matches 1 unless score @s dd_eligible matches 1 run return 0
execute if score #action dd_ctx matches 204 unless score @e[tag=dd.current,limit=1] dd_bid matches 0 run return 0
execute if score #action dd_ctx matches 205 unless score @e[tag=dd.current,limit=1] dd_bid matches 1 run return 0
scoreboard players set #submitted dd_ctx 1
execute as @e[tag=dd.current,limit=1] run function doudizhu:player/audience
execute if score #action dd_ctx matches 204 run scoreboard players operation @e[tag=dd.current,limit=1] dd_firstcall = @s dd_seat
execute if score #action dd_ctx matches 204..205 run scoreboard players operation @e[tag=dd.current,limit=1] dd_lord = @s dd_seat
execute if score #action dd_ctx matches 204..205 run scoreboard players set @e[tag=dd.current,limit=1] dd_bid 1
execute if score #action dd_ctx matches 204..205 if score @e[tag=dd.current,limit=1] dd_bidphase matches 0 run scoreboard players set @s dd_eligible 1
execute if score #action dd_ctx matches 205 run scoreboard players operation @e[tag=dd.current,limit=1] dd_mult += @e[tag=dd.current,limit=1] dd_mult
execute if score #action dd_ctx matches 204 run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 叫地主。",color:"gold"}]
execute if score #action dd_ctx matches 205 run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 抢地主，当前倍数 ×",color:"gold"},{score:{name:"@e[tag=dd.current,limit=1]",objective:"dd_mult"}}]
execute if score #action dd_ctx matches 206 run tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 不叫。",color:"gray"}]
execute as @e[tag=dd.current,limit=1] at @s run function doudizhu:bid/rob_step
