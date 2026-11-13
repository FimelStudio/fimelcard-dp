tag @e[type=minecraft:firework_rocket,tag=ll.firework.new] remove ll.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;14442467,16766720,16777215],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ll.firework","ll.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ll.firework.new] ct_id = #table ll_ctx
tag @e[type=minecraft:firework_rocket,tag=ll.firework.new] remove ll.firework.new
