scoreboard players set #review_ok go_ctx 0
function weiqi:game/actor_guard
execute unless score #actor_ok go_ctx matches 1 run return 0
execute unless score @s ct_state matches 0 run return 0
execute unless data entity @s data.weiqi{review:1b} run return 0
execute unless score @a[tag=go.actor,limit=1] go_revelig matches 1 run return 0
execute unless score @a[tag=go.actor,limit=1] go_reviewtable = #table go_ctx run return 0
scoreboard players set #review_ok go_ctx 1
