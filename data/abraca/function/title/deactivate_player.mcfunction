scoreboard players set @s fbt_panel 0
execute if score @s ab_prev_panel matches 1.. run scoreboard players operation @s fbt_panel = @s ab_prev_panel
scoreboard players reset @s ab_prev_panel
