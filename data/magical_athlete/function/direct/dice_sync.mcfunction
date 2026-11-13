function magical_athlete:direct/dice_eligible
scoreboard players operation @s ma_expected -= @s ma_dice_expected
scoreboard players operation @s ma_expected += #can_roll ma_ctx
scoreboard players operation @s ma_dice_expected = #can_roll ma_ctx
execute if score #can_roll ma_ctx matches 0 run return run clear @s *[minecraft:custom_data~{magical_athlete:{tool:1b,dice:1b}}]
execute store result storage magical_athlete:direct table int 1 run scoreboard players get @s ma_table
execute unless items entity @s hotbar.7 *[minecraft:custom_data~{magical_athlete:{dice:1b}}] run function magical_athlete:input/menu_tool with storage magical_athlete:direct
