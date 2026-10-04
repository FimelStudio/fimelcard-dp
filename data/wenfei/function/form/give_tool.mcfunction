clear @s minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}]
execute store result storage wenfei:io item.table int 1 run scoreboard players get @s wq_id
function wenfei:form/give_item with storage wenfei:io item
