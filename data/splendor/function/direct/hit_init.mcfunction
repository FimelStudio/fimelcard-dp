tag @s add sp.visual
tag @s add sp.hit
$scoreboard players set @s sp_table $(table)
$scoreboard players set @s ct_id $(table)
$scoreboard players set @s sp_vkind $(kind)
$scoreboard players set @s sp_vid $(id)
$data merge entity @s {width:$(width)f,height:0.14f,response:1b,data:{hit:{table:$(table),epoch:$(epoch),kind:$(kind),id:$(id)}}}
