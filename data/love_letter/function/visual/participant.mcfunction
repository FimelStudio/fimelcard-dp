scoreboard players add @s ll_v_point 0
execute store result storage love_letter:visual seat int 1 run scoreboard players get @s ll_seat
scoreboard players operation #vis_seat ll_ctx = @s ll_seat
scoreboard players remove #vis_seat ll_ctx 1
execute store result storage love_letter:visual seat_index int 1 run scoreboard players get #vis_seat ll_ctx
function love_letter:visual/seat with storage love_letter:visual
execute store result storage love_letter:visual seat_data.points int 1 run scoreboard players get @s ll_points
execute store result storage love_letter:visual seat_data.count int 1 run data get entity @s data.discards
data modify storage love_letter:visual seat_data.model set value "back"
execute store result storage love_letter:visual card int 1 run data get entity @s data.discards[-1]
execute if data entity @s data.discards[-1] run function love_letter:visual/resolve_model with storage love_letter:visual
data modify storage love_letter:visual seat_data.model set from storage love_letter:visual model
execute if data entity @s data.discards[-1] run function love_letter:visual/face_at with storage love_letter:visual seat_data
function love_letter:visual/label_at with storage love_letter:visual seat_data
execute if score @s ll_protect matches 1 run function love_letter:visual/protect_at with storage love_letter:visual seat_data
execute if score @s ll_points matches 1.. run function love_letter:visual/favor_at with storage love_letter:visual seat_data
execute if score @s ll_points > @s ll_v_point run function love_letter:visual/token
scoreboard players operation @s ll_v_point = @s ll_points
