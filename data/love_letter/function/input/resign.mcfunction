execute unless entity @e[tag=ll.current,scores={ll_state=2},limit=1] run return run function love_letter:input/invalid
execute unless entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run return run function love_letter:input/invalid
dialog clear @s
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:game/resign
