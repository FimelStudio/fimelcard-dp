scoreboard players set @s bw_drop_dye 0
execute unless entity @s[tag=bw.smart] run return 0
execute store result storage bullshit:input table int 1 run scoreboard players get @s bw_id
function bullshit:input/find_dye_drop with storage bullshit:input
execute unless entity @e[type=minecraft:item,tag=bw.drop,limit=1] run return 0
execute if items entity @e[type=minecraft:item,tag=bw.drop,limit=1] contents minecraft:lime_dye[minecraft:custom_data~{bullshit:{kind:'guess'}}] run function bullshit:dialog/guess
execute if items entity @e[type=minecraft:item,tag=bw.drop,limit=1] contents minecraft:lime_dye[minecraft:custom_data~{bullshit:{kind:'guess'}}] run function bullshit:input/place_guess with storage bullshit:input
kill @e[type=minecraft:item,tag=bw.drop,limit=1]
tag @e[tag=bw.drop] remove bw.drop
