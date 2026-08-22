scoreboard players operation #ctx ab_ctx = @s ab_id
execute store result storage abraca:hud id int 1 run scoreboard players get @s ab_id
scoreboard players set #hp1 ab_ctx 0
scoreboard players set #hp2 ab_ctx 0
scoreboard players set #hp3 ab_ctx 0
scoreboard players set #hp4 ab_ctx 0
data modify storage abraca:hud hp1 set value 0
data modify storage abraca:hud hp2 set value 0
data modify storage abraca:hud hp3 set value 0
data modify storage abraca:hud hp4 set value 0
data modify storage abraca:hud line1 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud line2 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud line3 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud line4 set value {text:'空座位',color:'dark_gray'}
execute as @a[tag=ab.player,scores={ab_seat=1}] if score @s ab_id = #ctx ab_ctx run execute store result storage abraca:hud hp1 int 1 run scoreboard players get @s ab_hp
execute as @a[tag=ab.player,scores={ab_seat=2}] if score @s ab_id = #ctx ab_ctx run execute store result storage abraca:hud hp2 int 1 run scoreboard players get @s ab_hp
execute as @a[tag=ab.player,scores={ab_seat=3}] if score @s ab_id = #ctx ab_ctx run execute store result storage abraca:hud hp3 int 1 run scoreboard players get @s ab_hp
execute as @a[tag=ab.player,scores={ab_seat=4}] if score @s ab_id = #ctx ab_ctx run execute store result storage abraca:hud hp4 int 1 run scoreboard players get @s ab_hp
execute as @a[tag=ab.player,scores={ab_seat=1}] if score @s ab_id = #ctx ab_ctx run function abraca:hud/name_line_1 with storage abraca:hud
execute as @a[tag=ab.player,scores={ab_seat=2}] if score @s ab_id = #ctx ab_ctx run function abraca:hud/name_line_2 with storage abraca:hud
execute as @a[tag=ab.player,scores={ab_seat=3}] if score @s ab_id = #ctx ab_ctx run function abraca:hud/name_line_3 with storage abraca:hud
execute as @a[tag=ab.player,scores={ab_seat=4}] if score @s ab_id = #ctx ab_ctx run function abraca:hud/name_line_4 with storage abraca:hud
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run function abraca:hud/render with storage abraca:hud
