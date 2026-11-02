scoreboard players operation #dx ca_ctx = #x ca_ctx
scoreboard players operation #dz ca_ctx = #z ca_ctx
$scoreboard players set #coord ca_ctx $(x)
scoreboard players operation #dx ca_ctx -= #coord ca_ctx
$scoreboard players set #coord ca_ctx $(z)
scoreboard players operation #dz ca_ctx -= #coord ca_ctx
$scoreboard players set #ux ca_ctx $(ux)
$scoreboard players set #uz ca_ctx $(uz)
scoreboard players operation #dot ca_ctx = #dx ca_ctx
scoreboard players operation #dot ca_ctx *= #ux ca_ctx
scoreboard players operation #temp ca_ctx = #dz ca_ctx
scoreboard players operation #temp ca_ctx *= #uz ca_ctx
scoreboard players operation #dot ca_ctx += #temp ca_ctx
$execute unless score #dot ca_ctx matches $(dotmin)..$(dotmax) run return 0
scoreboard players operation #cross ca_ctx = #dx ca_ctx
scoreboard players operation #cross ca_ctx *= #uz ca_ctx
scoreboard players operation #temp ca_ctx = #dz ca_ctx
scoreboard players operation #temp ca_ctx *= #ux ca_ctx
scoreboard players operation #cross ca_ctx -= #temp ca_ctx
execute if score #cross ca_ctx matches ..-1 run scoreboard players operation #cross ca_ctx *= #minus ca_ctx
$execute unless score #cross ca_ctx matches ..$(crossmax) run return 0
execute unless score #cross ca_ctx < #best ca_ctx run return 0
scoreboard players operation #best ca_ctx = #cross ca_ctx
$scoreboard players set #target ca_ctx $(id)
