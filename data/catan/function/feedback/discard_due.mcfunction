$execute store result score #due ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.p$(side).discard_due
execute unless score #due ca_ctx matches 1.. run return 0
execute store result storage catan:feedback due int 1 run scoreboard players get #due ca_ctx
function catan:feedback/discard_message with storage catan:feedback
