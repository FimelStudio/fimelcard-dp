scoreboard players set @s dc_drop 0
scoreboard players set @s dc_drop_guess 0
scoreboard players operation #ctx dc_ctx = @s dc_id
tag @e[tag=dc.guess_drop] remove dc.guess_drop
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:purple_dye[minecraft:custom_data~{decrypto:{tool:'guess'}}] run tag @s add dc.guess_drop
execute if entity @e[tag=dc.guess_drop,limit=1] run function decrypto:input/use_guess
tag @e[tag=dc.guess_drop] remove dc.guess_drop
tag @e[tag=dc.submitted_paper] remove dc.submitted_paper
execute at @s as @e[type=minecraft:item,distance=..3,sort=nearest] if items entity @s contents minecraft:paper[minecraft:custom_data~{decrypto:{clue:1b}}] run tag @s add dc.submitted_paper
execute unless entity @e[tag=dc.submitted_paper,limit=1] run return 0
tag @s add dc.submitter
execute as @e[type=minecraft:marker,tag=dc.controller] at @s if score @s dc_id = #ctx dc_ctx if score @s dc_state matches 2..4 run function decrypto:input/accept_paper
tag @s remove dc.submitter
tag @e[tag=dc.submitted_paper] remove dc.submitted_paper
