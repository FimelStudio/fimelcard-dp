data modify storage catan:feedback event set from entity @s data.catan.last
data modify storage catan:feedback event.label set value "完成操作"
execute if data storage catan:feedback event{code:1} run data modify storage catan:feedback event.label set value "放置初始村庄"
execute if data storage catan:feedback event{code:2} run data modify storage catan:feedback event.label set value "放置初始道路"
execute if data storage catan:feedback event{code:10} run data modify storage catan:feedback event.label set value "投掷骰子"
execute if data storage catan:feedback event{code:11} run data modify storage catan:feedback event.label set value "完成弃牌"
execute if data storage catan:feedback event{code:12} run data modify storage catan:feedback event.label set value "移动强盗"
execute if data storage catan:feedback event{code:13} run data modify storage catan:feedback event.label set value "偷取资源"
execute if data storage catan:feedback event{code:20} run data modify storage catan:feedback event.label set value "修建道路"
execute if data storage catan:feedback event{code:21} run data modify storage catan:feedback event.label set value "建造村庄"
execute if data storage catan:feedback event{code:22} run data modify storage catan:feedback event.label set value "升级城市"
execute if data storage catan:feedback event{code:23} run data modify storage catan:feedback event.label set value "购买了一张发展卡"
execute if data storage catan:feedback event{code:29} run data modify storage catan:feedback event.label set value "结束回合"
execute if data storage catan:feedback event{code:30} run data modify storage catan:feedback event.label set value "使用发展卡"
execute if data storage catan:feedback event{code:31} run data modify storage catan:feedback event.label set value "结束免费修路"
execute if data storage catan:feedback event{code:40} run data modify storage catan:feedback event.label set value "发起交易"
execute if data storage catan:feedback event{code:41} run data modify storage catan:feedback event.label set value "接受交易"
execute if data storage catan:feedback event{code:42} run data modify storage catan:feedback event.label set value "拒绝或撤销交易"
execute if data storage catan:feedback event{code:50} run data modify storage catan:feedback event.label set value "与银行／港口交换资源"
execute if data storage catan:feedback event{code:30,target:0} run data modify storage catan:feedback event.label set value "使用骑士"
execute if data storage catan:feedback event{code:30,target:1} run data modify storage catan:feedback event.label set value "使用修路"
execute if data storage catan:feedback event{code:30,target:2} run data modify storage catan:feedback event.label set value "使用垄断"
execute if data storage catan:feedback event{code:30,target:3} run data modify storage catan:feedback event.label set value "使用丰收"
execute unless data storage catan:feedback event{code:0} unless data storage catan:feedback event{code:90} unless data storage catan:feedback event{code:10} unless data storage catan:feedback event{code:13} unless data storage catan:feedback event{code:40} run function catan:feedback/log with storage catan:feedback event
execute if data storage catan:feedback event{code:10} run function catan:feedback/dice with entity @s data.catan
execute if data storage catan:feedback event{code:13} run function catan:feedback/stolen with storage catan:feedback event
execute if data storage catan:feedback event{code:40} run function catan:feedback/offer with entity @s data.catan.trade
data modify storage catan:feedback production set from entity @s data.catan.last.production
execute if data storage catan:feedback production[0] run function catan:feedback/production
function catan:feedback/awards
