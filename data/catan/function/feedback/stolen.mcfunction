$execute if data storage catan:feedback event{stolen:1} run tellraw @a[tag=ca.audience] [{"text":"[卡坦岛] ","color":"gold"},{"nbt":"data.catan.p$(actor).name","entity":"@s","interpret":true},{"text":" 从 ","color":"gray"},{"nbt":"data.catan.p$(target).name","entity":"@s","interpret":true},{"text":" 处随机偷取了一张资源。","color":"gray"}]
execute if data storage catan:feedback event{stolen:0} run tellraw @a[tag=ca.audience] {text:"对方没有资源，未偷到资源。",color:"gray"}
$execute if data storage catan:feedback event{stolen:1} as @a[tag=ca.audience,scores={ca_side=$(target)}] run function catan:feedback/subtitle {"text":{"text":"强盗来袭：你失去了一张资源","color":"red"}}
$execute as @a[tag=ca.audience,scores={ca_side=$(actor)}] run function catan:feedback/subtitle {"text":{"text":"偷取结算完成，资源已同步","color":"green"}}
