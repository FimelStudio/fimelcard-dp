execute if data storage cardtable:uninstall scan{"quote": "'"} run function cardtable:uninstall/storage_remove_single with storage cardtable:uninstall scan
execute unless data storage cardtable:uninstall scan{"quote": "'"} run function cardtable:uninstall/storage_remove_double with storage cardtable:uninstall scan
function cardtable:uninstall/storage_begin with storage cardtable:uninstall scan
execute unless data storage cardtable:uninstall scan.done run function cardtable:uninstall/storage_scan
