execute store result score #strip_x go_ctx run data get storage weiqi:visual x 1000000
execute store result score #strip_z go_ctx run data get storage weiqi:visual z 1000000
execute store result score #strip_step go_ctx run data get storage weiqi:visual step 1000000
$scoreboard players set #strip_n go_ctx $(length)
scoreboard players remove #strip_n go_ctx 1
scoreboard players operation #strip_n go_ctx *= #strip_step go_ctx
scoreboard players set #strip_two go_ctx 2
scoreboard players operation #strip_n go_ctx /= #strip_two go_ctx
execute if data storage weiqi:visual {orient:0} run scoreboard players operation #strip_x go_ctx += #strip_n go_ctx
execute if data storage weiqi:visual {orient:1} run scoreboard players operation #strip_z go_ctx += #strip_n go_ctx
execute store result storage weiqi:visual strip_x double 0.000001 run scoreboard players get #strip_x go_ctx
execute store result storage weiqi:visual strip_z double 0.000001 run scoreboard players get #strip_z go_ctx
$scoreboard players set #strip_width go_ctx $(length)
scoreboard players operation #strip_width go_ctx *= #strip_step go_ctx
scoreboard players set #strip_half go_ctx 2
scoreboard players operation #strip_step go_ctx /= #strip_half go_ctx
scoreboard players operation #strip_width go_ctx -= #strip_step go_ctx
execute store result storage weiqi:visual strip_width double 0.000001 run scoreboard players get #strip_width go_ctx
execute store result storage weiqi:visual strip_thin double 0.000001 run scoreboard players get #strip_step go_ctx
execute positioned ~ ~1.032 ~ summon minecraft:item_display run function weiqi:visual/strip with storage weiqi:visual
