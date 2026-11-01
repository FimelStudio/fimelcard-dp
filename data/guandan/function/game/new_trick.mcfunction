scoreboard players operation #leader gd_ctx = @s gd_lastseat
scoreboard players operation @s gd_turn = #leader gd_ctx
scoreboard players set #finished gd_ctx 0
execute as @e[tag=gd.board,scores={gd_rank=1..4}] if score @s gd_seat = #leader gd_ctx run function guandan:game/borrow_wind
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastseat -1
scoreboard players set @s gd_passes 0
scoreboard players set @e[tag=gd.cards] gd_used 0
execute as @e[tag=gd.board] run data modify entity @s data.last_play set value []
execute as @e[tag=gd.board] run data modify entity @s data.last_label set value ""
function guandan:visual/collect
function guandan:game/bump_epoch
function guandan:clock/reset
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
