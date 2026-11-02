# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute as @e[tag=ll.board,scores={ll_seat=1}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=2}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=3}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=4}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=5}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=6}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=7}] run function love_letter:ui/player_line
execute as @e[tag=ll.board,scores={ll_seat=8}] run function love_letter:ui/player_line
