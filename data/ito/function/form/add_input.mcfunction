function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
execute store result storage ito:form field.number int 1 run scoreboard players get @e[tag=it.focus,limit=1] it_number
execute store result storage ito:form field.slot int 1 run scoreboard players get #slot it_ctx
function ito:form/field with storage ito:form field
data modify storage ito:form dialog.inputs[-1].initial set from entity @e[tag=it.focus,limit=1] data.description
execute if score #slot it_ctx matches 1 run data modify storage ito:form a1 set value "$(a1)"
execute if score #slot it_ctx matches 2 run data modify storage ito:form a2 set value "$(a2)"
execute if score #slot it_ctx matches 3 run data modify storage ito:form a3 set value "$(a3)"
