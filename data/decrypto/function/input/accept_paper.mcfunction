# 纸张必须经过铁砧改名，未改名的纸张退回给加密者。
execute unless data entity @e[type=minecraft:item,tag=dc.submitted_paper,limit=1] Item.components."minecraft:custom_name" run function decrypto:input/return_paper
execute unless data entity @e[type=minecraft:item,tag=dc.submitted_paper,limit=1] Item.components."minecraft:custom_name" run return 0
data modify storage decrypto:input name set from entity @e[type=minecraft:item,tag=dc.submitted_paper,limit=1] Item.components."minecraft:custom_name"
tellraw @a[tag=dc.submitter,limit=1] [{text:'[谍报风云] ',color:'aqua'},{text:'已提交提示：',color:'green'},{nbt:'name',storage:'decrypto:input',color:'yellow'}]
# 提示可重复；仅在该队正式念出提示时，由 reveal_white / reveal_black 公开。
function decrypto:input/save_prompt
kill @e[type=minecraft:item,tag=dc.submitted_paper,limit=1]
