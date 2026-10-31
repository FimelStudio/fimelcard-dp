dialog clear @s
clear @s *[minecraft:custom_data~{avalon:{}}]
title @s actionbar {text:""}
tag @s remove av.player
tag @s remove av.audience
scoreboard players reset @s av_id
scoreboard players reset @s av_seat
scoreboard players reset @s av_role
scoreboard players reset @s av_selected
scoreboard players reset @s av_vote
scoreboard players reset @s av_mission
scoreboard players reset @s av_ui_epoch
scoreboard players reset @s av_ui_base
scoreboard players reset @s av_action
scoreboard players reset @s av_target
tag @s remove av.actor
tag @s remove av.target
