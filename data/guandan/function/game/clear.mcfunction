function guandan:system/context
scoreboard players set @s gd_state 0
scoreboard players set @s gd_phase 0
scoreboard players set @s gd_timer 0
scoreboard players set @s gd_anim 0
scoreboard players set @s gd_clock 0
function guandan:game/bump_epoch
function guandan:visual/clear
function cardtable:animation/deal/clear
execute as @a[tag=gd.player] if score @s gd_table = #table gd_ctx run function guandan:player/clear_state
execute as @e[type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{guandan:{tool:1b}}] run function guandan:player/kill_drop
execute as @e[type=minecraft:firework_rocket,tag=gd.firework] if score @s ct_id = #table gd_ctx run kill @s
kill @e[tag=gd.cards]
kill @e[tag=gd.board]
data remove entity @s data.guandan
tag @s remove gd.controller
tag @s remove gd.current
