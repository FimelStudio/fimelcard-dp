function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
scoreboard players operation @s ca_seen = @e[tag=ca.current,limit=1] ca_epoch
function catan:ui/simple {code:29}
