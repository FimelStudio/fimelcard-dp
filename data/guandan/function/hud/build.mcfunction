execute unless entity @s[tag=gd.hud_active] run function guandan:hud/activate
scoreboard players operation #hud_table gd_ctx = @s gd_table
scoreboard players operation #hud_seat gd_ctx = @s gd_seat
tag @e[tag=gd.hudhand] remove gd.hudhand
execute as @e[type=minecraft:marker,tag=gd.card] if score @s ct_id = #hud_table gd_ctx if score @s gd_owner = #hud_seat gd_ctx run tag @s add gd.hudhand
execute as @e[tag=gd.hudhand] run function guandan:hud/card_key
data modify storage guandan:hud hand set value {text:"",color:"white",shadow_color:0,extra:[]}
scoreboard players set #hud_previous gd_ctx -1
scoreboard players set #hud_depth gd_ctx 0
scoreboard players set #hud_maxdepth gd_ctx 0
scoreboard players set #hud_groups gd_ctx 0
scoreboard players set #hud_count gd_ctx 0
function guandan:hud/next_card
tag @e[tag=gd.hudhand] remove gd.hudhand
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
execute if score #hud_count gd_ctx matches 1.. run function guandan:hud/line
execute if score #hud_count gd_ctx matches 0 run function guandan:hud/empty_hand
function guandan:hud/public
scoreboard players operation panel_id fbt_io = @s gd_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s gd_panel
