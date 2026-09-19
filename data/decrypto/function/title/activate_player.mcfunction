# 当前执行者为本桌玩家，每人使用独立面板以显示自己所属阵营的敌方笔记。
execute unless score @s dc_prev_panel matches 0.. run function decrypto:title/save_previous
execute unless entity @s[tag=cgt_anim_text.replace.actionbar] run tag @s add dc.owns_actionbar_block
tag @s add cgt_anim_text.replace.actionbar
function title:new_panel {id:"@s dc_panel"}
scoreboard players operation @s title.panel_id = @s dc_panel
