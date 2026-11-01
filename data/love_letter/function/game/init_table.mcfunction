tag @s add ll.controller
execute unless score @s ll_first_setting matches 0..1 run scoreboard players set @s ll_first_setting 0
execute unless score @s ll_goal_setting matches 0..10 run scoreboard players set @s ll_goal_setting 0
execute unless score @s ll_discards_setting matches 0..1 run scoreboard players set @s ll_discards_setting 1
execute unless score @s ll_time_setting matches 0..120 run scoreboard players set @s ll_time_setting 0
execute if score @s ct_state matches 1 run return 0
scoreboard players set @s ll_state 0
function love_letter:visual/setup
