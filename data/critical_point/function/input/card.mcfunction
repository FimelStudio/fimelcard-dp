scoreboard players set @s cp_drop 0
scoreboard players operation #ctx cp_ctx = @s cp_id
execute unless entity @e[tag=cp.input_drop,limit=1] run return 0
tag @e[tag=cp.current] remove cp.current
execute as @e[type=minecraft:marker,tag=cp.controller,scores={cp_state=1}] if score @s cp_id = #ctx cp_ctx run tag @s add cp.current
execute if score @s cp_locked matches 1 run function critical_point:input/return_card
execute if score @s cp_locked matches 1 run return 0
execute unless entity @e[tag=cp.current,limit=1] run function critical_point:input/return_card
execute unless entity @e[tag=cp.current,limit=1] run return 0
execute if items entity @e[tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:1b}}] run scoreboard players set @s cp_play 1
execute if items entity @e[tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:2b}}] run scoreboard players set @s cp_play 2
execute if items entity @e[tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:3b}}] run scoreboard players set @s cp_play 3
execute if items entity @e[tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:4b}}] run scoreboard players set @s cp_play 4
execute if items entity @e[tag=cp.input_drop,limit=1] contents minecraft:paper[minecraft:custom_data~{critical_point:{card:5b}}] run scoreboard players set @s cp_play 5
kill @e[tag=cp.input_drop,limit=1]
scoreboard players set @s cp_locked 1
tellraw @s [{text:'[临界点] ',color:'red'},{text:'已秘密锁定 ',color:'gray'},{score:{name:'@s',objective:'cp_play'},color:'gold',bold:true},{text:' 点。',color:'gray'}]
execute as @e[tag=cp.current,limit=1] at @s run function critical_point:round/check_all
tag @e[tag=cp.current] remove cp.current
