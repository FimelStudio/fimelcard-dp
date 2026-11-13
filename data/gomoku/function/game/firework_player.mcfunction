scoreboard players set #celebrate gm_ctx 1
tag @e[type=minecraft:firework_rocket,tag=gm.firework.new] remove gm.firework.new
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["gm.firework","gm.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=gm.firework.new] ct_id = #table gm_ctx
tag @e[type=minecraft:firework_rocket,tag=gm.firework.new] remove gm.firework.new
