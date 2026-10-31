scoreboard players operation #vis_piece ch_ctx = @s ch_piece
scoreboard players operation #vis_sq ch_ctx = @s ch_sq
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function chess:visual/man_init
function chess:visual/spawn_hit with storage chess:visual
