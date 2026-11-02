scoreboard players operation #dx ca_ctx = #x ca_ctx
scoreboard players operation #dz ca_ctx = #z ca_ctx
$scoreboard players set #coord ca_ctx $(x)
scoreboard players operation #dx ca_ctx -= #coord ca_ctx
$scoreboard players set #coord ca_ctx $(z)
scoreboard players operation #dz ca_ctx -= #coord ca_ctx
execute if score #dx ca_ctx matches ..-1 run scoreboard players operation #dx ca_ctx *= #minus ca_ctx
execute if score #dz ca_ctx matches ..-1 run scoreboard players operation #dz ca_ctx *= #minus ca_ctx
$execute unless score #dx ca_ctx matches 0..$(rx) run return 0
$execute unless score #dz ca_ctx matches 0..$(rz) run return 0
scoreboard players set #k ca_ctx 1000
scoreboard players operation #dx ca_ctx *= #k ca_ctx
scoreboard players set #k ca_ctx 1732
scoreboard players operation #dz ca_ctx *= #k ca_ctx
scoreboard players operation #dx ca_ctx += #dz ca_ctx
$execute if score #dx ca_ctx matches ..$(bound) run scoreboard players set #target ca_ctx $(id)
