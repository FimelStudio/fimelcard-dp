tag @s add ma.direct
tag @s add ma.hit
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ma_dtype $(type)
$scoreboard players set @s ma_did $(id)
$data merge entity @s {width:$(width)f,height:0.18f,response:1b,data:{hit:{table:$(table),epoch:$(epoch),type:$(type),id:$(id)}}}
execute if score @s ma_dtype matches 1 run data modify entity @s height set value 0.36f
execute if score @s ma_dtype matches 2 run data modify entity @s height set value 0.30f
