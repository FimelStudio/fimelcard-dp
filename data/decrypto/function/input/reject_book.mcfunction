tellraw @a[tag=dc.submitter,limit=1] [{text:'[谍报风云] ',color:'aqua'},{text:'提交失败：提示册必须恰好3页，每页一条且不能为空。书已退回脚边，拾起后可继续修改。',color:'red'}]
tag @e[type=minecraft:item,tag=dc.submitted_book,limit=1] add dc.book_rejected
data merge entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] {PickupDelay:0s}
data modify entity @e[type=minecraft:item,tag=dc.submitted_book,limit=1] Owner set from storage decrypto:input submitter_uuid
execute at @a[tag=dc.submitter,limit=1] run tp @e[type=minecraft:item,tag=dc.submitted_book,limit=1] ~ ~0.5 ~
