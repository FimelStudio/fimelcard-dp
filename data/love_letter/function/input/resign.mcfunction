# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless entity @e[tag=ll.current,scores={ll_state=2},limit=1] run return run function love_letter:input/invalid
execute unless entity @e[tag=ll.me,scores={ll_alive=1},limit=1] run return run function love_letter:input/invalid
dialog clear @s
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:game/resign
