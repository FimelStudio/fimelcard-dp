function gomoku:visual/context
data modify storage gomoku:visual sq set from entity @s data.gomoku.last.sq
data modify storage gomoku:visual side set from entity @s data.gomoku.last.side
function gomoku:visual/coord with storage gomoku:visual
function gomoku:visual/stone_name
data modify storage gomoku:visual duration set value 0
data modify storage gomoku:visual stone_y set value 0.24
execute positioned ~ ~1.035 ~ summon minecraft:item_display run function gomoku:visual/falling_init with storage gomoku:visual
function gomoku:visual/select
