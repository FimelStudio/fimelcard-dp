# 在玩家标签/分数清除前，把最终生命面板固化为静态名字与数值。
scoreboard players operation #ctx ab_ctx = @s ab_id
data modify storage abraca:hud line1 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud line2 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud line3 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud line4 set value {text:'空座位',color:'dark_gray'}
data modify storage abraca:hud hp1 set value 0
data modify storage abraca:hud hp2 set value 0
data modify storage abraca:hud hp3 set value 0
data modify storage abraca:hud hp4 set value 0
function abraca:hud/final_line_1
function abraca:hud/final_line_2
function abraca:hud/final_line_3
function abraca:hud/final_line_4
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run function abraca:hud/render with storage abraca:hud
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.game_entity
execute as @e[type=minecraft:text_display,tag=ab.info] if score @s ab_id = #ctx ab_ctx run tag @s add ab.final_info
