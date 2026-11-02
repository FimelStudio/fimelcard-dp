$data modify entity @e[tag=ca.current,limit=1] data.catan.p$(side).name set from storage catan:runtime name.value
$data modify entity @e[tag=ca.current,limit=1] data.catan.p$(side).seat set value $(seat)
$data modify entity @e[tag=ca.current,limit=1] data.catan.p$(side).color set value $(side)
