execute store result score #vis_piece ch_ctx run data get storage chess:visual restore[0].piece
execute store result score #vis_owner ch_ctx run data get storage chess:visual restore[0].owner
execute store result score #vis_slot ch_ctx run data get storage chess:visual restore[0].slot
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function chess:visual/restore_man
data remove storage chess:visual restore[0]
execute if data storage chess:visual restore[0] run function chess:visual/restore_captured
