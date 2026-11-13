function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
scoreboard players set #code ca_ctx 23
function catan:direct/confirm
