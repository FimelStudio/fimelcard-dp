$data modify storage cardtable:uninstall scan set value {id:"$(id)",quote:""}
$execute store result score #un_keys ct_ctx run data get storage $(id) {}
execute if score #un_keys ct_ctx matches 0 run data modify storage cardtable:uninstall scan.done set value 1b
execute if score #un_keys ct_ctx matches 0 run return 0
$data modify storage cardtable:uninstall scan.component set value {nbt:"{}",storage:"$(id)"}
function cardtable:uninstall/storage_stringify
