function catan:input/context
execute store result score #code ca_ctx run data get entity @e[tag=ca.current,limit=1] data.catan.eligible[0]
scoreboard players add #code ca_ctx 400
function catan:direct/submit
