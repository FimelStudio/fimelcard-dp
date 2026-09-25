data modify storage decrypto:page first set value {text:""}
data modify storage decrypto:page second set value {text:""}
$data modify storage decrypto:page first set from storage decrypto:page rows[$(first)]
$data modify storage decrypto:page second set from storage decrypto:page rows[$(second)]
# 复制实际组件到面板，不能留下指向共享临时缓冲区的动态NBT引用。
$data modify storage title:io text set value [{text:'  ',bold:false},{text:'$(digit):',color:'gold',shadow_color:0}]
data modify storage title:io text append from storage decrypto:page first
$data modify storage title:io y set value $(y)
data modify storage title:io x set value 24.0d
function title:new_text
data modify storage title:io text set value [{text:'  ',bold:false},{text:'    ',bold:false}]
data modify storage title:io text append from storage decrypto:page second
data modify storage title:io dy set value -14.0d
data modify storage title:io x set value 24.0d
function title:new_text
