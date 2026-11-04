tag @s add sp.visual
tag @s add sp.hit
$scoreboard players set @s sp_table $(table)
$scoreboard players set @s ct_id $(table)
$data merge entity @s {width:0.28f,height:0.18f,response:1b,data:{hit:{table:$(table),epoch:$(epoch),kind:$(kind),id:$(id)}}}
$execute if predicate {condition:"minecraft:value_check",value:$(kind),range:4} positioned ~ ~0.24 ~ summon minecraft:text_display run function splendor:direct/count with storage splendor:direct hit
