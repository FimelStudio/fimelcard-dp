function weiqi:visual/coord with storage weiqi:visual
data modify storage weiqi:visual mark_scale set from storage weiqi:visual step
data modify storage weiqi:visual mark_y set from storage weiqi:visual frame_y
execute if data storage weiqi:visual {mark:"last"} run data modify storage weiqi:visual mark_y set from storage weiqi:visual last_y
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function weiqi:visual/mark_init with storage weiqi:visual
