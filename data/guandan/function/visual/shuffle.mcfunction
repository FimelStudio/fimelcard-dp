function guandan:visual/context
data modify storage guandan:visual card set from storage guandan:layout c4.seats[0]
data modify storage guandan:visual card.model set value "back"
data modify storage guandan:visual card.path set value [[-0.22,0.18,0.0],[-0.17,0.22,-0.06],[-0.09,0.25,-0.10],[0.0,0.26,-0.12],[0.09,0.25,-0.10],[0.17,0.22,-0.06],[0.22,0.18,0.0],[0.17,0.15,0.06],[0.09,0.12,0.1],[0.0,0.1,0.12],[-0.09,0.08,0.10],[-0.17,0.08,0.06],[-0.22,0.08,0.0]]
execute positioned ~ ~1.04 ~ summon minecraft:item_display run function guandan:visual/exchange_face with storage guandan:visual card
