# 放在全部其他玩家的手牌下方，沿用下一位玩家姓名行的间距。
function abraca:hud/hand_count
execute store result storage abraca:title self_count int 1 run scoreboard players get #hud_hand ab_ctx
function abraca:title/self_count_text with storage abraca:title
scoreboard players operation #footer_y ab_ctx = #row ab_ctx
scoreboard players set #footer_step ab_ctx -54
scoreboard players operation #footer_y ab_ctx *= #footer_step ab_ctx
scoreboard players remove #footer_y ab_ctx 18
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 8.0d
execute store result storage title:io y double 1 run scoreboard players get #footer_y ab_ctx
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text
