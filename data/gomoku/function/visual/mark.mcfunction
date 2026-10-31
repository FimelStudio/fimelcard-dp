function gomoku:visual/coord with storage gomoku:visual
data modify storage gomoku:visual mark_scale set from storage gomoku:visual step
data modify storage gomoku:visual mark_y set from storage gomoku:visual frame_y
execute if data storage gomoku:visual {mark:"last"} run data modify storage gomoku:visual mark_y set from storage gomoku:visual last_y
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function gomoku:visual/mark_init with storage gomoku:visual
