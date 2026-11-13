execute summon minecraft:marker run function guandan:deck/card
scoreboard players add #build gd_ctx 1
execute if score #build gd_ctx matches ..107 run function guandan:deck/next
