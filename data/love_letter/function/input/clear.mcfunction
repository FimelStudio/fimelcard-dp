scoreboard players reset @s ll_seen
scoreboard players reset @s ll_pick
scoreboard players reset @s ll_ui_tmp
scoreboard players reset @s ll_ui_load
scoreboard players reset @s ll_action
scoreboard players reset @s ll_drop
# selection: begin
scoreboard players reset @s ll_head_drop
scoreboard players reset @s ll_hint
scoreboard players reset @s ll_hintwait
scoreboard players reset @s ll_hint_target
# selection: end
clear @s *[minecraft:custom_data~{love_letter:{tool:1b}}]
tag @s remove ll.actor
tag @s remove ll.choice_pending
