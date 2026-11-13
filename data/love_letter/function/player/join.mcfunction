tag @s add ll.player
scoreboard players operation @s ll_table = @s ct_id
scoreboard players operation @s ll_seat = @s ct_seat
scoreboard players set @s ll_pick -1
scoreboard players set @s ll_drop 0
scoreboard players operation #join_seat ll_ctx = @s ll_seat
function love_letter:name/resolve
execute as @e[tag=ll.current,limit=1] at @s summon minecraft:marker run function love_letter:game/part
function love_letter:input/give
