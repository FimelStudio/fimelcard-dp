execute if entity @e[tag=ll.current,scores={ll_phase=1},limit=1] run function love_letter:ui/play_choices
execute if entity @e[tag=ll.current,scores={ll_phase=2},limit=1] run function love_letter:ui/targets
execute if entity @e[tag=ll.current,scores={ll_phase=3},limit=1] run function love_letter:ui/guesses
execute if entity @e[tag=ll.current,scores={ll_phase=4..5},limit=1] run function love_letter:ui/chancellor
