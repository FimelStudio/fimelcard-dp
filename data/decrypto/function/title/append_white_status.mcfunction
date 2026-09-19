data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io text set value [{text:'    ',bold:false},{text:'己方：',bold:false,color:'aqua'}]
data modify storage title:io text append from storage decrypto:hud white.extra[0]
data modify storage title:io text append from storage decrypto:hud white.extra[1]
data modify storage title:io text append from storage decrypto:hud white.extra[2]
data modify storage title:io text append from storage decrypto:hud white.extra[3]
data modify storage title:io text append from storage decrypto:hud white.extra[4]
data modify storage title:io text append from storage decrypto:hud white.extra[5]
data modify storage title:io text append from storage decrypto:hud white.extra[6]
data modify storage title:io text append from storage decrypto:hud white.extra[7]
data modify storage title:io x set value 24.0d
data modify storage title:io y set value -170.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text
execute if score @s dc_encoder matches 1 as @e[type=minecraft:marker,tag=dc.controller,tag=dc.title_controller,scores={dc_state=2},limit=1] run function decrypto:title/append_white_password
