function wenfei:player/mark_audience
data modify storage wenfei:ui current set from entity @s data.wenfei.current.text
scoreboard players operation #number wq_ctx = @s wq_index
scoreboard players add #number wq_ctx 1
tellraw @a[tag=wq.audience] [{text:"[问非所答] 候选问题 ",color:"gold"},{score:{name:"#number",objective:"wq_ctx"}},{text:"/5： "},{nbt:"current",storage:"wenfei:ui"}]
tellraw @a[tag=wq.actor] {text:"手持对应分数的染料，按Q丢出评分。0最不可能，4最可能；每分只能用一次，丢出即锁定。其他人的回答显示在左上角。",color:"yellow"}
data modify storage wenfei:ui placed set from entity @s data.wenfei.placed
tellraw @a[tag=wq.actor] [{text:"已锁定：\n",color:"aqua"},{nbt:"placed[]",storage:"wenfei:ui",interpret:true,separator:{text:""}}]
clear @a[tag=wq.actor] *[minecraft:custom_data~{wenfei:{tool:"score"}}]
execute store result storage wenfei:io score_item.table int 1 run scoreboard players get @s wq_id
execute store result storage wenfei:io score_item.epoch int 1 run scoreboard players get @s wq_epoch
execute unless data entity @s data.wenfei.used.p0 run function wenfei:input/give_score {points:0,item:"white_dye",color:"white"}
execute unless data entity @s data.wenfei.used.p1 run function wenfei:input/give_score {points:1,item:"light_blue_dye",color:"aqua"}
execute unless data entity @s data.wenfei.used.p2 run function wenfei:input/give_score {points:2,item:"lime_dye",color:"green"}
execute unless data entity @s data.wenfei.used.p3 run function wenfei:input/give_score {points:3,item:"yellow_dye",color:"yellow"}
execute unless data entity @s data.wenfei.used.p4 run function wenfei:input/give_score {points:4,item:"red_dye",color:"red"}
