$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:9} run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] ",color:"gold"},$(owner),{text:" · $(name)掷出$(die)点",color:"yellow"}]
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:6} run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] ",color:"gold"},$(owner),{text:" · $(name)冲过终点！",color:"green"}]
$execute if predicate {type:"minecraft:int_value_check",value:$(kind),test:7} run tellraw @a[tag=ma.audience] [{text:"[胡闹运动会] ",color:"gold"},$(owner),{text:" · $(name)积分变化$(amount)分",color:"aqua"}]
