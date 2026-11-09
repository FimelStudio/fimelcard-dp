tag @s add ma.direct
tag @s add ma.hit
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s ma_dtype $(type)
$scoreboard players set @s ma_did $(id)
$data merge entity @s {width:$(width)f,height:0.18f,response:1b,data:{hit:{table:$(table),epoch:$(epoch),type:$(type),id:$(id)}}}
