execute unless data entity @s data.weiqi{review:1b} run return 0
function weiqi:system/context
execute as @a[tag=go.audience,scores={go_revelig=1}] if score @s go_reviewtable = #table go_ctx run function weiqi:input/give
