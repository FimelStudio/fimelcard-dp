clear @s *[minecraft:custom_data~{love_letter:{tool:1b}}]
execute store result storage love_letter:input table int 1 run scoreboard players get @s ll_table
function love_letter:input/give_tools with storage love_letter:input
