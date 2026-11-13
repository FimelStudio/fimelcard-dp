# 同步调用专用上下文；不得将 #vis_* 跨刻使用。
scoreboard players operation #vis_table ch_ctx = @s ct_id
scoreboard players operation #vis_cap ch_ctx = @s ct_capacity
scoreboard players operation #vis_orient ch_ctx = @s ch_orient
scoreboard players operation #vis_palette ch_ctx = @s ch_palette
scoreboard players operation #vis_board ch_ctx = @s ch_board
scoreboard players operation #vis_white ch_ctx = @s ch_white
scoreboard players operation #vis_black ch_ctx = @s ch_black
data modify storage chess:visual palette set value "ebony"
data modify storage chess:visual board set value "classic"
execute if score #vis_palette ch_ctx matches 0 run data modify storage chess:visual palette set value "ebony"
execute if score #vis_palette ch_ctx matches 1 run data modify storage chess:visual palette set value "walnut"
execute if score #vis_palette ch_ctx matches 2 run data modify storage chess:visual palette set value "ice"
execute if score #vis_palette ch_ctx matches 3 run data modify storage chess:visual palette set value "jade"
execute if score #vis_board ch_ctx matches 0 run data modify storage chess:visual board set value "classic"
execute if score #vis_board ch_ctx matches 1 run data modify storage chess:visual board set value "green"
execute if score #vis_board ch_ctx matches 2 run data modify storage chess:visual board set value "wood"
execute if score #vis_board ch_ctx matches 3 run data modify storage chess:visual board set value "blue"
execute if score #vis_board ch_ctx matches 4 run data modify storage chess:visual board set value "purple"
scoreboard players operation #vis_wedge ch_ctx = #vis_orient ch_ctx
scoreboard players operation #vis_bedge ch_ctx = #vis_orient ch_ctx
scoreboard players add #vis_bedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 4 if score #vis_white ch_ctx matches 1 run scoreboard players set #vis_wedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 4 if score #vis_black ch_ctx matches 1 run scoreboard players set #vis_bedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 4 if score #vis_white ch_ctx matches 2 run scoreboard players set #vis_wedge ch_ctx 3
execute if score #vis_cap ch_ctx matches 4 if score #vis_black ch_ctx matches 2 run scoreboard players set #vis_bedge ch_ctx 3
execute if score #vis_cap ch_ctx matches 4 if score #vis_white ch_ctx matches 3 run scoreboard players set #vis_wedge ch_ctx 0
execute if score #vis_cap ch_ctx matches 4 if score #vis_black ch_ctx matches 3 run scoreboard players set #vis_bedge ch_ctx 0
execute if score #vis_cap ch_ctx matches 4 if score #vis_white ch_ctx matches 4 run scoreboard players set #vis_wedge ch_ctx 1
execute if score #vis_cap ch_ctx matches 4 if score #vis_black ch_ctx matches 4 run scoreboard players set #vis_bedge ch_ctx 1
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 1 run scoreboard players set #vis_wedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 1 run scoreboard players set #vis_bedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 2 run scoreboard players set #vis_wedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 2 run scoreboard players set #vis_bedge ch_ctx 2
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 3 run scoreboard players set #vis_wedge ch_ctx 3
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 3 run scoreboard players set #vis_bedge ch_ctx 3
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 4 run scoreboard players set #vis_wedge ch_ctx 3
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 4 run scoreboard players set #vis_bedge ch_ctx 3
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 5 run scoreboard players set #vis_wedge ch_ctx 0
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 5 run scoreboard players set #vis_bedge ch_ctx 0
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 6 run scoreboard players set #vis_wedge ch_ctx 0
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 6 run scoreboard players set #vis_bedge ch_ctx 0
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 7 run scoreboard players set #vis_wedge ch_ctx 1
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 7 run scoreboard players set #vis_bedge ch_ctx 1
execute if score #vis_cap ch_ctx matches 8 if score #vis_white ch_ctx matches 8 run scoreboard players set #vis_wedge ch_ctx 1
execute if score #vis_cap ch_ctx matches 8 if score #vis_black ch_ctx matches 8 run scoreboard players set #vis_bedge ch_ctx 1
scoreboard players set #vis_overlap ch_ctx 0
execute if score #vis_wedge ch_ctx = #vis_bedge ch_ctx run scoreboard players set #vis_overlap ch_ctx 1
