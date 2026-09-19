# BetterTitle稍后才解析面板组件，不能保留依赖当前执行者的score @s；先固化为storage数值。
execute store result storage decrypto:title password.1 int 1 run scoreboard players get @s dc_b1
execute store result storage decrypto:title password.2 int 1 run scoreboard players get @s dc_b2
execute store result storage decrypto:title password.3 int 1 run scoreboard players get @s dc_b3
data modify storage title:io text set value [{text:'    ',bold:false},{text:'本轮密码：',color:'gold',bold:true,shadow_color:0},{nbt:'password.1',storage:'decrypto:title',color:'yellow'},{text:' - ',color:'gray'},{nbt:'password.2',storage:'decrypto:title',color:'yellow'},{text:' - ',color:'gray'},{nbt:'password.3',storage:'decrypto:title',color:'yellow'}]
data modify storage title:io font set value "minecraft:default_mod"
data modify storage title:io neg_font set value "minecraft:default_neg"
data modify storage title:io x set value 24.0d
data modify storage title:io y set value -192.0d
data modify storage title:io dx set value 0.0d
data modify storage title:io dy set value 0.0d
data modify storage title:io align set value "left"
data modify storage title:io origin set value "up-left"
function title:new_text
