# 牌盒先从0.1倍放大，再按座位轮流发完所有起始手牌
scoreboard players set @s hb_state 1
scoreboard players set @s hb_phase 1
scoreboard players set @s hb_timer 0
scoreboard players set @s hb_deal 0
scoreboard players set @s hb_scan 0
function cardtable:animation/deal/clear
function cardtable:animation/deal/box/spawn
playsound minecraft:block.chest.open master @a[distance=..16] ~ ~ ~ 0.7 1.25

