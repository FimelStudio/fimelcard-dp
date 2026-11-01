scoreboard players set @s gd_state 3
scoreboard players set @s gd_phase 0
scoreboard players operation @s gd_turn = @s gd_first
scoreboard players set @s gd_lastkind 0
scoreboard players set @s gd_lastseat -1
scoreboard players set @s gd_passes 0
function guandan:game/bump_epoch
function guandan:clock/reset
function guandan:visual/refresh
function guandan:hud/refresh
function guandan:ui/refresh
