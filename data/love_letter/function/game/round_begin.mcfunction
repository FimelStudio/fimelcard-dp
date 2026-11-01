function love_letter:system/context
scoreboard players add @s ll_round 1
scoreboard players set @s ll_state 1
scoreboard players set @s ll_timer 3
scoreboard players set @s ll_dealseat 0
scoreboard players set @s ll_dealstage 0
scoreboard players set @s ll_anim 0
scoreboard players set @s ll_timeout 0
function love_letter:game/bump_epoch
function love_letter:engine/start_round
function love_letter:visual/refresh
function love_letter:sound/start
tellraw @a[tag=ll.audience] [{text:"[情书] 第",color:"gold"},{score:{name:"@s",objective:"ll_round"}},{text:"轮开始。"}]
function love_letter:hud/refresh
