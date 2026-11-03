tag @s add sp.visual
$scoreboard players set @s sp_table $(table)
$scoreboard players set @s ct_id $(table)
data merge entity @s {billboard:"center",background:0,shadow:1b,line_width:80,transformation:{scale:[0.28f,0.28f,0.28f]}}
$data modify entity @s text set value {text:"",extra:[{nbt:"data.splendor.bank[$(id)]",entity:"@e[tag=sp.current,limit=1]",color:"white"}]}
