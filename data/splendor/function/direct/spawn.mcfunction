data modify storage splendor:direct hit set value {table:0,epoch:0,kind:0,id:0}
execute store result storage splendor:direct hit.table int 1 run scoreboard players get @s sp_table
execute store result storage splendor:direct hit.epoch int 1 run scoreboard players get @e[tag=sp.current,limit=1] sp_epoch
execute store result storage splendor:direct hit.kind int 1 run scoreboard players get @s sp_vkind
execute store result storage splendor:direct hit.id int 1 run scoreboard players get @s sp_vid
$execute positioned ~$(x) ~$(y) ~$(z) summon minecraft:interaction run function splendor:direct/hit_init with storage splendor:direct hit
execute if score @s sp_vkind matches 4 run function splendor:direct/gem_model
