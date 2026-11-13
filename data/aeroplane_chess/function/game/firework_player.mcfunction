tag @e[type=minecraft:firework_rocket,tag=ac.firework.new] remove ac.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16733525,16777045,5635925,5592575],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ac.firework","ac.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ac.firework.new] ct_id = #table ac_ctx
tag @e[type=minecraft:firework_rocket,tag=ac.firework.new] remove ac.firework.new
