# table-pause: begin (tools/build_table_pause_guards.py)
execute if score @s ct_paused matches 1 run return 0
execute if entity @s[type=minecraft:item,tag=ct.paused_return] run return 0
execute on origin if score @s ct_paused matches 1 run return 0
# table-pause: end
execute unless score @s ll_pick matches 0..1 run return run function love_letter:input/invalid
scoreboard players operation #slot ll_ctx = @s ll_pick
dialog clear @s
execute as @e[tag=ll.current,limit=1] at @s run function love_letter:engine/play
execute if score #ok ll_ctx matches 1 run return 1
execute if score #error ll_ctx matches 2 run return run title @s actionbar {text:"持有女爵和王子或国王时，必须打出女爵。",color:"yellow"}
execute if score #error ll_ctx matches 3 run return run title @s actionbar {text:"请朝向一名可选玩家，再按 Q 出牌。",color:"yellow"}
execute if score #error ll_ctx matches 4 run return run title @s actionbar {text:"目标已出局或受侍女保护，请重新选择。",color:"yellow"}
title @s actionbar {text:"当前不能出这张牌，请确认轮到你且已选中手牌。",color:"yellow"}
