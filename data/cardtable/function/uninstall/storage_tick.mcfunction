execute in minecraft:overworld unless entity @e[tag=ct.uninstall_resolver] positioned 0 0 0 run summon minecraft:item_display ~ ~ ~ {Tags:["ct.uninstall_resolver"],view_range:0f}
scoreboard players set #un_budget ct_ctx 128
execute unless data storage cardtable:uninstall scan if data storage cardtable:uninstall queue[0] run function cardtable:uninstall/storage_begin with storage cardtable:uninstall queue[0]
execute if data storage cardtable:uninstall scan unless data storage cardtable:uninstall scan.done run function cardtable:uninstall/storage_scan
execute if data storage cardtable:uninstall scan.done run data remove storage cardtable:uninstall queue[0]
execute if data storage cardtable:uninstall scan.done run data remove storage cardtable:uninstall scan
execute unless data storage cardtable:uninstall queue[0] run return run function cardtable:uninstall/finish
schedule function cardtable:uninstall/storage_tick 1t replace
