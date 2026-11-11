data modify storage fimel_title:io text set value [{text:'    ',bold:false},{text:'敌方笔记 · 红队（5秒翻页）',color:'red',bold:true,shadow_color:0}]
data modify storage fimel_title:io y set value -18.0d
function fimel_title:new_text
function decrypto:title/page_group {side:"black",digit:1,y:-36}
function decrypto:title/page_group {side:"black",digit:2,y:-68}
function decrypto:title/page_group {side:"black",digit:3,y:-100}
function decrypto:title/page_group {side:"black",digit:4,y:-132}
