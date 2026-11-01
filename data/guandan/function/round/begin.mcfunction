function guandan:system/context
scoreboard players add @s gd_round 1
scoreboard players set @s gd_state 1
scoreboard players set @s gd_phase 0
scoreboard players set @s gd_anim 0
scoreboard players set @s gd_timer 2
scoreboard players set @s gd_dealt 0
scoreboard players set @s gd_done 0
scoreboard players set @s gd_scored 0
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastseat -1
scoreboard players set @s gd_passes 0
scoreboard players set @s gd_tribn 0
scoreboard players set @e[tag=gd.board] gd_rank 0
scoreboard players set @e[tag=gd.board] gd_count 0
scoreboard players set @e[tag=gd.board] gd_tribute 0
scoreboard players set @e[tag=gd.board] gd_return 0
scoreboard players set @e[tag=gd.board] gd_giftid -1
scoreboard players set @e[tag=gd.board] gd_returnid -1
execute as @e[tag=gd.board] run data modify entity @s data.last_play set value []
execute as @e[tag=gd.board] run data modify entity @s data.last_label set value ""
data modify entity @s data.guandan.action set value {}
data modify entity @s data.guandan.options set value []
function guandan:game/bump_epoch
function guandan:deck/build
scoreboard players operation @s gd_first = @e[tag=gd.board,sort=random,limit=1] gd_seat
scoreboard players operation #first gd_ctx = @s gd_first
execute as @e[tag=gd.board] if score @s gd_seat = #first gd_ctx run scoreboard players operation @e[tag=gd.current,limit=1] gd_dealorder = @s gd_order
function guandan:visual/refresh
function guandan:visual/shuffle
function guandan:sound/start
tellraw @a[tag=gd.audience] [{text:"[掼蛋] 第",color:"gold"},{score:{name:"@s",objective:"gd_round"}},{text:"副开始，打 "},{score:{name:"@s",objective:"gd_level"}},{text:" 级。"}]
function guandan:hud/refresh
