execute unless score @s wq_prev_panel matches 0.. run function wenfei:title/save_previous
execute unless entity @s[tag=cgt_anim_text.replace.actionbar] run tag @s add wq.owns_actionbar_block
tag @s add cgt_anim_text.replace.actionbar
function title:new_panel {id:"@s wq_panel"}
scoreboard players operation @s title.panel_id = @s wq_panel
