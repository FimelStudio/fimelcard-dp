data modify storage decrypto:page first set value {text:""}
data modify storage decrypto:page second set value {text:""}
$data modify storage decrypto:page first set from storage decrypto:page rows[$(first)]
$data modify storage decrypto:page second set from storage decrypto:page rows[$(second)]
# 复制实际组件到面板，不能留下指向共享临时缓冲区的动态NBT引用。
$data modify storage fimel_title:io text set value [{text:'  ',bold:false},{text:'$(digit):',color:'gold',shadow_color:0}]
data modify storage fimel_title:io text append from storage decrypto:page first
$data modify storage fimel_title:io y set value $(y)
data modify storage fimel_title:io x set value 24.0d
function fimel_title:new_text
data modify storage fimel_title:io text set value [{text:'  ',bold:false},{text:'    ',bold:false}]
data modify storage fimel_title:io text append from storage decrypto:page second
data modify storage fimel_title:io dy set value -14.0d
data modify storage fimel_title:io x set value 24.0d
function fimel_title:new_text
