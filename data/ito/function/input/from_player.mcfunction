function ito:input/context
execute unless score #valid it_ctx matches 1 run return 0
execute store result score #item_table it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.table
execute unless score #item_table it_ctx = @s it_table run return 0
execute if data entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito{kind:0} run return run function ito:input/dye
execute store result score #book_round it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.round
execute unless score #book_round it_ctx = @e[tag=it.current,limit=1] it_round run return 0
execute store result score #slot it_ctx run data get entity @e[tag=it.drop,limit=1] Item.components."minecraft:custom_data".ito.slot
execute unless score #slot it_ctx matches 1..3 run return 0
execute if score @e[tag=it.current,limit=1] it_state matches 2 run function ito:input/book_read
function ito:input/book_return
