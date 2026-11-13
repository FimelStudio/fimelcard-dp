data modify storage love_letter:visual info set value {lines:[],round:0}
execute store result storage love_letter:visual info.round int 1 run scoreboard players get @s ll_round
function love_letter:visual/info_heading with storage love_letter:visual info
execute as @e[tag=ll.board,scores={ll_seat=1}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=2}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=3}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=4}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=5}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=6}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=7}] run function love_letter:visual/info_player
execute as @e[tag=ll.board,scores={ll_seat=8}] run function love_letter:visual/info_player
execute positioned ~ ~1.79 ~ summon minecraft:text_display run function love_letter:visual/info_spawn with storage love_letter:visual info
