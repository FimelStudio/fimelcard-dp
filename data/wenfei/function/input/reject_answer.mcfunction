tellraw @s {text:"[问非所答] 请仅在第一页填写非空答案，点击完成后按Q。书已退回脚边。",color:"red"}
tag @e[tag=wq.drop,limit=1] add wq.rejected
data merge entity @e[tag=wq.drop,limit=1] {PickupDelay:0s,Motion:[0d,0d,0d]}
execute at @s run tp @e[tag=wq.drop,limit=1] ~ ~0.5 ~
