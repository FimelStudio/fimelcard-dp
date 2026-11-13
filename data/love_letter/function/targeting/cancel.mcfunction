scoreboard players set @e[tag=ll.current,limit=1] ll_select_epoch 0
scoreboard players set @e[tag=ll.current,limit=1] ll_exact 0
clear @s *[minecraft:custom_data~{love_letter:{head:1b}}]
function love_letter:input/give
