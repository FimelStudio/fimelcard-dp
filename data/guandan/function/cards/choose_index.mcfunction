$data modify storage guandan:cards chosen set from entity @s data.guandan.options[$(index)]
execute store result score #kind gd_ctx run data get storage guandan:cards chosen.kind
execute store result score #size gd_ctx run data get storage guandan:cards chosen.size
execute store result score #high gd_ctx run data get storage guandan:cards chosen.high
execute store result score #power gd_ctx run data get storage guandan:cards chosen.power
# 即使候选旧缓存曾能盖，也以当前上一手重新比较，不能信任缓存 beat。
function guandan:cards/compare_candidate
execute unless score #beats gd_ctx matches 1 run return 0
scoreboard players operation @s gd_kind = #kind gd_ctx
scoreboard players operation @s gd_size = #size gd_ctx
scoreboard players operation @s gd_high = #high gd_ctx
scoreboard players operation @s gd_power = #power gd_ctx
data modify entity @s data.guandan.chosen set from storage guandan:cards chosen
scoreboard players set #ok gd_ctx 1
