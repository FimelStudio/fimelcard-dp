# 同步调用专用上下文；不得将 #vis_* 跨刻使用。
scoreboard players operation #vis_table xq_ctx = @s ct_id
scoreboard players operation #vis_cap xq_ctx = @s ct_capacity
scoreboard players operation #vis_orient xq_ctx = @s xq_orient
scoreboard players operation #vis_palette xq_ctx = @s xq_palette
scoreboard players operation #vis_board xq_ctx = @s xq_board
scoreboard players operation #vis_red xq_ctx = @s xq_red
scoreboard players operation #vis_black xq_ctx = @s xq_black
data modify storage xiangqi:visual palette set value "ebony"
data modify storage xiangqi:visual board set value "classic"
execute if score #vis_palette xq_ctx matches 0 run data modify storage xiangqi:visual palette set value "ebony"
execute if score #vis_palette xq_ctx matches 1 run data modify storage xiangqi:visual palette set value "walnut"
execute if score #vis_board xq_ctx matches 0 run data modify storage xiangqi:visual board set value "classic"
execute if score #vis_board xq_ctx matches 1 run data modify storage xiangqi:visual board set value "wood"
scoreboard players operation #vis_redge xq_ctx = #vis_orient xq_ctx
scoreboard players operation #vis_bedge xq_ctx = #vis_orient xq_ctx
scoreboard players add #vis_bedge xq_ctx 2
execute if score #vis_cap xq_ctx matches 4 if score #vis_red xq_ctx matches 1 run scoreboard players set #vis_redge xq_ctx 2
execute if score #vis_cap xq_ctx matches 4 if score #vis_black xq_ctx matches 1 run scoreboard players set #vis_bedge xq_ctx 2
execute if score #vis_cap xq_ctx matches 4 if score #vis_red xq_ctx matches 2 run scoreboard players set #vis_redge xq_ctx 3
execute if score #vis_cap xq_ctx matches 4 if score #vis_black xq_ctx matches 2 run scoreboard players set #vis_bedge xq_ctx 3
execute if score #vis_cap xq_ctx matches 4 if score #vis_red xq_ctx matches 3 run scoreboard players set #vis_redge xq_ctx 0
execute if score #vis_cap xq_ctx matches 4 if score #vis_black xq_ctx matches 3 run scoreboard players set #vis_bedge xq_ctx 0
execute if score #vis_cap xq_ctx matches 4 if score #vis_red xq_ctx matches 4 run scoreboard players set #vis_redge xq_ctx 1
execute if score #vis_cap xq_ctx matches 4 if score #vis_black xq_ctx matches 4 run scoreboard players set #vis_bedge xq_ctx 1
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 1 run scoreboard players set #vis_redge xq_ctx 2
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 1 run scoreboard players set #vis_bedge xq_ctx 2
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 2 run scoreboard players set #vis_redge xq_ctx 2
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 2 run scoreboard players set #vis_bedge xq_ctx 2
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 3 run scoreboard players set #vis_redge xq_ctx 3
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 3 run scoreboard players set #vis_bedge xq_ctx 3
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 4 run scoreboard players set #vis_redge xq_ctx 3
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 4 run scoreboard players set #vis_bedge xq_ctx 3
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 5 run scoreboard players set #vis_redge xq_ctx 0
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 5 run scoreboard players set #vis_bedge xq_ctx 0
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 6 run scoreboard players set #vis_redge xq_ctx 0
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 6 run scoreboard players set #vis_bedge xq_ctx 0
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 7 run scoreboard players set #vis_redge xq_ctx 1
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 7 run scoreboard players set #vis_bedge xq_ctx 1
execute if score #vis_cap xq_ctx matches 8 if score #vis_red xq_ctx matches 8 run scoreboard players set #vis_redge xq_ctx 1
execute if score #vis_cap xq_ctx matches 8 if score #vis_black xq_ctx matches 8 run scoreboard players set #vis_bedge xq_ctx 1
scoreboard players set #vis_overlap xq_ctx 0
execute if score #vis_redge xq_ctx = #vis_bedge xq_ctx run scoreboard players set #vis_overlap xq_ctx 1
