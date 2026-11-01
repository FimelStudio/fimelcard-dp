$execute store result score #half go_ctx run data get storage weiqi:ui $(key)
data modify storage weiqi:ui half_sign set value ""
execute if score #half go_ctx matches ..-1 run data modify storage weiqi:ui half_sign set value "-"
scoreboard players set #half_minus go_ctx -1
execute if score #half go_ctx matches ..-1 run scoreboard players operation #half go_ctx *= #half_minus go_ctx
scoreboard players set #two go_ctx 2
scoreboard players operation #whole go_ctx = #half go_ctx
scoreboard players operation #whole go_ctx /= #two go_ctx
scoreboard players operation #half go_ctx %= #two go_ctx
execute store result storage weiqi:ui half_whole int 1 run scoreboard players get #whole go_ctx
$data modify storage weiqi:ui half_key set value "$(key)_label"
execute if score #half go_ctx matches 0 run function weiqi:ui/half_integer with storage weiqi:ui
execute unless score #half go_ctx matches 0 if score #whole go_ctx matches 0 run function weiqi:ui/half_fraction_zero with storage weiqi:ui
execute unless score #half go_ctx matches 0 unless score #whole go_ctx matches 0 run function weiqi:ui/half_fraction with storage weiqi:ui
