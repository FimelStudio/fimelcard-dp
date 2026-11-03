execute if score @s ma_notice matches 1.. run return 0
scoreboard players set @s ma_notice 100
tellraw @s {text:"[胡闹运动会] 请腾空需要的快捷栏位置，前7格显示行动选项，第8格骰子，第9格紫色染料。",color:"yellow"}
