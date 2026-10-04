dialog clear @s
clear @s *[minecraft:custom_data~{wenfei:{tool:"score"}}]
clear @s *[minecraft:custom_data~{wenfei:{tool:"menu"}}]
function wenfei:title/release
clear @s minecraft:writable_book[minecraft:custom_data~{wenfei:{}}]
clear @s minecraft:written_book[minecraft:custom_data~{wenfei:{}}]
tag @s remove wq.player
tag @s remove wq.actor
tag @s remove wq.audience
scoreboard players reset @s wq_id
scoreboard players reset @s wq_seat
scoreboard players reset @s wq_score
scoreboard players reset @s wq_guess
scoreboard players reset @s wq_done
scoreboard players reset @s wq_ready
scoreboard players reset @s wq_action
scoreboard players reset @s wq_ui_table
scoreboard players reset @s wq_rank
clear @s minecraft:purple_dye[minecraft:custom_data~{wenfei:{tool:"answer_dialog"}}]
scoreboard players reset @s wq_form
