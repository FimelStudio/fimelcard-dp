# 当前执行者为本桌玩家，每人使用独立面板以显示自己所属阵营的敌方笔记。
execute unless score @s dc_prev_panel matches 0.. run function decrypto:title/save_previous
execute unless entity @s[tag=fimel.anim_text.replace.actionbar] run tag @s add dc.owns_actionbar_block
tag @s add fimel.anim_text.replace.actionbar
function fimel_title:new_panel {id:"@s dc_panel"}
scoreboard players operation @s fbt_panel = @s dc_panel
