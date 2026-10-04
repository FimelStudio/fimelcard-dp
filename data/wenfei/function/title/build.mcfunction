function wenfei:title/activate
# 每次完整重绘都清空公共缓冲；复制组件，不保留共享NBT引用。
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
data modify storage title:io text set value [{text:"    ",bold:false},{text:"本轮回答 · 每页最多四人 · 5秒翻页",color:"gold",bold:false,shadow_color:0}]
data modify storage title:io y set value -18.0d
function title:new_text
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
scoreboard players operation panel_id title.io = @s wq_panel
function title:replace_panel
scoreboard players operation @s title.panel_id = @s wq_panel
