execute unless score @s dc_panel matches 1.. run function decrypto:title/activate_player

# BetterTitle公共缓冲区每次完整构建前必须清空。
data modify storage fimel_title:io panel_buffer set value []
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 24.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
execute if score @s dc_team matches 1 run function decrypto:title/load_white_notes
execute if score @s dc_team matches 2 run function decrypto:title/load_black_notes

# BetterTitle会持续接管Actionbar，因此把原本的己方词库和加密者密码一并放入左上角面板。
execute if score @s dc_team matches 1 run function decrypto:title/append_white_status
# 分队局黑队显示己方词库；三人局截密者没有己方词库，只保留合作队的敌方笔记。
execute if score @s dc_team matches 2 unless entity @s[tag=dc.interceptor] run function decrypto:title/append_black_status
# 底部电报追加到同一个面板，不能单独 title actionbar 覆盖已有笔记。
execute as @e[type=minecraft:marker,tag=dc.controller,tag=dc.title_controller,scores={dc_state=5..8}] if score @s dc_id = #ctx dc_ctx if data entity @s data.decrypto.active_clues run function decrypto:title/append_clues
scoreboard players operation panel_id fbt_io = @s dc_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s dc_panel
