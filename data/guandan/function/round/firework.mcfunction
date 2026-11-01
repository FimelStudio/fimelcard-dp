tag @e[type=minecraft:firework_rocket,tag=gd.firework.new] remove gd.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,14442467,16777215],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["gd.firework","gd.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=gd.firework.new] ct_id = #table gd_ctx
tag @e[type=minecraft:firework_rocket,tag=gd.firework.new] remove gd.firework.new
