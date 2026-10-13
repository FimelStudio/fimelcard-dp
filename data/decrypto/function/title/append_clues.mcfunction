# 当前执行者为本桌控制器；将文本固化到面板，避免跨桌共享storage造成串内容。
data modify storage fimel_title:io text set value [{text:'电报提示 ① ',color:'gold'}]
data modify storage fimel_title:io text append from entity @s data.decrypto.active_clues.1
data modify storage fimel_title:io text append value {text:'  ② ',color:'gold'}
data modify storage fimel_title:io text append from entity @s data.decrypto.active_clues.2
data modify storage fimel_title:io text append value {text:'  ③ ',color:'gold'}
data modify storage fimel_title:io text append from entity @s data.decrypto.active_clues.3
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 0.0d
data modify storage fimel_title:io y set value 0.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "middle"
data modify storage fimel_title:io origin set value "default"
function fimel_title:new_text
