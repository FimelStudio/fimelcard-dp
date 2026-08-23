# 当前执行者是手牌 marker。字形先写入 storage，避免 mcfunction UTF-8 中混入 NUL 字节。
execute if score @s ab_spell matches 1 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 2 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 3 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 4 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 5 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 6 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 7 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 8 run data modify storage abraca:title card_piece set value {text:"",shadow_color:0}
execute if score @s ab_spell matches 1..8 run data modify storage abraca:title cards.extra append from storage abraca:title card_piece
