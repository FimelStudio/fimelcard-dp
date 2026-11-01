execute summon minecraft:marker run function ito:deck/card
scoreboard players add #build it_ctx 1
execute if score #build it_ctx matches ..100 run function ito:deck/create
