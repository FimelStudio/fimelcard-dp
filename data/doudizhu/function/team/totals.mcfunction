scoreboard players set #orange_total dd_ctx 0
scoreboard players set #aqua_total dd_ctx 0
execute unless score @s dd_scoring matches 1 as @e[tag=dd.actor,scores={dd_team=1}] if score @s dd_id = #ctx dd_ctx run scoreboard players operation #orange_total dd_ctx += @s dd_total
execute unless score @s dd_scoring matches 1 as @e[tag=dd.actor,scores={dd_team=2}] if score @s dd_id = #ctx dd_ctx run scoreboard players operation #aqua_total dd_ctx += @s dd_total
execute if score @s dd_scoring matches 1 run scoreboard players operation #orange_total dd_ctx = @s dd_team_one
execute if score @s dd_scoring matches 1 run scoreboard players operation #aqua_total dd_ctx = @s dd_team_two
tellraw @a[tag=dd.audience] [{text:"橙队 ",color:"gold",bold:true},{score:{name:"#orange_total",objective:"dd_ctx"},color:"gold"},{text:"　青队 ",color:"aqua",bold:true},{score:{name:"#aqua_total",objective:"dd_ctx"},color:"aqua"}]
