# 意外签名时保留原书内容供查看，并另发可编辑的新册。
tag @e[type=minecraft:item,tag=dc.submitted_book,limit=1] add dc.book_rejected
data merge entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] {PickupDelay:0s}
data modify entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] Owner set from storage decrypto:input submitter_uuid
execute at @a[tag=dc.submitter,limit=1] run tp @e[type=minecraft:item,tag=dc.submitted_book,limit=1] ~ ~0.5 ~
# 移除旧册提交标记，防止反复丢出领取。
data remove entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] Item.components."minecraft:custom_data".decrypto.clue
execute as @a[tag=dc.submitter,limit=1] run function decrypto:input/give_book
tellraw @a[tag=dc.submitter,limit=1] [{text:"[谍报风云] ",color:"aqua"},{text:"提示册无需签名。已补发空白提示册；原书退回脚边供查看，请重新填写后点击完成并按Q提交。",color:"yellow"}]
