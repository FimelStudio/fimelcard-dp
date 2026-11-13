function catan:direct/control {slot:0,action:900,label:"木材〔Q选择〕",model:"card:catan/resource/wood"}
function catan:direct/control {slot:1,action:901,label:"砖块〔Q选择〕",model:"card:catan/resource/brick"}
function catan:direct/control {slot:2,action:902,label:"羊毛〔Q选择〕",model:"card:catan/resource/wool"}
function catan:direct/control {slot:3,action:903,label:"粮食〔Q选择〕",model:"card:catan/resource/grain"}
function catan:direct/control {slot:4,action:904,label:"矿石〔Q选择〕",model:"card:catan/resource/ore"}
function catan:direct/control {slot:5,action:998,label:"撤销一张待弃资源〔Q〕",model:"minecraft:arrow"}
execute if score @s ca_edit matches 3 run function catan:direct/control {slot:6,action:352,label:"确认兑换〔Q〕",model:"minecraft:lime_dye"}
execute if score @s ca_edit matches 4 run function catan:direct/control {slot:6,action:353,label:"确认垄断〔Q〕",model:"minecraft:lime_dye"}
execute if score @s ca_edit matches 5 run function catan:direct/control {slot:6,action:354,label:"确认丰收〔Q〕",model:"minecraft:lime_dye"}
