execute unless score @s dc_panel matches 1.. run function decrypto:title/activate_player

# BetterTitle公共缓冲区每次完整构建前必须清空。
data modify storage title:io panel_buffer set value []
data modify storage title:io text_buffer set value []
data modify storage title:io neg_text_buffer set value []
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 24.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
execute if score @s dc_team matches 1 run function decrypto:title/load_white_notes
execute if score @s dc_team matches 2 run function decrypto:title/load_black_notes

# BetterTitle会持续接管Actionbar，因此把原本的己方词库和加密者密码一并放入左上角面板。
execute if score @s dc_team matches 1 run function decrypto:title/append_white_status
# 四人局黑队显示己方词库；三人局截密者没有己方词库，只保留合作队的敌方笔记。
execute if score @s dc_team matches 2 unless entity @s[tag=dc.interceptor] run function decrypto:title/append_black_status
scoreboard players operation panel_id title.io = @s dc_panel
function title:replace_panel
scoreboard players operation @s title.panel_id = @s dc_panel
