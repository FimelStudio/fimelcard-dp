clear @s minecraft:writable_book[minecraft:custom_data~{wenfei:{tool:"answer"}}]
execute store result storage wenfei:io item.table int 1 run scoreboard players get @s wq_id
function wenfei:input/give_answer_item with storage wenfei:io item
