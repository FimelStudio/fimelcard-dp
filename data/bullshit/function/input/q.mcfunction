scoreboard players set @s bw_drop 0
execute unless entity @s[tag=bw.smart] run return 0
execute store result storage bullshit:input table int 1 run scoreboard players get @s bw_id
function bullshit:input/find_drop with storage bullshit:input
execute unless entity @e[type=minecraft:item,tag=bw.drop,limit=1] run return 0
execute if items entity @e[type=minecraft:item,tag=bw.drop,limit=1] contents minecraft:paper[minecraft:custom_data~{bullshit:{kind:'call'}}] run function bullshit:dialog/call
execute if items entity @e[type=minecraft:item,tag=bw.drop,limit=1] contents minecraft:paper[minecraft:custom_data~{bullshit:{kind:'call'}}] unless score @s bw_used matches 1 run function bullshit:input/place_call with storage bullshit:input
execute if items entity @e[type=minecraft:item,tag=bw.drop,limit=1] contents minecraft:paper[minecraft:custom_data~{bullshit:{kind:'guess'}}] run function bullshit:dialog/guess
kill @e[type=minecraft:item,tag=bw.drop,limit=1]
tag @e[tag=bw.drop] remove bw.drop
