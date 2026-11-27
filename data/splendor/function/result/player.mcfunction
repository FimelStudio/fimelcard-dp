$data modify storage splendor:result p set from entity @s data.splendor.p$(side)
$data modify storage splendor:result p.side set value $(side)
data modify storage splendor:result p.mark set value ""
$execute unless data storage splendor:result p.name run data modify storage splendor:result p.name set value {text:"玩家$(side)",color:"white"}
data modify storage splendor:result p.name.color set value "white"

$execute if data entity @s data.splendor{winners:[$(side)]} run data modify storage splendor:result p.mark set value " ★ 胜者"
execute store result storage splendor:result p.cards_count int 1 run data get storage splendor:result p.cards
execute store result storage splendor:result p.noble_count int 1 run data get storage splendor:result p.nobles
data modify storage splendor:result line set value {text:"贵族卡： ",color:"aqua",extra:[]}
data modify storage splendor:result queue set from storage splendor:result p.nobles
execute unless data storage splendor:result queue[0] run data modify storage splendor:result line.extra append value {text:"无",color:"gray"}
execute if data storage splendor:result queue[0] run function splendor:result/nobles
function splendor:result/emit
data modify storage splendor:result line set value {text:"发展卡： ",color:"aqua",extra:[]}
data modify storage splendor:result queue set from storage splendor:result p.cards
scoreboard players set #result_col sp_ctx 0
execute unless data storage splendor:result queue[0] run data modify storage splendor:result line.extra append value {text:"无",color:"gray"}
execute if data storage splendor:result queue[0] run function splendor:result/cards
execute if score #result_col sp_ctx matches 1.. run function splendor:result/emit
execute if score #result_col sp_ctx matches 0 unless data storage splendor:result p.cards[0] run function splendor:result/emit
function splendor:result/header with storage splendor:result p
scoreboard players add #result_y sp_ctx 12
