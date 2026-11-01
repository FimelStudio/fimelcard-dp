execute unless score @s ct_state matches 1 run return 0
function weiqi:system/context
scoreboard players set #online go_ctx 0
execute as @a[tag=go.audience] run scoreboard players add #online go_ctx 1
scoreboard players set #expected go_ctx 2
execute unless score @s go_bot matches 0 run scoreboard players set #expected go_ctx 1
execute unless score #online go_ctx = #expected go_ctx run function weiqi:game/abort
