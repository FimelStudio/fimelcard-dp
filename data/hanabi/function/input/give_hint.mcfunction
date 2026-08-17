# 提示操作物固定放在快捷栏第9格；只有当前回合且仍有提示标记时调用
clear @s minecraft:firework_star[minecraft:custom_data~{hanabi:{action:"hint"}}]
execute store result storage hanabi:input table int 1 run scoreboard players get @s hb_id
function hanabi:input/place_hint with storage hanabi:input
scoreboard players enable @s hb_action
