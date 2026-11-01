scoreboard players set #winner go_ctx 1
execute if score @s go_result matches 2 run scoreboard players set #winner go_ctx -1
execute as @a[tag=go.audience] if score @s go_side = #winner go_ctx at @s positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16766720,16777215,5636095],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["go.firework","go.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=go.firework.new] ct_id = #table go_ctx
tag @e[type=minecraft:firework_rocket,tag=go.firework.new] remove go.firework.new
