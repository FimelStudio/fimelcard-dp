clear @s minecraft:paper[minecraft:custom_data~{bullshit:{card:1b}}]
clear @s minecraft:lime_dye[minecraft:custom_data~{bullshit:{card:1b}}]
execute store result storage bullshit:input table int 1 run scoreboard players get @s bw_id
function bullshit:input/place_tools with storage bullshit:input
scoreboard players enable @s bw_action
