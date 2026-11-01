execute unless score @s ct_game matches 19 run return run function ito:game/abort
execute unless score @s ct_state matches 1 run return run function ito:game/remove
function ito:system/context
function ito:game/epoch
execute as @a[tag=it.audience] run scoreboard players set @s it_action 0
execute as @a[tag=it.audience] run scoreboard players enable @s it_action
execute as @a[tag=it.audience] run dialog clear @s
function ito:hud/refresh
function ito:visual/refresh
