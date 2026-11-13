execute unless entity @s[tag=ll.player,tag=ct.player] run return 0
execute unless score @s ll_table = @s ct_id run return 0
scoreboard players operation #give_table ll_ctx = @s ll_table
scoreboard players operation #give_seat ll_ctx = @s ll_seat
tag @e[tag=ll.inventory_me] remove ll.inventory_me
tag @e[tag=ll.inventory_controller] remove ll.inventory_controller
execute as @e[tag=ll.part] if score @s ct_id = #give_table ll_ctx if score @s ll_seat = #give_seat ll_ctx run tag @s add ll.inventory_me
execute as @e[tag=ll.controller,scores={ct_state=1}] if score @s ct_id = #give_table ll_ctx run tag @s add ll.inventory_controller
execute unless entity @e[tag=ll.inventory_me,limit=1] run return 0
execute unless entity @e[tag=ll.inventory_controller,limit=1] run return 0
execute store result storage love_letter:input table int 1 run scoreboard players get @s ll_table
execute store result storage love_letter:input epoch int 1 run scoreboard players get @e[tag=ll.inventory_controller,limit=1] ll_epoch
execute store result storage love_letter:input owner int 1 run scoreboard players get @s ll_seat
function love_letter:input/give_tools with storage love_letter:input
