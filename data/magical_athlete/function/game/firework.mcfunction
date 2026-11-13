execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["ma.firework","ma.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=ma.firework.new] ct_id = #table ma_ctx
tag @e[type=minecraft:firework_rocket,tag=ma.firework.new] remove ma.firework.new
