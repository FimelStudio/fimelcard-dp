$data modify storage catan:visual pose set from storage catan:layout $(layout).ports[$(target)].dock
data modify storage catan:visual kind set value 11
data modify storage catan:visual model set value "port/dock"
function catan:visual/spawn
$data modify storage catan:visual pose set from storage catan:layout $(layout).ports[$(target)].token
data modify storage catan:visual kind set value 4
execute if data storage catan:visual {port:-1} run data modify storage catan:visual model set value "port/generic"
execute if data storage catan:visual {port:0} run data modify storage catan:visual model set value "port/wood"
execute if data storage catan:visual {port:1} run data modify storage catan:visual model set value "port/brick"
execute if data storage catan:visual {port:2} run data modify storage catan:visual model set value "port/wool"
execute if data storage catan:visual {port:3} run data modify storage catan:visual model set value "port/grain"
execute if data storage catan:visual {port:4} run data modify storage catan:visual model set value "port/ore"
function catan:visual/spawn
