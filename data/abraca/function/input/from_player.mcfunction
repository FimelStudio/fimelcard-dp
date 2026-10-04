execute unless entity @s[tag=ab.turn] run return 0
execute unless score @s ab_id = #drop_table ab_ctx run return 0
execute unless score @s ab_input = #drop_epoch ab_ctx run return 0
execute unless score #drop_spell ab_ctx matches 1..9 run return 0
scoreboard players set #input_live ab_ctx 0
execute as @e[type=minecraft:marker,tag=ab.controller,scores={ab_state=2}] if score @s ab_id = #drop_table ab_ctx run scoreboard players set #input_live ab_ctx 1
execute unless score #input_live ab_ctx matches 1 run return 0
scoreboard players operation @s ab_action = #drop_spell ab_ctx
# 施法先返还并换序号；结束回合直接回收整套工具，使同批旧掉落物失效。
execute if score @s ab_action matches 1..8 run function abraca:input/give_tools
execute if score @s ab_action matches 9 run function abraca:input/clear_tools
tag @s add ab.q_input
function abraca:action/handle
tag @s remove ab.q_input
