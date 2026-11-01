scoreboard players operation @s gd_actor = #actor gd_ctx
data modify entity @s data.guandan.action set value {cardtypes:[],ids:[]}
data modify entity @s data.guandan.action.label set from entity @s data.guandan.chosen.label
data modify entity @s data.guandan.action.suit set from entity @s data.guandan.chosen.suit
data modify entity @s data.guandan.action.point set from entity @s data.guandan.chosen.point
data modify entity @s data.guandan.action.text set value {text:""}
data modify entity @s data.guandan.action.text.text set from entity @s data.guandan.chosen.label
execute store result entity @s data.guandan.action.seat int 1 run scoreboard players get #actor gd_ctx
execute store result entity @s data.guandan.action.kind int 1 run scoreboard players get @s gd_kind
execute store result entity @s data.guandan.action.size int 1 run scoreboard players get @s gd_size
execute store result entity @s data.guandan.action.high int 1 run scoreboard players get @s gd_high
execute store result entity @s data.guandan.action.power int 1 run scoreboard players get @s gd_power
execute store result entity @s data.guandan.action.round int 1 run scoreboard players get @s gd_round
execute as @e[tag=gd.cards,scores={gd_sel=1}] if score @s gd_owner = #actor gd_ctx run function guandan:game/commit_card
scoreboard players operation #played gd_ctx = @s gd_size
execute as @e[tag=gd.board] if score @s gd_seat = #actor gd_ctx run function guandan:game/commit_part
scoreboard players operation @s gd_lastseat = #actor gd_ctx
scoreboard players operation @s gd_lastkind = @s gd_kind
scoreboard players operation @s gd_lastsize = @s gd_size
scoreboard players operation @s gd_lasthi = @s gd_high
scoreboard players operation @s gd_lastpow = @s gd_power
scoreboard players set @s gd_passes 0
scoreboard players set @s gd_anim 8
function guandan:visual/play
function guandan:sound/play
execute if score @s gd_kind matches 8 run function guandan:sound/bomb
execute if score @s gd_kind matches 9..10 run function guandan:sound/straight_flush
function guandan:game/announce_play
function guandan:round/check_end
execute if score @s gd_state matches 3 run function guandan:game/next_turn
function guandan:game/bump_epoch
function guandan:hud/refresh
function guandan:ui/refresh
scoreboard players set #ok gd_ctx 1
