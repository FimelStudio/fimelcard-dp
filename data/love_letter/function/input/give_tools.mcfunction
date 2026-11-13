clear @s *[minecraft:custom_data~{love_letter:{tool:1b,action:0}}]
# selection: begin
execute if score @e[tag=ll.inventory_controller,limit=1] ll_select_epoch = @e[tag=ll.inventory_controller,limit=1] ll_epoch if score @s ll_seat = @e[tag=ll.inventory_controller,limit=1] ll_select_actor run return run function love_letter:targeting/heads
clear @s *[minecraft:custom_data~{love_letter:{head:1b}}]
# selection: end
execute unless entity @e[tag=ll.inventory_me,scores={ll_alive=1},limit=1] run return run clear @s *[minecraft:custom_data~{love_letter:{hand:1b}}]
scoreboard players operation #hand_card ll_ctx = @e[tag=ll.inventory_me,limit=1] ll_hand
data modify storage love_letter:input slot set value 0
function love_letter:direct/hand
scoreboard players operation #hand_card ll_ctx = @e[tag=ll.inventory_me,limit=1] ll_extra
data modify storage love_letter:input slot set value 1
function love_letter:direct/hand
