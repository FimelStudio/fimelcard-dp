data modify storage love_letter:ui phase set value {text:"选择目标。",color:"green"}
scoreboard players operation #ui_role ll_ctx = @e[tag=ll.current,limit=1] ll_card
execute as @e[tag=ll.board,scores={ll_seat=1,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=2,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=3,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=4,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=5,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=6,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=7,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
execute as @e[tag=ll.board,scores={ll_seat=8,ll_alive=1,ll_protect=0}] run function love_letter:ui/target_button
