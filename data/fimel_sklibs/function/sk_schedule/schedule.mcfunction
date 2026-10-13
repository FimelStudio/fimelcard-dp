
$scoreboard players set sk_sche_0 fcs_lib $(time)
scoreboard players operation sk_sche_0 fcs_lib += sk_schedule fcs_lib

execute store result storage fimel_sklibs:runtime sk_sche.args1.target_time int 1 run scoreboard players get sk_sche_0 fcs_lib
$data modify storage fimel_sklibs:runtime sk_sche.args1.cmd set value '$(cmd)'
$data modify storage fimel_sklibs:runtime sk_sche.args1.delay_time set value $(time)

function fimel_sklibs:sk_schedule/_0 with storage fimel_sklibs:runtime sk_sche.args1
