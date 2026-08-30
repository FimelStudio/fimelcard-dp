scoreboard players operation #ctx bw_ctx = @s bw_id
tellraw @a[tag=bw.player] [{text:'════ 本轮身份公开 ════',color:'yellow',bold:true}]
execute as @a[tag=bw.smart] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.player] [{selector:'@s',color:'gold'},{text:' 是大聪明。',color:'yellow'}]
execute as @a[tag=bw.honest] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.player] [{selector:'@s',color:'green'},{text:' 是老实人。',color:'green'}]
execute as @a[tag=bw.bluffer] if score @s bw_id = #ctx bw_ctx run tellraw @a[tag=bw.player] [{selector:'@s',color:'light_purple'},{text:' 是瞎掰人。',color:'light_purple'}]
execute as @a[tag=bw.guess] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 2 run scoreboard players add @a[tag=bw.smart,limit=1] bw_score 1
execute as @a[tag=bw.guess] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 2 run scoreboard players add @s bw_score 1
execute as @a[tag=bw.guess] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 2 run tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{text:'指认正确：大聪明与老实人各得1分。',color:'green'}]
execute as @a[tag=bw.guess] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 3 run scoreboard players add @s bw_score 1
execute as @a[tag=bw.guess] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 3 run tellraw @a[tag=bw.player] [{text:'[瞎掰王] ',color:'yellow'},{text:'指认错误：被指认的瞎掰人得1分。',color:'red'}]
execute as @a[tag=bw.player,scores={bw_bs=1}] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 3 run scoreboard players add @a[tag=bw.smart,limit=1] bw_score 1
execute as @a[tag=bw.player,scores={bw_bs=1}] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 3 run scoreboard players remove @s bw_score 1
execute as @a[tag=bw.player,scores={bw_bs=1}] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 3 run tellraw @a[tag=bw.player] [{text:'[净他喵扯淡！] ',color:'red'},{text:'打中瞎掰人：大聪明+1，目标-1。',color:'green'}]
execute as @a[tag=bw.player,scores={bw_bs=1}] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 2 run scoreboard players remove @a[tag=bw.smart,limit=1] bw_score 3
execute as @a[tag=bw.player,scores={bw_bs=1}] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 2 run scoreboard players remove @s bw_score 1
execute as @a[tag=bw.player,scores={bw_bs=1}] if score @s bw_id = #ctx bw_ctx if score @s bw_role matches 2 run tellraw @a[tag=bw.player] [{text:'[净他喵扯淡！] ',color:'red'},{text:'误伤老实人：大聪明-3，老实人-1。',color:'red'}]
clear @a[tag=bw.smart] minecraft:paper[minecraft:custom_data~{bullshit:{card:1b}}]
clear @a[tag=bw.smart] minecraft:lime_dye[minecraft:custom_data~{bullshit:{card:1b}}]
tag @a[tag=bw.guess] remove bw.guess
scoreboard players add @s bw_round 1
scoreboard players operation #need bw_ctx = @s ct_joined
execute if score @s bw_round > #need bw_ctx run function bullshit:game/finish
execute if score @s bw_round > #need bw_ctx run return 0
function bullshit:round/begin
