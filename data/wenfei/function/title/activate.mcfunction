execute unless score @s wq_prev_panel matches 0.. run function wenfei:title/save_previous
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add wq.owns_actionbar_block
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s wq_panel"}
scoreboard players operation @s fbt_panel = @s wq_panel
