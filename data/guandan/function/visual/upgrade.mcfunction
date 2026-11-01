function guandan:visual/context
execute store result storage guandan:visual steps int 1 run scoreboard players get @s gd_steps
execute positioned ~ ~2.13 ~ summon minecraft:text_display run function guandan:visual/upgrade_text with storage guandan:visual
