execute unless entity @e[tag=ma.current,scores={ma_anim=0},limit=1] run return run clear @s minecraft:paper[minecraft:custom_data~{magical_athlete:{choice:1b}}]
execute unless score @s ma_side = @e[tag=ma.current,limit=1] ma_pending run return run clear @s minecraft:paper[minecraft:custom_data~{magical_athlete:{choice:1b}}]
execute unless score @s ma_choiceepoch = @e[tag=ma.current,limit=1] ma_epoch run scoreboard players set @s ma_choicepage 0
execute unless score @s ma_choiceepoch = @e[tag=ma.current,limit=1] ma_epoch run clear @s minecraft:paper[minecraft:custom_data~{magical_athlete:{choice:1b}}]
scoreboard players operation @s ma_choiceepoch = @e[tag=ma.current,limit=1] ma_epoch
data modify storage magical_athlete:ui pending set from entity @e[tag=ma.current,limit=1] data.magical_athlete.pending
execute store result score #choice_count ma_ctx run data get storage magical_athlete:ui pending.options
execute unless score @s ma_choicepage < #choice_count ma_ctx run scoreboard players set @s ma_choicepage 0
execute store result storage magical_athlete:ui table int 1 run scoreboard players get @s ma_table
execute store result storage magical_athlete:ui epoch int 1 run scoreboard players get @s ma_choiceepoch
tag @s add ma.inventory_choices
function magical_athlete:direct/choice_slot {slot:0}
function magical_athlete:direct/choice_slot {slot:1}
function magical_athlete:direct/choice_slot {slot:2}
function magical_athlete:direct/choice_slot {slot:3}
function magical_athlete:direct/choice_slot {slot:4}
function magical_athlete:direct/choice_slot {slot:5}
tag @s remove ma.inventory_choices
execute if score #choice_count ma_ctx matches 7.. run function magical_athlete:direct/choice_page_item with storage magical_athlete:ui

execute if items entity @s hotbar.0 * unless items entity @s hotbar.0 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
execute if items entity @s hotbar.1 * unless items entity @s hotbar.1 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
execute if items entity @s hotbar.2 * unless items entity @s hotbar.2 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
execute if items entity @s hotbar.3 * unless items entity @s hotbar.3 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
execute if items entity @s hotbar.4 * unless items entity @s hotbar.4 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
execute if items entity @s hotbar.5 * unless items entity @s hotbar.5 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
execute if items entity @s hotbar.6 * unless items entity @s hotbar.6 *[minecraft:custom_data~{magical_athlete:{tool:1b}}] run function magical_athlete:direct/space_notice
