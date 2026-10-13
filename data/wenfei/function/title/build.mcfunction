function wenfei:title/activate
# 每次完整重绘都清空公共缓冲；复制组件，不保留共享NBT引用。
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
data modify storage fimel_title:io text set value [{text:"    ",bold:false},{text:"本轮回答 · 每页最多四人 · 5秒翻页",color:"gold",bold:false,shadow_color:0}]
data modify storage fimel_title:io y set value -18.0d
function fimel_title:new_text
scoreboard players set #y wq_ctx -36
scoreboard players set #answer_index wq_ctx 0
function wenfei:title/group {seat:1}
function wenfei:title/group {seat:2}
function wenfei:title/group {seat:3}
function wenfei:title/group {seat:4}
function wenfei:title/group {seat:5}
function wenfei:title/group {seat:6}
function wenfei:title/group {seat:7}
function wenfei:title/group {seat:8}
scoreboard players operation panel_id fbt_io = @s wq_panel
function fimel_title:replace_panel
scoreboard players operation @s fbt_panel = @s wq_panel
