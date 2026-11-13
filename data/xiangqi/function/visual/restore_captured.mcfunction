execute store result score #vis_piece xq_ctx run data get storage xiangqi:visual restore[0].piece
scoreboard players set #vis_covered xq_ctx 0
execute store result score #vis_covered xq_ctx run data get storage xiangqi:visual restore[0].covered
execute store result score #vis_owner xq_ctx run data get storage xiangqi:visual restore[0].owner
execute store result score #vis_slot xq_ctx run data get storage xiangqi:visual restore[0].slot
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function xiangqi:visual/restore_man
data remove storage xiangqi:visual restore[0]
execute if data storage xiangqi:visual restore[0] run function xiangqi:visual/restore_captured
