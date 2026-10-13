scoreboard players set @s wq_prev_panel 0
execute if score @s fbt_panel matches 1.. run scoreboard players operation @s wq_prev_panel = @s fbt_panel
