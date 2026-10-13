# Called after hand/build, with dd.current intact. Do not change gameplay context.
execute unless score @s dd_panel matches 1.. run function doudizhu:hud/activate
scoreboard players operation #hud_table dd_ctx = @s dd_id
scoreboard players operation #hud_viewer dd_ctx = @s dd_seat
scoreboard players set #hud_up dd_ctx 0
scoreboard players set #hud_down dd_ctx 9
execute as @e[tag=dd.actor] if score @s dd_id = #hud_table dd_ctx if score @s dd_seat < #hud_viewer dd_ctx run scoreboard players operation #hud_up dd_ctx > @s dd_seat
execute as @e[tag=dd.actor] if score @s dd_id = #hud_table dd_ctx if score @s dd_seat > #hud_viewer dd_ctx run scoreboard players operation #hud_down dd_ctx < @s dd_seat
execute if score #hud_up dd_ctx matches 0 run function doudizhu:hud/wrap_up
execute if score #hud_down dd_ctx matches 9 run function doudizhu:hud/wrap_down
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
function doudizhu:hud/bottom
data modify storage doudizhu:hud label set value "上家 "
data modify storage fimel_title:io y set value -48.0d
execute as @e[tag=dd.actor] if score @s dd_id = #hud_table dd_ctx if score @s dd_seat = #hud_up dd_ctx at @s run function doudizhu:hud/row
data modify storage doudizhu:hud label set value "下家 "
data modify storage fimel_title:io y set value -126.0d
execute as @e[tag=dd.actor] if score @s dd_id = #hud_table dd_ctx if score @s dd_seat = #hud_down dd_ctx at @s run function doudizhu:hud/row
# Hand contains per-card fonts; explicitly replace them only in the invisible half-width rewind.
data modify storage fimel_title:io text set from storage doudizhu:ui hand
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "card:doudizhu/hand_neg"
function fimel_title:new_part
data modify storage fimel_title:io neg_text_buffer[-1].extra[0].extra[].font set value "card:doudizhu/hand_neg"
data modify storage fimel_title:io tempx set value 4000
data modify storage fimel_title:io tempy set value 2500
data modify storage fimel_title:io origin set value "default"
data modify storage fimel_title:io align set value "middle"
function fimel_title:code/new_text_macro with storage fimel_title:io
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
scoreboard players operation panel_id fbt_io = @s dd_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s dd_panel
