$tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(from).name","entity":"@s","interpret":true},{"text":" 向 ","color":"gray"},{"nbt":"data.catan.p$(to).name","entity":"@s","interpret":true},{"text":" 提出交易，等待答复。","color":"aqua"}]
$execute as @a[tag=ca.audience,scores={ca_side=$(to)}] run function catan:feedback/subtitle {"text":{"text":"收到交易请求：手持交易物品按Q查看","color":"aqua"}}
$execute as @a[tag=ca.audience,scores={ca_side=$(to)}] run function catan:hud/notice {"text":{"text":"有人向你报价，请使用“玩家交易”查看报价并接受或拒绝。","color":"aqua"}}
