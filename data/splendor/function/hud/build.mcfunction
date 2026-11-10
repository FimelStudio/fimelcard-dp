execute unless entity @e[tag=sp.current,limit=1] run return 0
execute unless score @s sp_table = @e[tag=sp.current,limit=1] ct_id run return 0
execute unless entity @s[tag=sp.hud] run function splendor:hud/activate
execute if entity @s[tag=sp.owns_hud] run tag @s remove fimel.anim_text.replace.actionbar
tag @s remove sp.owns_hud
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
execute store result score #hud_n sp_ctx run data get entity @e[tag=sp.current,limit=1] data.splendor.n
execute if score #hud_n sp_ctx matches 1..4 run function splendor:hud/relative_row {"offset":0,"x":8,"y":-20,"origin":"up-left","align":"left"}
execute if score #hud_n sp_ctx matches 2..4 run function splendor:hud/relative_row {"offset":1,"x":-8,"y":-20,"origin":"up-right","align":"right"}
execute if score #hud_n sp_ctx matches 3..4 run function splendor:hud/relative_row {"offset":2,"x":8,"y":-76,"origin":"up-left","align":"left"}
execute if score #hud_n sp_ctx matches 4..4 run function splendor:hud/relative_row {"offset":3,"x":-8,"y":-76,"origin":"up-right","align":"right"}
execute if score @s sp_htimer matches 1.. run function splendor:hud/show_notice
execute unless score @s sp_htimer matches 1.. run function splendor:hud/status with entity @e[tag=sp.current,limit=1] data.splendor
scoreboard players operation panel_id fbt_io = @s sp_hpanel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s sp_hpanel
