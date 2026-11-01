execute unless data storage guandan:visual public[0] run return 0
data modify storage guandan:visual type set from storage guandan:visual public[0]
data modify storage guandan:visual card set from storage guandan:visual positions[0]
function guandan:visual/model with storage guandan:visual
data modify storage guandan:visual card.model set from storage guandan:visual model
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function guandan:visual/face with storage guandan:visual card
data remove storage guandan:visual public[0]
data remove storage guandan:visual positions[0]
scoreboard players add #index gd_ctx 1
execute if score #index gd_ctx matches ..9 if data storage guandan:visual public[0] run function guandan:visual/group_loop
