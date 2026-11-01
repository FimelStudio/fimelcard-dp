execute unless entity @s[type=minecraft:player] run return fail
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1},distance=..8,sort=nearest,limit=1] run tellraw @s {text:"[情书] 同维度8格内没有进行中的情书。",color:"red"}
execute unless entity @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1},distance=..8,sort=nearest,limit=1] run return fail
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ll.controller,scores={ct_game=17,ct_state=1},distance=..8,sort=nearest,limit=1] at @s run function love_letter:game/abort
