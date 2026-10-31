scoreboard players set @s ch_pulse 0
function chess:system/context
execute if score @s ct_state matches 0 run function chess:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online ch_ctx 0
execute as @a[tag=ch.audience] run scoreboard players add #online ch_ctx 1
scoreboard players set #expected ch_ctx 2
execute unless score @s ch_bot matches 0 run scoreboard players set #expected ch_ctx 1
execute unless score #online ch_ctx = #expected ch_ctx run return run function chess:game/abort
function chess:clock/update
