execute summon minecraft:item_display run function catan:direct/deck_init
execute summon minecraft:interaction run function catan:direct/deck_hit_init
execute positioned ~ ~0.2 ~ summon minecraft:text_display run function catan:direct/deck_label with storage catan:direct
