scoreboard players operation #vis_piece xq_ctx = @s xq_piece
scoreboard players operation #vis_sq xq_ctx = @s xq_sq
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function xiangqi:visual/man_init
function xiangqi:visual/spawn_hit with storage xiangqi:visual
