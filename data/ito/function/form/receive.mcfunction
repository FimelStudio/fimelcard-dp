function ito:input/context
execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_input matches 1 run return 0
execute unless score #valid it_ctx matches 1 run return 0
execute unless score @e[tag=it.current,limit=1] it_state matches 2 run return 0
execute store result score #t it_ctx run data get storage ito:form incoming.t
execute store result score #e it_ctx run data get storage ito:form incoming.e
execute store result score #n it_ctx run data get storage ito:form incoming.n
execute store result score #s it_ctx run data get storage ito:form incoming.s
execute unless score #t it_ctx = @s it_table run return 0
execute unless score #e it_ctx = @e[tag=it.current,limit=1] it_epoch run return 0
execute unless score #n it_ctx = @s it_window run return 0
scoreboard players operation #slot it_ctx = #s it_ctx
execute unless score #slot it_ctx matches 1..3 run return 0
data modify storage ito:input incoming set from storage ito:form incoming.a
function ito:input/save
function ito:input/book_return
