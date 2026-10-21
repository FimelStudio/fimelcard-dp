execute unless entity @e[tag=dd.current,scores={dd_state=2,dd_bidmode=2},limit=1] run return 0
scoreboard players set #submitted dd_ctx 1
scoreboard players set @e[tag=dd.current,limit=1] dd_bid 1
scoreboard players operation @e[tag=dd.current,limit=1] dd_lord = @s dd_seat
execute as @e[tag=dd.current,limit=1] run function doudizhu:player/audience
# 地主确定后立即关闭本桌所有真人的叫地主窗口，包括获选玩家。
dialog clear @a[tag=dd.audience]
tellraw @a[tag=dd.audience] [{selector:"@s",color:"yellow"},{text:" 最先叫地主！",color:"gold"}]
execute as @e[tag=dd.current,limit=1] at @s run function doudizhu:bid/finish
