data modify storage guandan:visual exchange set from storage guandan:visual exchanges[0]
data modify storage guandan:visual exchange.cap set from storage guandan:visual cap
function guandan:visual/tribute_path with storage guandan:visual exchange
data modify storage guandan:visual type set from storage guandan:visual exchange.type
function guandan:visual/model
data modify storage guandan:visual card.model set from storage guandan:visual model
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function guandan:visual/exchange_face with storage guandan:visual card
data remove storage guandan:visual exchanges[0]
execute if data storage guandan:visual exchanges[0] run function guandan:visual/tribute_loop
