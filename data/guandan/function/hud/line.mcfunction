# 默认与斗地主同样56px；牌型多时仅压紧列间距，保持牌面大小及逐张选择。
execute if score #hud_groups gd_ctx matches 11.. run data modify storage guandan:hud hand.extra[{font:"card:guandan/spacing"}].font set value "card:guandan/spacing_dense"
data modify storage fimel_title:io text set from storage guandan:hud hand
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "card:guandan/hud_neg"
function fimel_title:new_part
# BetterTitle半宽回退必须覆盖所有牌面的独立font，否则不可见副本也会重复绘牌。
data modify storage fimel_title:io neg_text_buffer[-1].extra[0].extra[].font set value "card:guandan/hud_neg"
execute if score #hud_groups gd_ctx matches 11.. run data modify storage fimel_title:io neg_text_buffer[-1].extra[0].extra[{text:""}].font set value "card:guandan/hud_neg_dense"
data modify storage fimel_title:io tempx set value 4000
scoreboard players operation #hud_y gd_ctx = #hud_maxdepth gd_ctx
scoreboard players set #hud_step gd_ctx 20
scoreboard players operation #hud_y gd_ctx *= #hud_step gd_ctx
scoreboard players add #hud_y gd_ctx 2544
execute store result storage fimel_title:io tempy int 1 run scoreboard players get #hud_y gd_ctx
data modify storage fimel_title:io origin set value "default"
data modify storage fimel_title:io align set value "middle"
function fimel_title:code/new_text_macro with storage fimel_title:io
data modify storage fimel_title:io text_buffer set value []
data modify storage fimel_title:io neg_text_buffer set value []
