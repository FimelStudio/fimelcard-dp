tag @s add it.player
scoreboard players operation @s it_table = @s ct_id
scoreboard players operation @s it_seat = @s ct_seat
scoreboard players operation @s it_order = #join_order it_ctx
scoreboard players add #join_order it_ctx 1
scoreboard players set @s it_action 0
scoreboard players enable @s it_action
scoreboard players set @s it_vote 0
scoreboard players operation #join_seat it_ctx = @s it_seat
scoreboard players operation #order it_ctx = @s it_order
function ito:name/resolve
execute as @e[type=minecraft:marker,tag=ct.controller] if score @s ct_id = #table it_ctx at @s summon minecraft:marker run function ito:player/part
function ito:hud/activate
