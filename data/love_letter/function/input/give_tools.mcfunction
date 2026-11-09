clear @s *[minecraft:custom_data~{love_letter:{tool:1b,action:0}}]
execute unless entity @e[tag=ll.inventory_me,scores={ll_alive=1},limit=1] run return run clear @s *[minecraft:custom_data~{love_letter:{hand:1b}}]
scoreboard players operation #hand_card ll_ctx = @e[tag=ll.inventory_me,limit=1] ll_hand
data modify storage love_letter:input slot set value 0
function love_letter:direct/hand
scoreboard players operation #hand_card ll_ctx = @e[tag=ll.inventory_me,limit=1] ll_extra
data modify storage love_letter:input slot set value 1
function love_letter:direct/hand
