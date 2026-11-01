$scoreboard players set #join_order gd_ctx $(order)
scoreboard players operation #join_seat gd_ctx = #join_order gd_ctx
execute if score @s ct_capacity matches 8 run scoreboard players operation #join_seat gd_ctx *= #two gd_ctx
scoreboard players add #join_seat gd_ctx 1
scoreboard players operation #join_team gd_ctx = #join_order gd_ctx
scoreboard players operation #join_team gd_ctx %= #two gd_ctx
$data modify storage guandan:name resolved set value {text:"测试人机$(number)"}
execute at @s summon minecraft:marker run function guandan:bot/part
