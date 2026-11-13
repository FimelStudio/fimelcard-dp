tag @s add gd.player
scoreboard players operation @s gd_table = @s ct_id
scoreboard players operation @s gd_seat = @s ct_seat
scoreboard players operation @s gd_team = @s gd_order
scoreboard players operation @s gd_team %= #two gd_ctx
scoreboard players set @s gd_drop 0
scoreboard players operation #join_seat gd_ctx = @s gd_seat
scoreboard players operation #join_order gd_ctx = @s gd_order
scoreboard players operation #join_team gd_ctx = @s gd_team
function guandan:name/resolve
execute as @e[tag=gd.current,limit=1] at @s summon minecraft:marker run function guandan:game/part
function guandan:input/give
