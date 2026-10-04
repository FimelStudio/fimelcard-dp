scoreboard players operation #answer_table wq_ctx = @s wq_id
scoreboard players set #answer_mode wq_ctx 0
execute as @e[type=minecraft:marker,tag=wq.controller] if score @s wq_id = #answer_table wq_ctx run scoreboard players operation #answer_mode wq_ctx = @s wq_input
execute if score #answer_mode wq_ctx matches 1 run return run function wenfei:form/give_tool
clear @s minecraft:writable_book[minecraft:custom_data~{wenfei:{tool:"answer"}}]
execute store result storage wenfei:io item.table int 1 run scoreboard players get @s wq_id
function wenfei:input/give_answer_item with storage wenfei:io item
