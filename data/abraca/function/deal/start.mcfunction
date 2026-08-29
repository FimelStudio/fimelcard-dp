# 牌盒先出现并放大，再逐张给每位玩家发五枚牌背。
scoreboard players set @s ab_state 1
scoreboard players set @s ab_phase 1
scoreboard players set @s ab_timer 0
scoreboard players set @s ab_deal 0
scoreboard players set @s ab_scan 0
function cardtable:animation/deal/clear
function cardtable:animation/deal/box/spawn
playsound minecraft:block.chest.open master @a[distance=..16] ~ ~ ~ 0.7 1.25
