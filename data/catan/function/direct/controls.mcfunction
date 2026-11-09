function catan:direct/buildings
function catan:direct/control {slot:3,action:23,label:"购买发展卡〔Q两次〕",model:"minecraft:book"}
function catan:direct/control {slot:4,action:210,label:"银行／港口兑换〔Q〕",model:"minecraft:gold_ingot"}
function catan:direct/control {slot:5,action:200,label:"玩家交易／查看报价〔Q〕",model:"minecraft:emerald"}
function catan:direct/control {slot:6,action:29,label:"结束回合〔Q两次〕",model:"minecraft:lime_dye"}
function catan:direct/control {slot:7,action:10,label:"投骰〔Q〕",model:"card:aeroplane_chess/dice"}
function catan:direct/control {slot:8,action:999,label:"取消选择〔Q〕",model:"minecraft:barrier"}
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run function catan:direct/control {slot:6,action:31,label:"放弃剩余免费道路〔Q两次〕",model:"minecraft:barrier"}
execute if score @s ca_edit matches 1 run function catan:direct/resource_controls
execute if score @s ca_edit matches 3..5 run function catan:direct/resource_controls
execute if entity @e[tag=ca.current,scores={ca_state=7},limit=1] if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run function catan:direct/victims
