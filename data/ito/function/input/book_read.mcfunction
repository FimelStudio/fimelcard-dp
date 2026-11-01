execute if score @e[tag=it.current,limit=1] it_input matches 1 run return 0
data modify storage ito:input pages set value []
data modify storage ito:input pages set from entity @e[tag=it.drop,limit=1] Item.components."minecraft:writable_book_content".pages
execute store result score #pages it_ctx run data get storage ito:input pages
execute unless score #pages it_ctx matches 1 run return run function ito:input/reject
data modify storage ito:input incoming set from storage ito:input pages[0]
execute if data storage ito:input pages[0].raw run data modify storage ito:input incoming set from storage ito:input pages[0].raw
function ito:input/save
