scoreboard players set @s gm_pulse 0
function gomoku:system/context
execute if score @s ct_state matches 0 run function gomoku:system/check_visual
execute unless score @s ct_state matches 1 run return 0
scoreboard players set #online gm_ctx 0
execute as @a[tag=gm.audience] run scoreboard players add #online gm_ctx 1
scoreboard players set #expected gm_ctx 2
execute unless score @s gm_bot matches 0 run scoreboard players set #expected gm_ctx 1
execute unless score #online gm_ctx = #expected gm_ctx run return run function gomoku:game/abort
function gomoku:clock/update
