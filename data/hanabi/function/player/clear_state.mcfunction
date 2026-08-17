dialog clear @s
function hanabi:title/deactivate_player
clear @s minecraft:paper[minecraft:custom_data~{hanabi:{card:1b}}]
clear @s minecraft:firework_star[minecraft:custom_data~{hanabi:{action:"hint"}}]
tag @s remove hb.player
tag @s remove hb.turn
tag @s remove hb.dialog_actor
tag @s remove hb.dialog_target
tag @s remove hb.audience
tag @s remove hb.restore_pending
tag @s remove hb.reward_pending
scoreboard players reset @s hb_id
scoreboard players reset @s hb_seat
scoreboard players reset @s hb_hand_count
scoreboard players reset @s hb_action
scoreboard players reset @s hb_target
scoreboard players reset @s hb_self
scoreboard players reset @s hb_drop_card
scoreboard players reset @s hb_drop_hint
