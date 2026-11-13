data modify storage decrypto:guess dialog.title set value {text:"解密己方密码",color:"aqua",bold:true}
data modify storage decrypto:guess keywords set value {type:"minecraft:plain_message",width:320,contents:{text:"己方词条",color:"gold"}}
$data modify storage decrypto:guess keywords.contents set from entity @e[type=minecraft:marker,tag=dc.guess_table,limit=1] data.decrypto.keywords.$(side)
data modify storage decrypto:guess dialog.body append from storage decrypto:guess keywords
