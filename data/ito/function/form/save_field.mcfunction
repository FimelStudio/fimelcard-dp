function ito:input/focus
execute unless entity @e[tag=it.focus,limit=1] run return 0
$data modify entity @e[tag=it.focus,limit=1] data.description set from storage ito:form incoming.a$(slot)
