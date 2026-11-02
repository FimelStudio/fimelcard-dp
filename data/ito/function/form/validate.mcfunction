function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
scoreboard players set #length it_ctx 0
$execute store result score #length it_ctx run data get storage ito:form incoming.a$(slot)
execute unless score #length it_ctx matches 1..48 run scoreboard players set #batch_bad it_ctx 1
